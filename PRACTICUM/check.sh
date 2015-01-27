#!/bin/bash

../../dsc-cassandra-2.1.0/bin/cqlsh -f p_catfood_check.cql
grep BRAND2 output.txt > output.clean
if [ -s output.clean ]
then 
  echo "RIGHT" 
else 
  echo "WRONG" 
fi  
