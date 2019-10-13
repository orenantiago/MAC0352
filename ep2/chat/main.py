#!/usr/bin/env python3
import socket
import os
import sys
import network
import time
import errno
import threading

peers = []
actions = []
integers = []

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
    sorted_integers = [0, 0]

    while True:
        try:
            clientsocket, address = serversocket.accept()
        except:
            serversocket.close()

        threading.Thread(target=on_new_client,args=(clientsocket, address)).start()
        # childpid = os.fork()
        # if childpid == 0:
        #     serversocket.close()
        #     print("Conexão com ", address," estabelecida!")
        #     if not network.add_host(address[0]):
        #         exit(1)

        #     # clientsocket.send(bytes(str(50000), "utf-8"))
        #     # time.sleep(5)
        #     for i in range(0, 49999):            
        #         clientsocket.send(bytes(str(integers[i]), "utf-8"))
        #         clientsocket.send(bytes(str(","), "utf-8"))

            # while True:

            #     # text = input("Digite o texto para o cliente > ")
            #     # clientsocket.send(bytes(text, "utf-8"))
            #     data = clientsocket.recv(1024)
            #     print(data.decode("UTF-8"))



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


def main():
    if(len(sys.argv) == 1):
        client()
    elif(len(sys.argv) == 2):
        server(sys.argv[1])
    else:
        print('Numero invalido de argumentos')

if __name__ == "__main__":
    main()