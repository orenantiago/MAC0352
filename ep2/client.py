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
DECODE = 'utf-8'
DATA_SIZE = 8192

#faz o papel de receber arquivos?
def client():
    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    # tenta conectar durante 5 segundos
    serversocket.settimeout(5)
    # pega o ip da máquina principal que está no arquivo ep2.conf
    main_host = network.main_server_ip()
    try:
        serversocket.connect((main_host, 8000))
    except:
        print("não deu para se conectar com a máquina principal :/")
        exit()

    integers = ""
    while True:
        try:
            data = serversocket.recv(DATA_SIZE).decode(DECODE)
                
            integers = integers + data
        except socket.timeout:
            break
        if data == 'CAN_SEND':
            serversocket.send(bytes('CAN', DECODE))
            numbers = []
            while True:
                response = serversocket.recv(DATA_SIZE).decode(DECODE).split()
                if 'STOP' in response:
                    response.pop()
                    numbers.extend([ int(x) for x in response])
                    break
                else:
                    numbers.extend([ int(x) for x in response])
            # ordena o que recebe
            numbers.sort()
            for number in numbers:
                serversocket.send(bytes(str(number) + ' ', "UTF-8"))
            serversocket.send(bytes('STOP', "UTF-8"))