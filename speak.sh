#!/bin/bash

#Author: Shaun Butler, shaun@pppoe.co.uk
#Date: 2013-09-22
#Why: To make speaking easier
#What: Call from command line to curl google translate engine to say someting to the default output device, aplay can be used for wav and mpg123 for mp3s
#Requirements, internet and: 
# apt-get update && apt-get install mpg123 curl 
#raspberry pi: may need to select default sound output if you use hdmi (0=auto, 1=analog, 2=hdmi)
# amixer cset numid=3 1
#check if your sound device exists
# lsmod | grep snd_bcm2835

function cache { #cache mp3's for the future - or get one if new
if [[ -e "/var/cache/speak/$1.mp3" ]]
then
  if [[ -n "$debug" ]]; then echo "Cache hit: /var/cache/speak/$1.mp3"; fi
else
  if [[ -n "$debug" ]]; then echo "Downloading mp3: /var/cache/speak/$1.mp3"; fi
  mkdir -p /var/cache/speak
  wget -q -U Mozilla -O "/var/cache/speak/$1.mp3" "http://translate.google.com/translate_tts?ie=UTF-8&tl=en&q=$1"
fi
}

function talk { # do the actual talking
  if [[ -n "$debug" ]]; then echo "Im going to try and say: $1"; fi
  cache "$1"
  if [[ -n "$debug" ]]; then echo "playing..."; fi
  mpg123 -q "/var/cache/speak/$1.mp3"
}

while getopts "ds:" opt; do #get the options
  case $opt in
    d)
       echo "debug on"
       export debug=yes
    ;;
    s)
      talk "$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument. i.e. you need to say ./speak -s 'hello world'" >&2
      exit 1
      ;;
  esac
done


