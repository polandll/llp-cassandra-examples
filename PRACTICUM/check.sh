#!/bin/bash

# RS_ means rightscale command or filename

# cqlsh command and flags
CQLSH="../../dsc-cassandra-2.1.0/bin/cqlsh"
# RS_CQLSH="cqlsh node0"
CQLSH_FLAGS="-f"

# CQL for checking query
P_CATFOOD_CHECK="p_catfood_check.cql"
# RS_P_CATFOOD_CHECK="p_catfood_check_rightscale.cql"

# output file names
OUTPUT_TEXT="output.txt"
OUTPUT_CLEAN="output.clean"

$CQLSH $CQLSH_FLAGS $P_CATFOOD_CHECK
# $RS_CQLSH $CQLSH_FLAGS $RS_P_CATFOOD_CHECK

sed -e 's/ //g'  -e '1d' -e '/^$/d' -e '$d' -e '/(/,/)/d' -e '/^-/d' $OUTPUT_TEXT > $OUTPUT_CLEAN
python process.py
exit 0 
