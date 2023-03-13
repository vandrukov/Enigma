#!/usr/bin/env bash

re_file='^[a-zA-Z.]+$'
re_name='^[A-Z ]+$'
space=" "
re_num=3
echo "Welcome to the Enigma!"

ask_action() {
echo -e "0. Exit\n1. Create a file\n2. Read a file\n3. Encrypt a file\n4. Decrypt a file\nEnter an option:"
}

create_file() {
echo "Enter the filename:"
read filename
if [[ $filename =~ $re_file ]]; then
    echo "Enter a message:"
    read message
    if [[ $message =~ $re_name ]]; then
        echo $message >> "$filename"
        echo "The file was created successfully!"
    else 
        echo "This is not a valid message!"
    fi

else 
    echo "File name can contain letters and dots only!"
fi


}

read_file() {
echo "Enter the filename:"
read file_name1
if [[ -f "$file_name1"  ]]; then
    #file exists
    echo "File content:"
    cat $file_name1
else 
    echo "File not found!"
fi

}

encrypt() {
echo "Enter the filename:"
read file_name

if [[ -f "$file_name"  ]]; then
    #file exists
    read str < $file_name
    result=""
    for ((i=0;i<${#str};i++)); do
        char=${str:i:1}
        if [[ $char =~ $space ]]; then
            result+=$char
        else
            #get num of a letter
            ord=$(printf "%d\n" "'$char")
            [[ $(( $ord + $re_num )) -le 90 ]] && val=$(($ord + $re_num)) || val=$(($ord + $re_num - 90 + 64))
            #get letter of a num
            ch=$(printf "%b\n" "$(printf "\\%03o" "$val")")
            result+=$ch
        fi
    done
    echo $result >> "${file_name}.enc"
    rm $file_name
    echo "Success"
else 
    echo "File not found!"
fi
}


dencrypt() {
echo "Enter the filename:"
read file_name

if [[ -f "$file_name"  ]]; then
    #file exists
    read str < $file_name
    result=""
    for ((i=0;i<${#str};i++)); do
        char=${str:i:1}
        if [[ $char =~ $space ]]; then
            result+=$char
        else
            #get num of a letter
            ord=$(printf "%d\n" "'$char")
            [[ $(( $ord - $re_num )) -ge 65 ]] && val=$(($ord - $re_num)) || val=$((91 - $(( 65 - $(( $ord - $re_num )) ))))
            #get letter of a num
            ch=$(printf "%b\n" "$(printf "\\%03o" "$val")")
            result+=$ch
        fi
    done
    echo $result >> ${file_name%.enc}
    rm $file_name
    echo "Success"
else 
    echo "File not found!"
fi
}


while true; do
    ask_action
    read answer
    case $answer in
        0 )
            echo "See you later!"
            break;;
        1 )
            create_file;;
        2 )
            read_file;;
        3 )
            encrypt;;
        4 )
            dencrypt;;
        * )
            echo "Invalid option!";;
    esac
done
