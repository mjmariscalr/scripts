#!/bin/bash

COUNT=0
HELP="Use: bash $0 <option>

Options:
	-o     Target IP address or domain.
	-s     Wordlist of share names.
	-h     Display this help message.
	-v     Display the script version."

if [[ $# -eq 0 ]];then
	echo "$HELP"
	exit 1
fi

while getopts "vhs:o:" arg; do
	case $arg in
		v)
			echo "$0 1.0"
			exit 0
			;;
		h)
			echo "$HELP"
			exit 0
			;;
		s)
			SHARES=$OPTARG
			;;
		o)
			HOST=$OPTARG
			;;
		*)
			echo "Invalid option: -$arg"
			exit 1
			;;
	esac
done

if [[ ! -f "$SHARES" ]]; then
	echo "File $SHARES does not exist."
	exit 1
fi

if ! nc -zw2 "$HOST" 445; then
	echo "[!] CONNECTION FAILED."
	exit 1
fi

while read -r share; do
	output=$(smbclient "//$HOST/$share" -N -c "ls" 2>&1)

	if echo "$output" | grep -q "NT_STATUS_BAD_NETWORK_NAME"; then
		echo "[-] NOT FOUND: $share"
	elif echo "$output" | grep -q "NT_STATUS_ACCESS_DENIED"; then
		echo "[!] NO ACCESS: $share"
	else
		echo "[+] FOUND: $share"
		((COUNT++))
	fi
done < "$SHARES"

echo "Scan complete: 1 host scanned, $COUNT shares found."
