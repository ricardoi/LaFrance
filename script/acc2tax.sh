#/bin/bash

file=$1 # this is a list of sequences
name=$(echo "$file" | cut -d_ -f1)
out="${name}_taxonomy.tsv"

# Header
printf "accession\ttaxid\torganism\tcelullar\tgroup\trealm\tkingdom\tphylum\tclass\torder\tsuborder\tfamily\tgenus\tspecies\n" > "$out"

while IFS= read -r accno;
do
taxid=$(esearch -db nuccore -query "$accno" < /dev/null |
         efetch -format docsum  |
         xtract -pattern DocumentSummary -element TaxId)

TAXA=$(efetch -db taxonomy -id "$taxid" -format xml \
| xtract -pattern Taxon -first TaxId -element ScientificName \
  -block "**/Taxon" \
    -if Rank -is-not "no rank" -and Rank -is-not clade \
    -tab "\n" -element Rank,ScientificName )

# TAXA table into rows (AI assisted code)
# Handles both styles:
#  1. lines like "realm<TAB>Riboviria"
#  2. alternating lines: "realm" on one line, "Riboviria" on the next
printf '%s\n' "$TAXA" | awk -v FS='\t' -v OFS='\t' -v acc="$accno" '
  BEGIN{
    realm=kingdom=phylum=class=order=suborder=family=genus=species=""
    taxid=""; org=""; pending=""
  }
  NR==1{
    # first line begins with TaxId and organism; capture them (keep full organism, even if spaced)
    taxid=$1
    org=$2
    # if more fields on line 1 (rare), append them to organism
    for(i=3;i<=NF;i++) org=org OFS $i
    next
  }
  # two-column pair on a single line
  NF==2{
    rk=$1; name=$2
    if     (rk=="realm")    realm=name
    else if(rk=="kingdom")  kingdom=name
    else if(rk=="phylum")   phylum=name
    else if(rk=="class")    class=name
    else if(rk=="order")    order=name
    else if(rk=="suborder") suborder=name
    else if(rk=="family")   family=name
    else if(rk=="genus")    genus=name
    else if(rk=="species")  species=name
    next
  }
  # alternating lines: rank on one line, name on next
  NF==1{
    if(pending==""){ pending=$1 }
    else{
      rk=pending; name=$1
      if     (rk=="realm")    realm=name
      else if(rk=="kingdom")  kingdom=name
      else if(rk=="phylum")   phylum=name
      else if(rk=="class")    class=name
      else if(rk=="order")    order=name
      else if(rk=="suborder") suborder=name
      else if(rk=="family")   family=name
      else if(rk=="genus")    genus=name
      else if(rk=="species")  species=name
      pending=""
    }
    next
  }
  END{
    print acc, taxid, org, realm, kingdom, phylum, class, order, suborder, family, genus, species
  }' >> "$out"

done < "$file"

echo "Wrote: $out"

