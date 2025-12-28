#!/bin/sh
set +x
if [ "$1" = "" ]
then
    echo "Usage: 903sir.sh demo"
    exit
elif [ ! -e "demos/903sir/$1.txt" ]
then
    echo $1.txt not found in demos/903sir
    exit
fi
#echo remove hidden files
rm -f .ascii .data .linker .plot.png .punch .reader .reverse .save  .stop .store
#echo load assembler
./emu900 -j=8181 -reader="bin/903sir/sir(iss6)(5500)"
#echo convert input tape $1
./to900text demos/903sir/$1.txt
#echo assemble program
./emu900 -j=8
echo
if [ $? != 0 ]
    then echo -en "\n*** Error during assembly phase ***"
         exit
fi
#echo run program
cp .save .reader
./emu900 -j=32
#echo check for punch output
echo
if  [ ! -s .punch ]
	then echo ***" No punch output ***"
    else echo "*** Punch output ***"
        ./from900text
        cat .ascii
fi
