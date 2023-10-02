#!/bin/bash

# delete existing love files
rm -f ../bin/*.love

# move assets to build folder
mkdir ../bin/build
cp -r ../assets ../bin/build
cp -r . ../bin/build

# zip the new files together and move plunge.love to bin
cd ../bin/build
zip -r plunge.love .
mv plunge.love ../

# remove assets folder
cd ..
rm -rf build/

# open the file
open -n -a love ../bin/plunge.love
