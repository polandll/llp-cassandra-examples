#!/bin/bash

CQLSH="../../dsc-cassandra-2.1.0/bin/cqlsh"
# RS_CQLSH="cqlsh node0"
CQLSH_FLAGS="-f"

P_CATFOOD_CHECK="p_catfood_check.cql"
# RS_P_CATFOOD_CHECK="p_catfood_check_rightscale.cql"

OUTPUT_TEXT="output.txt"
OUTPUT_CLEAN="output.clean"

FIRST_FIELD="BRAND2"
SECOND_FIELD="BRAND4"

$CQLSH $CQLSH_FLAGS $P_CATFOOD_CHECK
# $RS_CQLSH $CQLSH_FLAGS $RS_P_CATFOOD_CHECK
grep $FIRST_FIELD $OUTPUT_TEXT > $OUTPUT_CLEAN 
if [ -s $OUTPUT_CLEAN ]
then 
  echo "RIGHT" 
else 
  echo "WRONG" 
fi  
