# La France Disease

## Investigating the etiology of the _La France_ Isomeric Virus.
"La France disease" of cultivated mushroom (Agaricus bisporus) is caused by a virus complex historically called Mushroom Virus X (MVX), first described in France in the 1950s. The taxonomy of the causal agent(s) is unusual because it is not a single virus species but a heterogeneous group of double-stranded RNA viruses. Here is the classification as recognized today:

Disease:
Name: La France disease of mushroom (champignon disease)
Host: Agaricus bisporus (edible button mushroom)
Symptoms: Slow growth, poor yield, watery stipe, abnormal fruiting, and collapse of crops

Multiple viruses have been associated as the causal agents of La France disease. Among these, multiple dsRNA viruses have been associated, often referred to as the "Mushroom Virus Complex (MVC)" or "Mushroom Virus X (MVX)". Some viruses associated with La France disease symptoms are still unassigned to families. These viruses are not classified into a single family but belong to different viral lineages, among them have been reported: Partitivirus, (Partitiviridae); Totivirus (Totiviridae); Endornavirus (Endornaviridae, possible involvement), and a couple of unclassified dsRNA viruses.

Current View
The disease is not caused by a single virus but by a complex mixture of mycoviruses. Collectively, these dsRNA viruses are grouped under the historical label “La France Isolate” or “Mushroom Virus X (MVX)”. Because the fungi can harbor several viruses simultaneously, symptoms often depend on virus combinations rather than one specific agent.

Classic La France isometric virus (LIV)
Nine principal dsRNA genome segments are consistently reported (segment names in parentheses), with occasional “minor” segments sometimes seen:
3.6 kb (L1), 3.0 kb (L2), 2.8 kb (L3), 2.7 kb (L4), 2.5 kb (L5), 1.6 kb (M1), 1.35 kb (M2), 0.86 kb (S1), 0.78 kb (S2). 
WRAP
– Early work also reported six major bands 3.8, 3.1, 3.0, 2.8, 2.6, 1.3 kb plus three minor bands 1.7, 0.9, 0.8 kb, showing small sizing differences among studies. 
APS Home
– Three segments were sequenced and sized precisely: M2 ≈1.3 kb, M1 ≈1.55 kb, L3 ≈2.8 kb; a small S3 variant (~0.39 kb) is an internal deletion of M2. 
SpringerLink
MVX / “brown cap” (often conflated with La France in industry reports)
MVX samples show a set of 26 dsRNA elements spanning ~0.64–20.2 kb, typically non-encapsidated and highly variable by sample. Frequently discussed features:
Common asymptomatic dsRNAs: ~16.2 kb, 9.4 kb, 2.4 kb (often present even when no MVX symptoms are seen).
Bands often linked with brown-cap symptoms: 2.0, 1.8, 0.8, 0.6 kb.
Other recurrent bands include (selection): 18.3, 14.4, 13.6, 12.6, 10.25, 8.6, 7.8, 7.0, 5.4, 4.8, 4.1, 3.6, 3.3, 2.2, 1.6, 1.4, 1.1 kb. (See Fig. 2 in source for the full panel with frequencies across samples.) 
WRAP
+1
Notes for interpretation:
The LIV profile (nine segments) is the classic “La France disease” genome in ~35–36 nm isometric particles; those nine segments are considered the viral genome. 
APS Home
MVX (late-1990s onward) is a complex with many dsRNA elements; profiles vary widely between farms/batches, so single fixed “genome sizes” aren’t used for MVX. 
WRAP


## Constructing a mycovirus database using `esearch` from NCBI
Create a database with all queries assigned to a family within the mycovirus group.
```bash
esearch -db nuccore -query \
'(Mitoviridae[Organism] OR Narnaviridae[Organism] OR Partitiviridae[Organism] OR Chrysoviridae[Organism] OR Totiviridae[Organism] OR Polymycoviridae[Organism] OR Fusariviridae[Organism] OR Hypoviridae[Organism] OR Endornaviridae[Organism] OR Quadriviridae[Organism] OR Yadokariviridae[Organism] OR Botourmiaviridae[Organism] OR Mymonaviridae[ORGANISM] OR Megabirnaviridae[Organism] OR Alternaviridae[Organism] AND (complete genome[Title]))' \
| efetch -format fasta > mycoviruses_by_family.fasta
```
Create a database with all complete genomes assigned to a family within the mycovirus group
```bash
esearch -db nuccore -query \
'(Mitoviridae[Organism] OR Narnaviridae[Organism] OR Partitiviridae[Organism] OR Chrysoviridae[Organism] OR Totiviridae[Organism] OR Polymycoviridae[Organism] OR Fusariviridae[Organism] OR Hypoviridae[Organism] OR Endornaviridae[Organism] OR Quadriviridae[Organism] OR Yadokariviridae[Organism] OR Botourmiaviridae[Organism] OR Mymonaviridae[ORGANISM] OR Megabirnaviridae[Organism] OR Alternaviridae[Organism] AND (complete genome[Title]))' \
| efetch -format fasta > mycoviruses_by_family_completegenome.fasta
```
Create a database with all protein queries assigned to a family within the mycovirus group.
```bash
esearch -db protein -query \
'(Mitoviridae[Organism] OR Narnaviridae[Organism] OR Partitiviridae[Organism] OR Chrysoviridae[Organism] OR Totiviridae[Organism] OR Polymycoviridae[Organism] OR Fusariviridae[Organism] OR Hypoviridae[Organism] OR Endornaviridae[Organism] OR Quadriviridae[Organism] OR Yadokariviridae[Organism] OR Botourmiaviridae[Organism] OR Mymonaviridae[ORGANISM] OR Megabirnaviridae[Organism] OR Alternaviridae[Organism])' \
| efetch -format fasta > mycoviruses_by_family_protein.fasta
```
Create a database with the protein queries from the complete genomes assigned to a family within the mycovirus group.
```bash
esearch -db nuccore -query \
'((Mitoviridae[Organism] OR Narnaviridae[Organism] OR Partitiviridae[Organism] OR Chrysoviridae[Organism] OR Totiviridae[Organism] OR Polymycoviridae[Organism] OR Fusariviridae[Organism] OR Hypoviridae[Organism] OR Endornaviridae[Organism] OR Quadriviridae[Organism] OR Yadokariviridae[Organism] OR Botourmiaviridae[Organism] OR Mymonaviridae[Organism] OR Megabirnaviridae[Organism] OR Alternaviridae[Organism])) 
 AND "complete genome"[Title]' \
| elink -target protein \
| efetch -format fasta > mycovirus_proteins_from_complete_genomes.faa
```
