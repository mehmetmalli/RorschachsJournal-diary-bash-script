#!/bin/bash
echo "Welcome to the Rorschach's Journal."
echo "Enter the magical words ... : "
read pass
loop=0
while [ $loop -le 1 ]
do
  echo " "
  echo "1. Create a new entry."
  echo "2. Read an existing entry."
  echo "3. Quit."

  read choice

  case $choice in
    1)
      mkdir -p entries entries/$(date +%d-%m-%Y)
      echo "Enter a name for your entry: "
      read name
      vim entries/$(date +%d-%m-%Y)/$name
      openssl enc -aes-256-cbc -salt -in entries/$(date +%d-%m-%Y)/$name -out entries/$(date +%d-%m-%Y)/$name.rj -pass pass:$pass
      rm entries/$(date +%d-%m-%Y)/$name
      echo "Entry is added."
      ;;

    2)
      echo "These are all the dates you have an entry on."
      ls entries
      echo "Enter the date of the entry you are looking for: "
      read date
      echo "These are all the entries you have on $date."
      ls entries/$date
      echo "Enter the name of the entry you want to see: "
      read name
      echo " "
      openssl enc -d -aes-256-cbc -salt -in entries/$date/$name -pass pass:$pass
      ;;

    3)
      echo "See you later .."
      loop=2
      ;;
  esac
done
