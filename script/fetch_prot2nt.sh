#!/usr/bin/env bash
file=$1
name=$(echo "$file" | cut -d. -f1)
out="${name}_cds_from_proteins.fna"
: > "$out"

cat $file |
while read AccNo 
do
  esearch -db protein -query "$AccNo" < /dev/null |
    elink -target nuccore |
    efetch -format fasta_cds_na >> "$out"
done

echo "Done. Wrote: $out"

