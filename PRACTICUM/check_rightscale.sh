#!/bin/bash

cqlsh node0 -f p_catfood_check.cql
grep BRAND2 output.txt > output.clean
if [ -s output.clean ]
then 
  echo "RIGHT" 
else 
  echo "WRONG" 
fi
