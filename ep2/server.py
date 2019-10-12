#!/usr/bin/env python3

import socket
import sys
import time
import network

HOST = '0.0.0.0'
PORT = 63234

def client():
    print('client')
    ip = network.main_server_ip()
    if not ip:
        exit()

def server():
    print('server')
    ip = network.my_ip()
    print(ip)

def main():
    if(len(sys.argv) == 1):
        client()
    elif(len(sys.argv) == 2):
        server()
    else:
        print('Numero invalido de argumentos')

if __name__ == "__main__":
    main()