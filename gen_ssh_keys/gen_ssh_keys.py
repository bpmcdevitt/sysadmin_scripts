#!/usr/bin/env python3
# generate a public / private ssh keypair

from Crypto.PublicKey import RSA


def gen_ssh_keypair():
    """ Generate an RSA private / public keypair """
    key = RSA.generate(2048)

    # generate private key - output to file
    with open('rsa_privkey.pem', 'wb') as privkey:
        privkey.write(key.exportKey())

    # generate public key - output to file
    with open('rsa_pubkey.pem', 'wb') as pubkey:
        pubkey.write(key.publickey().exportKey())

    return 0


gen_ssh_keypair()
