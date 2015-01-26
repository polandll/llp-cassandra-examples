#!/bin/bash

../../dsc-cassandra-2.1.0/bin/cqlsh -f p_catfood_check.cql
python process.py
exit 0
