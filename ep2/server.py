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
chunk_size=10
RESULT = []
DECODE = 'utf-8'
DATA_SIZE = 1024

def slice_list():
    global integers
    chunk = integers[0:chunk_size]
    del integers[0:chunk_size]
    return chunk

def sort():
    global RESULT
    while len(integers) > 0:
        chunk = slice_list()
        chunk.sort()
        print('ordenou em casa')
        RESULT = sorted(RESULT + chunk)
        time.sleep(0.5)


def on_new_client(clientsocket, address):
    global RESULT, peers
    print("Conexão com ", address," estabelecida!")
    
    # guarda o endereço e o socket responsável pela conexão
    peers.append((address[0], clientsocket))

    while len(integers) > 0:
        # verifica se pode mandar uma lista para ordenar
        clientsocket.send(bytes('CAN_SEND', DECODE))
        response = clientsocket.recv(DATA_SIZE).decode(DECODE).split()
        if response[0] == 'CAN':
            chunk = slice_list()
            # envia o trecho de lista para o cliente
            for number in chunk:
                clientsocket.send(bytes(str(number) + ' ', "utf-8"))
            clientsocket.send(bytes('STOP', "utf-8"))

            ordered_received = []
            # recebe a lista de volta ordenada
            while True:
                response = clientsocket.recv(DATA_SIZE).decode(DECODE).split()
                if 'STOP' in response:
                    response.pop()
                    ordered_received.extend([ int(x) for x in response])
                    break
                else:
                    ordered_received.extend([ int(x) for x in response])

            # merge no que já tem de ordenado
            print('ordenou fora de casa')
            RESULT = sorted(RESULT + ordered_received)




    # clientsocket.send(bytes(str(50000), "utf-8"))
    # time.sleep(5)
    # for i in range(0, 49999):            
    #     clientsocket.send(bytes(str(integers[i]), "utf-8"))
    #     clientsocket.send(bytes(str(","), "utf-8"))


def server(file_name):
    HOST = "0.0.0.0"
    PORT = 8000
    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    serversocket.bind((HOST, PORT))
    serversocket.listen(10)

    #socket do servidor fica aceitando conexões
    #colocando os números em um array
    f = open(file_name, "r")
    for i in f:
        integers.append(int(i.strip()))
    # print(integers)

    #se 1, ordenado, cc 0
    #[0] - 0 até 49.999
    #[1] - 50.000 até 100.000
    sorted_integers = [0, 0]
    
    # começa a ordenar aqui mesmo
    threading.Thread(target=sort).start()
    while True:
        try:
            clientsocket, address = serversocket.accept()
        except:
            serversocket.close()

        threading.Thread(target=on_new_client,args=(clientsocket, address)).start()