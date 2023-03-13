#!/usr/bin/env bash

echo "Enter a message:"
read -r string
re='^[A-Z ]+$'
check_message() {
  [[ "$1" =~ $re ]] && echo "This is a valid message!" || echo "This is not a valid message!"
}
check_message "$string"
