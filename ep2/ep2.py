#!/usr/bin/env python3
import client
import server
import sys

def main():
    if(len(sys.argv) == 1):
        client.client()
    elif(len(sys.argv) == 2):
        server.server(sys.argv[1], 0)

    elif(len(sys.argv) == 3):
        if (sys.argv[1] == "-debug"):
            server.server(sys.argv[2], 1)
        else:
            server.server(sys.argv[2], 0)
    else:
        print('Numero invalido de argumentos')

if __name__ == "__main__":
    main()