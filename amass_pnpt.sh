#!/bin/bash

url=$1

echo "[+] Harvesting Subdomains with amass..."

amass enum -d $url >> $url/recon/f.txt

sort -u $url/recon/f.txt >> $url/recon/final.txt

rm $url/recon/f.txt
