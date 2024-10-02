#!/bin/bash

echo_example () {
    echo "[ echo ] print string to the console."
}


# Create example file
cat > example_file.txt <<EOF
line-1
line-2
line-3
EOF

read_file () {
  while read -r line; do 
    echo $line
  done < example_file.txt
}

fetch_url () {
    curl http://www.google.com
}

find_files () {
    # Note the || (OR) condition
    # Look for .txt file in the current directory. 
    # If NOT found, echo statement will be printed. 
    find . -name *.txt || echo "could not find"
}
# Execution - Call desired functions
read_file
fetch_url
