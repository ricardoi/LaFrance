# La France Disease

Investigating the etiology of the La France Isomeric Virus.



## Constructing a mycovirus database using `esearch` from NCBI
Create a database with all queries assigned to a family within the mycovirus group.
```bash
esearch -db nuccore -query \
'(Mitoviridae[Organism] OR Narnaviridae[Organism] OR Partitiviridae[Organism] OR Chrysoviridae[Organism] OR Totiviridae[Organism] OR Polymycoviridae[Organism] OR Fusariviridae[Organism] OR Hypoviridae[Organism] OR Endornaviridae[Organism] OR Quadriviridae[Organism] OR Yadokariviridae[Organism] OR Botourmiaviridae[Organism])' \
| efetch -format fasta > mycoviruses_by_family.fasta
```
Create a database with all complete genomes assigned to a family within the mycovirus group
```bash
esearch -db nuccore -query \
'(Mitoviridae[Organism] OR Narnaviridae[Organism] OR Partitiviridae[Organism] OR Chrysoviridae[Organism] OR Totiviridae[Organism] OR Polymycoviridae[Organism] OR Fusariviridae[Organism] OR Hypoviridae[Organism] OR Endornaviridae[Organism] OR Quadriviridae[Organism] OR Yadokariviridae[Organism] OR Botourmiaviridae[Organism] AND (complete genome[Title])' \
| efetch -format fasta > mycoviruses_by_family-completegenome.fasta
```
