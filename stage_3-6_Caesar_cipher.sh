#!/usr/bin/env bash

echo "Type 'e' to encrypt, 'd' to decrypt a message:"
echo "Enter a command:"
read command
re_ch='^[A-Z ]+$'
re_num=3
check_message() {
    echo "Enter a message:"
    read message
    if [[ ! $message =~ $re_ch ]]; then
        echo "This is not a valid message!"
        exit 0
    fi
}


crypt() {
str=$message
action=$1
space=" "
result=""
for ((i=0;i<${#str};i++)); do
    char=${str:i:1}
    if [[ $char =~ $space ]]; then
        result+=$char
    else
        if [[ $action  =~ "e" ]]; then
            #get num of a letter
            ord=$(printf "%d\n" "'$char")
            [[ $(( $ord + $re_num )) -le 90 ]] && val=$(($ord + $re_num)) || val=$(($ord + $re_num - 90 + 64))
            #get letter of a num
            ch=$(printf "%b\n" "$(printf "\\%03o" "$val")")
            result+=$ch
        elif [[ $action  =~ "d" ]]; then
            #get num of a letter
            ord=$(printf "%d\n" "'$char")
            [[ $(( $ord - $re_num )) -ge 65 ]] && val=$(($ord - $re_num)) || val=$((91 - $(( 65 - $(( $ord - $re_num )) ))))
            #get letter of a num
            ch=$(printf "%b\n" "$(printf "\\%03o" "$val")")
            result+=$ch
        fi
    fi
done
echo $result
}

encrypt() {
    check_message
    echo "Encrypted message:"
    crypt "e"
}

decrypt() {
    check_message
    echo "Decrypted message:"
    crypt "d"
}

case $command in
        "e" )
            encrypt;;
        "d" )
            decrypt;;
        * )
            echo "Invalid command!";;
esac
