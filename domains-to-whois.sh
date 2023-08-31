#!/bin/bash
#This script helps in dealing with a large number of domains and whois information making it easy to read and consume data. Also, helps in identifying if a domain is available for purchase. 
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input_file output_file"
    exit 1
fi

input_file="$1"
output_file="$2"

echo "Domain Name,Available,Owner,Registrar,Purchase Date,Renew Date" > "$output_file"

while IFS= read -r domain; do
    whois_output=$(whois "$domain")

    if echo "$whois_output" | grep -iq "No match" || echo "$whois_output" | grep -iq "Not found"|| echo "$whois_output"|grep -iq "No Data Found"; then
        availability="Available"
        owner=""
        registrar=""
        purchase_date=""
        renew_date=""
    else
        availability="Not Available"
        owner=$(echo "$whois_output" | grep -i "Registrant" | sed 's/Registrant: //i')
        registrar=$(echo "$whois_output" | grep -i "Registrar: " | sed 's/Registrar: //i')
        purchase_date=$(echo "$whois_output" | grep -i "Creation Date:" | sed 's/Creation Date: //i')
        renew_date=$(echo "$whois_output" | grep -i "Registry Expiry Date:" | sed 's/Registry Expiry Date: //i')
    fi

    printf "\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n" "$domain" "$availability" "$owner" "$registrar" "$purchase_date" "$renew_date" >> "$output_file"
done < "$input_file"

echo "Domain info written to $output_file"
