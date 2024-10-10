#!/bin/sh

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input_file> <output_file>"
  exit 1
fi

input_file="$1"
output_file="$2"

echo "<dependencies>" > $output_file

while IFS= read -r line
do
  if echo "$line" | grep -qE '^\+-|^\|  \+-|^\|  \|  \+-'; then
    parts=$(echo "$line" | sed -E 's/^\+- |^\|  \+- |^\|  \|  \+- //')
    group_id=$(echo "$parts" | cut -d':' -f1)
    artifact_id=$(echo "$parts" | cut -d':' -f2)
    version=$(echo "$parts" | cut -d':' -f4)
    echo "  <dependency>" >> $output_file
    echo "    <groupId>$group_id</groupId>" >> $output_file
    echo "    <artifactId>$artifact_id</artifactId>" >> $output_file
    echo "    <version>$version</version>" >> $output_file
    echo "  </dependency>" >> $output_file
  fi
done < "$input_file"

echo "</dependencies>" >> $output_file

echo "Lock file generated at $output_file"