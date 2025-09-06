#!/bin/bash
set -euo pipefail

fof=${1:-}
MAXT=${2:-5}   # default to 5 if not provided
DB_NT=$3   # override with: DB_NT=... ./script.sh ...
DB_AA=$4   # override with: DB_AA=... ./script.sh ...
THREADS=${THREADS:-4}

usage() {
  echo "Usage: $(basename "$0") file_of_queries.txt [MAX_TARGET_SEQS]"
  echo "       THREADS, DB_NT, DB_AA can be set via env vars."
  exit 1
}

[[ -z "${fof}" ]] && usage
[[ ! "$MAXT" =~ ^[0-9]+$ || "$MAXT" -lt 1 ]] && { echo "Error: MAX_TARGET_SEQS must be a positive integer."; exit 1; }

# check DBs exist
blastdbcmd -db "$DB_NT" -info >/dev/null 2>&1 || { echo "Missing/invalid nucleotide DB: $DB_NT"; exit 1; }
blastdbcmd -db "$DB_AA" -info >/dev/null 2>&1 || { echo "Missing/invalid protein DB: $DB_AA"; exit 1; }

mkdir -p blast_results/blastn blast_results/blastx

while IFS= read -r line; do
  [[ -z "$line" || "$line" =~ ^# ]] && continue
  [[ -f "$line" ]] || { echo "Warning: query not found: $line"; continue; }

  base=$(basename "$line"); stem="${base%.*}"
  echo "Processing $line (max_target_seqs=$MAXT)"

  blastn \
    -query "$line" \
    -db "$DB_NT" \
    -task dc-megablast \
    -evalue 1e-5 \
    -max_target_seqs "$MAXT" \
    -num_threads "$THREADS" \
    -outfmt '6 qseqid sseqid pident length qcovs evalue bitscore staxids sscinames scomnames sskingdoms stitle' \
    -out "blast_results/blastn/${stem}_blastn_res.tsv"

  blastx \
    -query "$line" \
    -db "$DB_AA" \
    -evalue 1e-5 \
    -max_target_seqs "$MAXT" \
    -num_threads "$THREADS" \
    -outfmt '6 qseqid sseqid pident length qcovs evalue bitscore staxids sscinames scomnames sskingdoms stitle' \
    -out "blast_results/blastx/${stem}_blastx_res.tsv"

done < "$fof"

