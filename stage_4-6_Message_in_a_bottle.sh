#!/usr/bin/env bash

re_file='^[a-zA-Z.]+$'
re_name='^[A-Z ]+$'
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
read file_name

if [[ -f "$file_name"  ]]; then
    #file exists
    echo "File content:"
    cat $file_name
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
            echo "Not implemented!";;
        4 )
            echo "Not implemented!";;
        * )
            echo "Invalid option!";;
    esac
done
