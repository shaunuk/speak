speak
=====

Simple command line text-to-speech with caching using google translate

Why: To make speaking easier

What: Call from command line to curl google translate engine to say someting to the default output device, aplay can be used for wav and mpg123 for mp3s

Requirements, internet and: 

 apt-get update && apt-get install mpg123 curl 

raspberry pi only:
You may need to select default sound output (0=auto, 1=analog, 2=hdmi), starting up with hdmi plugged in may change this
 lsmod | grep snd_bcm2835
 amixer cset numid=3 1
