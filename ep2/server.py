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
sorted_integers = [0, 0]

def on_new_client(clientsocket, address):
    print("Conexão com ", address," estabelecida!")
    
    # guarda o endereço e o socket responsável pela conexão
    peers.append((address[0], clientsocket))
    print(peers)

    # clientsocket.send(bytes(str(50000), "utf-8"))
    # time.sleep(5)
    for i in range(0, 49999):            
        clientsocket.send(bytes(str(integers[i]), "utf-8"))
        clientsocket.send(bytes(str(","), "utf-8"))
    time.sleep(10)
    clientsocket.settimeout(2)
    all_data = ""
    while True:
        try:
            data = clientsocket.recv(1024).decode("UTF-8")
            if(len(data) > 4):
                all_data = all_data + data
                print(data)
                print("\n")
            else:
                break
        except socket.timeout:
            print("PQ NAO CHEGA AQUI??")
    sorted_chunk = all_data.split(",")
    sorted_chunk.pop()
    # print(sorted_chunk)
    sorted_integers[0] = sorted_chunk
    print(sorted_integers[0])


def server(file_name):
    HOST = "0.0.0.0"
    PORT = 8000
    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    serversocket.bind((HOST, PORT))
    serversocket.listen(10)

    # limpa o arquivo de hosts
    try:
        os.remove('hosts')
    except:
        pass

    #socket do servidor fica aceitando conexões
    #colocando os números em um array
    f = open(file_name, "r")
    for i in f:
        integers.append(int(i.strip()))
    # print(integers)

    #se 1, ordenado, cc 0
    #[0] - 0 até 49.999
    #[1] - 50.000 até 100.000
    
    serversocket.settimeout(2)
    while True:
        try:
            clientsocket, address = serversocket.accept()
        except socket.timeout:
            continue
            # serversocket.close()
        threading.Thread(target=on_new_client,args=(clientsocket, address)).start()
