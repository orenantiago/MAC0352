#!/usr/bin/env python3
#Estamos utilizando o protocolo TCP!
#   Explicar a motivação nos slides

import socket
import os
import sys
import network

#Como vamos fazer com o líder
#Protocolo para passar informações de um programa para outro
#Detecção de máquinas conectadas
#Algoritmo de ordenação


#Roteiro
#1. Criar um socket para cada programa, precisamos que cada programa seja um servidor e um cliente ao mesmo tempo
#2. A primeira máquina entra em funcionamento, ela vai precisar conhecer todas as outras máquinas que entrarem (são os peers), essa
#primeira máquina nunca deixa de funcionar
#O problema aqui parece ser: a primeira máquina, a que nunca desconecta, vai conversar com aqueles programa que tentarem se conectar,
#então ela vai saber quem está tentando se conectar, vai conhecer esses IPs. Só que essa máquina que está tentando se conectar também precisa
#saber os IPs das demais máquinas conectadas, isso não poderia ser feito com a máquina que não desliga nunca fornecendo essa informação?
#3. Como será feita a ordenação?
#4.

#lista com as máquinas conectadas na rede
peers = []
actions = []

#faz o papel de mandar arquivos?
def server():
    HOST = "0.0.0.0"
    PORT = 8002
    #criando o socket do servidor
    #AF_INET = IPv4
    #SOCK_STREAM = TCP
    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    #binding esse socket com uma porta (hardcoded)
    serversocket.bind((HOST, PORT))

    #número de conexões máximo que podemos ouvir
    serversocket.listen(10)

    # limpa o arquivo de hosts
    try:
        os.remove('hosts')
    except:
        pass

    #socket do servidor fica aceitando conexões
    while True:
        #lidando com novas conexões
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

            while True:

                # text = input("Digite o texto para o cliente > ")
                # clientsocket.send(bytes(text, "utf-8"))
                data = clientsocket.recv(1024)
                print(data.decode("UTF-8"))
                # clientsocket.send(bytes('top'))
        
        clientsocket.close()


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
        server()
    else:
        print('Numero invalido de argumentos')

if __name__ == "__main__":
    main()