ping <Hostname> -c 1 | grep "(" | cut -f 3 -d " " | sed "s/^(//" | cut -f 1 -d ")" | grep -v "from"
