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
integers_size = None
is_sorted = False
chunk_size=500
RESULT = []
DECODE = 'utf-8'
DATA_SIZE = 8192
lock = threading.Lock()

def write_result():
    global RESULT
    try:
        os.remove('result')
    except:
        pass
    f = open('result', 'a')
    print('terminou de ordenar')
    for number in RESULT:
        f.write(str(number) + '\n')
    f.close()


def slice_list():
    global integers
    lock.acquire()
    chunk = integers[0:chunk_size]
    del integers[0:chunk_size]
    lock.release()
    return chunk

def sort():
    global RESULT, integers_size, is_sorted
    while not is_sorted:
        chunk = slice_list()
        chunk.sort()
        print('ordenou em casa')
        lock.acquire()
        RESULT = sorted(RESULT + chunk)
        if len(RESULT) >= integers_size:
            print('terminou de ordenar em casa')
            is_sorted = True
            write_result()
        lock.release()

def on_new_client(clientsocket, address):
    global RESULT, peers, integers, is_sorted, integers_size
    print("Conexão com ", address," estabelecida!")
    
    # guarda o endereço e o socket responsável pela conexão
    peers.append((address[0], clientsocket))

    while not is_sorted:
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
            lock.acquire()
            RESULT = sorted(RESULT + ordered_received)

            if len(RESULT) >= integers_size:
                print('terminou de ordenar por cliente')
                is_sorted = True
                write_result()
            lock.release()
            # if len(integers) == 0:


    clientsocket.close()


def server(file_name):
    global integers_size, is_sorted
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
    
    integers_size = len(integers)
    
    # começa a ordenar aqui mesmo
    threading.Thread(target=sort).start()
    serversocket.settimeout(2)
    while not is_sorted:
        try:
            clientsocket, address = serversocket.accept()
        except socket.timeout:
            continue
            # serversocket.close()
        threading.Thread(target=on_new_client,args=(clientsocket, address)).start()
    serversocket.close()
    
