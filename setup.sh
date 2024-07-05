#!/bin/zsh

# Iterate over each item in the current directory
for item in ./*; do
    # Check if the item is a directory
    if [ -d "$item" ]; then
        # Append the directory name to the string
        dir_name=$(basename "$item")
        echo "Running stow for: $dir_name"
        stow $dir_name
    fi
done

