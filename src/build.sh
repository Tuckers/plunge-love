#!/bin/bash

# delete existing love files
rm -f ../bin/*.love

# zip the new files together.
zip ../bin/plunge.love *.lua

# open the file
open -n -a love ../bin/plunge.love
