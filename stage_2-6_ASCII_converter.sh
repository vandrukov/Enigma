#!/usr/bin/env bash

re_ch='^[A-Z]$'
re_num='^[0-9]$'


echo "Enter an uppercase letter:"
read -r letter
echo "Enter a key:"
read -r num

encrypt() {
#get num of a letter
ord=$(printf "%d\n" "'$1")
[[ $(( $ord + $2 )) -le 90 ]] && val=$(($ord + $2)) || val=$(($ord + $2 - 90 + 64))
#get letter of a num
char=$(printf "%b\n" "$(printf "\\%03o" "$val")")
echo "Encrypted letter: $char"
}


check_message() {
  [[ "$1" =~ $re_ch && "$2" =~ $re_num ]] && encrypt "$1" "$2" || echo "Invalid key or letter!"
}

check_message "$letter" "$num"
