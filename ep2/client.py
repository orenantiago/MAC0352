#!/usr/bin/env python3
import socket
import os
import network
import time
import errno
import threading

peers = []
actions = []
integers = []


#faz o papel de receber arquivos?
def client():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    # tenta conectar durante 5 segundos
    s.settimeout(5)
    # pega o ip da máquina principal que está no arquivo ep2.conf
    main_host = network.main_server_ip()
    try:
        s.connect((main_host, 8000))
    except:
        print("não deu para se conectar com a máquina principal :/")
        exit()

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
