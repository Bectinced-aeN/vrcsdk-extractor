#!/bin/bash

# Run setups if necessary
if ! type "dotnet" > /dev/null; then
    echo "Dotnet is required"
    return 128;
fi
if ! type "git" > /dev/null; then
    echo "git is required"
    return 128;
fi
if ! type "ilspycmd" > /dev/null; then
    echo "ilspycmd is required, installing"
    dotnet tool install ilspycmd -g
fi

UNITY_EXTRACT_SCRIPT=./extractunitypackage/extractunitypackage.py
if [ ! -s "$UNITY_EXTRACT_SCRIPT" ]; then
    echo "Unitypackage exractscript is required, downloading"
    git submodule update --init
fi

# Extract the unity packages
OUTPUT=./output
rm -r "$OUTPUT"
mkdir -p "$OUTPUT"
echo "Extracting unitypackage(s)"
shopt -s globstar
for PACKAGE in ./*.unitypackage; do
    python "$UNITY_EXTRACT_SCRIPT" "$PACKAGE" "$OUTPUT"
done

# Extract all the dll files and remove the original ones
echo "Extracting dll files"
shopt -s globstar
for FILE in "$OUTPUT"/**/*.dll; do
    DIR=$(dirname "${FILE}")
    NAME=$(basename "${FILE}")
    NAME=${NAME%.*}
    OUTPUT="$DIR/$NAME-dll"

    mkdir "$OUTPUT"
    echo "Extracting $FILE"
    ilspycmd "$FILE" -p -o "$OUTPUT"
    echo "Extracted, deleting original"
    rm "$FILE"
done
