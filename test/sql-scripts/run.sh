#!/bin/bash

DIRECTORY="${1:-.}"

find "$DIRECTORY" -type f -name "*.sql" | while read -r file; do
    echo "Executing $file..."
    psql -U s283945 -f "$file"
    if [ $? -ne 0 ]; then
        echo "Error executing $file"
        exit 1
    else
        echo "$file executed successfully."
    fi
done
