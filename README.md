
# Image Encrypter

A GPG Based Image Encrypter


## Basic Setup

i) Create the gpg public and private key 

```bash
  gpg --full-generate-key
```
ii) Public Key Export
```bash
  gpg --output my_public_key.asc --armor --export email@email.com
```
iii) Import the Public Key in the recieving node
```bash
  gpg --import my_public_key.asc
```
## For Encryption and Decryption

Encrypt the File

```bash
  Usage: ./ImageEncrypter.sh -i <input_file>.jpg -o <output_file>.gpg -e <recipient_email> 

```

Decrypt the File

```bash
  Usage: ./ImageEncrypter.sh -i <input_file>.gpg -o <output_file>.jpg -e <recipient_email> -d

```

