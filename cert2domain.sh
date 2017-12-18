# Following one liner will help to identify the domain names from SSL Certificate

openssl s_client -connect <IP_Address>:<port> 2>1| openssl x509 -noout -text | grep DNS:|tr , '\n'|cut -f2 -d:
