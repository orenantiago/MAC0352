import socket
import sys

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(("127.0.0.1", 8002))

while True:
    text = input("Digite o texto para o servidor > ")
    if (text == "exit"):
        sys.exit(0)
    s.send(bytes(text, "utf-8"))
