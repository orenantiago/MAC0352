#!/usr/bin/env python3
import socket
import os
import sys
import network
import time

peers = []
actions = []

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
    integers = []
    for i in f:
        integers.append(int(i.strip()))
    print(integers)

    #se 1, ordenado, cc 0
    #[0] - 0 até 49.999
    #[1] - 50.000 até 100.000
    sorted_integers = [0, 0]

    while True:
        try:
            clientsocket, address = serversocket.accept()
        except:
            serversocket.close()


        childpid = os.fork()
        if childpid == 0:
            serversocket.close()
            print("Conexão com ", address," estabelecida!")
            if not network.add_host(address[0]):
                exit(1)

            # clientsocket.send(bytes(str(50000), "utf-8"))
            # time.sleep(5)
            for i in range(0, 49999):            
                clientsocket.send(bytes(str(integers[i]), "utf-8"))
                clientsocket.send(bytes(str(","), "utf-8"))

            # while True:

            #     # text = input("Digite o texto para o cliente > ")
            #     # clientsocket.send(bytes(text, "utf-8"))
            #     data = clientsocket.recv(1024)
            #     print(data.decode("UTF-8"))
        clientsocket.close()

        # clientsocket.send(bytes("Oh, I didn't see you there. Hello!", "utf-8"))


#faz o papel de receber arquivos?
def client():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    # tenta conectar durante 5 segundos
    s.settimeout(5)
    # pega o ip da máquina principal que está no arquivo ep2.conf
    main_host = network.main_server_ip()
    try:
        s.connect((main_host, 8002))
    except:
        print("não deu para se conectar com a máquina principal :/")
        exit()

    while True:
        text = input("Digite o texto para o servidor > ")
        if (text == "exit"):
            sys.exit(0)
        s.send(bytes(text, "utf-8"))

def main():
    if(len(sys.argv) == 1):
        client()
    elif(len(sys.argv) == 2):
        server(sys.argv[1])
    else:
        print('Numero invalido de argumentos')

if __name__ == "__main__":
    main()