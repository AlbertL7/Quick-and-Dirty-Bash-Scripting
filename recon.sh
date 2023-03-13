#!/bin/bash

#Recon tool: 
#see whois
#Find subdomains
#see if subdomains are alive
#screenshot alive subdomains
#https/443 http/80

domain=$1
RED="\033[1;31m"
RESET="\033[0m"

info_path=$domain/info
subdomain_path=$domain/subdomains
screenshot_path=$domain/screenshots

# if the directory does not exist then make the directory
if [ ! -d "$domain" ];then
	mkdir $domain
fi

if [ ! -d "$info_path" ];then
	mkdir $info_path
fi

if [ ! -d "$subdomain_path" ];then
	mkdir $subdomain_path
fi

if [ ! -d "$screenshot_path" ];then
	mkdir $screenshot_path
fi

#run the whois command and put it in a file called whois.txt
echo -e "${RED} [+] Checking whois data... ${RESET}"
whois $1 > $info_path/whois.txt

echo -e "${RED} [+] Finding Subdomains with subfinder > found.txt... ${RESET}"
subfinder -d $domain > $subdomain_path/found.txt

echo -e "${RED} [+] Finding some more subdomains with assetfinder >> found.txt... ${RESET}"
assetfinder $domain | grep $domain >> $subdomain_path/found.txt

echo -e "${RED} [+] Running amass to find some more subdomains this could take a while >> found.txt... ${RESET}"
amass enum -d $domain >> $subdomain_path/found.txt

echo -e "${RED} [+] Lets see what sites are ALIVE > alive.txt...${RESET}"
cat $subdomain_path/found.txt | grep $domain | sort -u | httprobe -prefer-https | grep https | sed 's/https\?:\/\///' | tee -a $subdomain_path/alive.txt

echo -e "${RED} [+] Taking dem screenshotz > screenshot_path...${RESET}"
gowitness file -f $subdomain_path/alive.txt -P $screenshot_path/ --no-http
