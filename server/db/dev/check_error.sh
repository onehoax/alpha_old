#!/bin/bash

if (grep -qwi error ../logs/dev/create_out.txt)
then
  echo "Errors found while creating the schema; examine ../logs/dev/create_out.txt for more details"
else
  echo "No errors while creating the schema"
fi

if (grep -qwi error ../logs/dev/backout_out.txt)
then
  echo "Errors found while deleting the schema; examine ../logs/dev/backout_out.txt for more details"
else
  echo "No errors while deleting the schema"
fi