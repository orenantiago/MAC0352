# Copyright 2012 James McCauley
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at:
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""
This component is for use with the OpenFlow tutorial.

It acts as a simple hub, but can be modified to act like an L2
learning switch.

It's roughly similar to the one Brandon Heller did for NOX.
"""

from pox.core import core
import pox.openflow.libopenflow_01 as of
import re

log = core.getLogger()



class Tutorial (object):
  """
  A Tutorial object is created for each switch that connects.
  A Connection object for that switch is passed to the __init__ function.
  """
  def __init__ (self, connection, blocked_ports, blocked_srcs, blocked_dsts, blocked_protocol):
    # Keep track of the connection to the switch so that we can
    # send it messages!
    self.connection = connection
    self.blocked_ports = blocked_ports
    self.blocked_srcs = blocked_srcs
    self.blocked_dsts = blocked_dsts
    self.blocked_protocol = blocked_protocol

    # This binds our PacketIn event listener
    connection.addListeners(self)

    # Use this table to keep track of which ethernet address is on
    # which switch port (keys are MACs, values are ports).
    self.mac_to_port = {}


  def resend_packet (self, packet_in, out_port):
    """
    Instructs the switch to resend a packet that it had sent to us.
    "packet_in" is the ofp_packet_in object the switch had sent to the
    controller due to a table-miss.
    """
    msg = of.ofp_packet_out()
    msg.data = packet_in

    # Add an action to send to the specified port
    action = of.ofp_action_output(port = out_port)
    msg.actions.append(action)

    # Send message to switch
    self.connection.send(msg)


  def act_like_hub (self, packet, packet_in):
    """
    Implement hub-like behavior -- send all packets to all ports besides
    the input port.
    """

    # We want to output to all ports -- we do that using the special
    # OFPP_ALL port as the output port.  (We could have also used
    # OFPP_FLOOD.)
    self.resend_packet(packet_in, of.OFPP_ALL)

    # Note that if we didn't get a valid buffer_id, a slightly better
    # implementation would check that we got the full data before
    # sending it (len(packet_in.data) should be == packet_in.total_len)).


  def act_like_switch (self, packet, packet_in):
    """
    Implement switch-like behavior.
    """


    # Here's some psuedocode to start you off implementing a learning
    # switch.  You'll need to rewrite it as real Python code.

    # Learn the port for the source MAC
    src = str(packet.src)
    dst = str(packet.dst)
    in_port = packet_in.in_port
    self.mac_to_port[src] = in_port
    #if port associated with the destination MAC of the packet is known:
    if dst in self.mac_to_port:
      # Send packet out the associated port
      # self.resend_packet(packet_in, self.mac_to_port[dst])

      # Once you have the above working, try pushing a flow entry
      # instead of resending the packet (comment out the above and
      # uncomment and complete the below.)
      out_port = self.mac_to_port[dst]

      log.debug("Installing flow...")
      log.debug("From port: " + str(in_port) + " to port: " + str(out_port))
      # Maybe the log statement should have source/destination/port?
      msg = of.ofp_flow_mod()
      
      # Set fields to match received packet
      msg.match = of.ofp_match.from_packet(packet)
      #< Set other fields of flow_mod (timeouts? buffer_id?) >
      msg.data = packet_in
      msg.match.in_port = in_port
      #< Add an output action, and send -- similar to resend_packet() >
      msg.actions.append(of.ofp_action_output(port=out_port))
      self.connection.send(msg)
    else:
      # Flood the packet out everything but the input port
      # This part looks familiar, right?
      self.resend_packet(packet_in, of.OFPP_ALL)


  def _handle_PacketIn (self, event):
    """
    Handles packet in messages from the switch.
    """

    packet = event.parsed # This is the parsed packet data.
    if not packet.parsed:
      log.warning("Ignoring incomplete packet")
      return

    packet_in = event.ofp # The actual ofp_packet_in message.

    # Comment out the following line and uncomment the one after
    # when starting the exercise.
    #self.act_like_hub(packet, packet_in)
    self.act_like_switch(packet, packet_in)



def launch ():
  """
  Starts the component
  """
  def start_switch (event):
    log.debug("Controlling %s" % (event.connection,))
    blocked_ports = get_blocked_ports()
    blocked_srcs = get_blocked_ips("srcs")
    blocked_dsts = get_blocked_ips("dsts")
    blocked_protocol = get_blocked_protocol()
    Tutorial(event.connection, blocked_ports, blocked_srcs, blocked_dsts, blocked_protocol)
  core.openflow.addListenerByName("ConnectionUp", start_switch)

def get_blocked_ports():
  ports = []
  try:
    file = open("blocked_ports", "r")
    for line in file:
      ports.append(int(line.strip()))
  except:
    pass
  return ports

def get_blocked_protocol():
  protocol = None
  try:
    file = open("blocked_protocol", "r")
    line = file.readline().strip()
    if line == "TCP" or line == "UDP":
      protocol = line
    else:
      print("Invalid protocol: {}".format(line))
  except:
    pass
  return protocol

def get_blocked_ips(side):
  pattern = re.compile("^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$")
  ips = []
  try:
    file = open("blocked_{}".format(side), "r")
    for line in file:
      ip = line.strip()
      if not pattern.match(ip):
        print("Invalid IP address: {}".format(ip))
      else:
        ips.append(ip)
  except:
    pass
  return ips
