#!/usr/bin/env python3
import socket
import os
import sys
import network
import time
import errno

peers = []
actions = []

def server():
    HOST = "0.0.0.0"
    PORT = 8000
    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    serversocket.bind((HOST, PORT))
    serversocket.listen(10)

    #colocando os números em um array
    #ARRUMAR O ÚLTIMO ELEMENTO QUE TEM O ÚLTIMO CARACTERE SENDO CORTADO!!
    f = open("100m.txt", "r")
    integers = []
    for i in f:
        integers.append(i[:-1])
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
            print("Conexão com ", address," estabelecida!")
            peers.append(address)

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



        # clientsocket.send(bytes("Oh, I didn't see you there. Hello!", "utf-8"))


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
        server()
    else:
        print('Numero invalido de argumentos')

if __name__ == "__main__":
    main()