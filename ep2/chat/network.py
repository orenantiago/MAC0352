import socket
import re

def my_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("8.8.8.8", 80))
    ip = s.getsockname()[0]
    s.close()
    return ip

def main_server_ip():
    pattern = re.compile("^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$")

    try:
        f = open('ep2.conf', 'r')
        ip = f.readline().strip()
        if not pattern.match(ip):
            print("endereço ip inválido")
            ip = None
        f.close()
        return ip

    except:
        print("não foi possivel ler o arquivo de configuração")
        print("deve existir um arquivo de configuração chamado ep2.conf com o ip da máquina principal da rede no formato xxx.xxx.xxx.xxx")
        return None