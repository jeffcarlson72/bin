#!/usr/bin/python3

import hmac
import struct
import sys
import time
from Crypto.Hash import SHA256
from socket import gethostbyname, inet_aton, socket, AF_INET, SOCK_DGRAM

if len(sys.argv) != 5:
    print(f"Usage:  {sys.argv[0]} <secret> <src-ip> <dst-ip> <knock-port>")
    sys.exit(1)

m = hmac.new(bytes(sys.argv[1], 'utf-8'), digestmod=SHA256)
m.update(inet_aton(gethostbyname(sys.argv[2])))
m.update(struct.pack("i", (int)(time.time() / 60)))

s = socket(AF_INET, SOCK_DGRAM)
s.connect((sys.argv[3], (int)(sys.argv[4])))
s.send(bytes(m.hexdigest() + "\n", 'utf-8'))
s.close()
