#!/usr/bin/env bash

R1=$1
R2=$2
OUTPFX=$3

export FLASH=./bin/flash2
$FLASH -t 20 -o $OUTPFX -z -r 150 -f 223 -s 10 $R1 $R2
