import socket
import sys
import errno
from time import sleep

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(("127.0.0.1", 8000))
s.settimeout(2)

integers = ""
while True:
    try:
        data = s.recv(1024).decode("UTF-8")
        integers = integers + data
    except socket.timeout:
        break
integers_list = integers.split(",")
# for i in integers_list:
#     i = int(i)
print(integers_list)