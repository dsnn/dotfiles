#!/run/current-system/sw/bin/bash

# Helper script to generate password for different tools

set -euo pipefail

if [[ "$#" -eq 0 ]]; then
  printf "Usage: $0 <passwd> <user>\n"
  exit 1
fi

if [[ "$1" = "passwd" ]]; then
  hashed_password=$(echo "$2" | mkpasswd -sm bcrypt)
  printf "Password generated: $hashed_password\n"
  exit 1
fi
