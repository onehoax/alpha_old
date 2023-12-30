#!/bin/bash

psql -h localhost -p 5432 -U alpha -d alpha -a -f ../schema_backout.sql > ../logs/dev/backout_out.txt