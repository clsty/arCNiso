#!/bin/bash
set -e
cd $(dirname $0)
# Dependency: efitools
# https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot#Creating_keys
# Create a GUID for owner identification
uuidgen --random >GUID.txt

# Platform key
openssl req -newkey rsa:4096 -nodes -keyout PK.key -new -x509 -sha256 -days 3650 -subj "/CN=arCNiso Platform Key/" -out PK.crt
openssl x509 -outform DER -in PK.crt -out PK.cer
cert-to-efi-sig-list -g "$(<GUID.txt)" PK.crt PK.esl
sign-efi-sig-list -g "$(<GUID.txt)" -k PK.key -c PK.crt PK PK.esl PK.auth
sign-efi-sig-list -g "$(<GUID.txt)" -c PK.crt -k PK.key PK /dev/null noPK.auth

# Key Exchange Key
openssl req -newkey rsa:4096 -nodes -keyout KEK.key -new -x509 -sha256 -days 3650 -subj "/CN=arCNiso Key Exchange Key/" -out KEK.crt
openssl x509 -outform DER -in KEK.crt -out KEK.cer
cert-to-efi-sig-list -g "$(<GUID.txt)" KEK.crt KEK.esl
sign-efi-sig-list -g "$(<GUID.txt)" -k PK.key -c PK.crt KEK KEK.esl KEK.auth

# Signature Database key
openssl req -newkey rsa:4096 -nodes -keyout db.key -new -x509 -sha256 -days 3650 -subj "/CN=arCNiso Signature Database key/" -out db.crt
openssl x509 -outform DER -in db.crt -out db.cer
cert-to-efi-sig-list -g "$(<GUID.txt)" db.crt db.esl
sign-efi-sig-list -g "$(<GUID.txt)" -k KEK.key -c KEK.crt db db.esl db.auth
