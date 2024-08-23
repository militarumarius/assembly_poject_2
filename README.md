### Nume: Militaru Ionut-Marius

### Descriere:

* In cadrul proiect am avut de implementat mai multe Taskuri
dupa cum urmeaza descris in continuare

## Taskul 1 
* am avut de verificat daca un sir de paranteze sunt inchise corespunzator
sau nu in fucntie de tipul ei
* am folosit stiva in cadrul acestui task dupa cum urmeaza
    - verific daca paranteza este deschisa de orice fel (,[,{ si daca
    da le pun pe stiva
    - cand dau de o paranteza inchisa },],) dau pop de pe stiva si verific
    daca in varful stivei aveam paranteza corespunzatoare si daca da continui
    procedeul , daca nu inseamna ca nu e corecta parantezarea si opresc 
    programul
    - la final verific daca stiva mai contine paranteze pentru a fi sigur
    ca nu au ramas paranteze pe stiva
    - rezultatul il pun in eax si pentru a verifica tipul de paranteze
    folosesc codul ascii al acestora

## Taskul 2 - Divide et impera

### Quicksort

* in cadrul acestui subtask am avut de implementat algoritmul quicksort 
recursiv dupa cum urmeaza
* la fiecare apelare trebuia selectat un pivot pentru a rearanja elementele
in vector astfel incat in stanga lui sa fie elemtele mai mici decat acesta iar
in dreapta lui cele mai mari. Pivotul il aleg ultimul element din vector. 
Pentru acest lucru folosesc labelul pivot_find care returneaza noua pozitie 
a acestuia, iar apoi in labelul continue_sorting apelez recursiv functia 
qsort pentru cei doi vectori formati cu pivotul. 
La fiecare apelare a functiei recursive dau push pe stiva 
la registri de care o sa am nevoie dupa intoarcerea din recursivitate 
si readuc stiva la valorile ei initiale.

### Binary Search

* in cadrul acestui subtask am avut de implementat cautarea binara recursiv 
folosind calling convention al fastcall , prin care primele doua argumente
din functie sunt trasnmise prin registrele ecx si edx, trebuind astfel sa ma asigur
ca la fiecare call al functiei recursive am in aceste registre valorile necesare , 
restul le pun pe stiva. Deoarece edx este folosit doar pentru retine elementul pe 
care il caut nu am avut probleme iar pentru ecx, am facut swap cu edi pentru a putea 
folosi ecx in cadrul functiei iar la fiecare call repuneam in ecx, valoarea lui edi.
* algortmul presupune sa caut un element intr-un vector ordonat.
Daca avem indicele de start> indicele de end inseamna ca nu exista in vector 
elementul si pun in eax -1.La un pas calculez mijlocul intervalului dupa 
verific daca la pozitia respectiva se afla elementul cautat daca da, opresc 
programul avand deja in eax valoarea cautat. Daca nu compar valoarea de la 
pozitia mijlocului cu elementul pe care il caut si merg in stanga sau in dreapta.

## Task 3 - DFS 

* am implementat algoritmul de parcurgere in adangime a unui graf recursiv. 
Am extras vecinii unui nod prin apelul functiei expand retinuta in ecx dupa 
ce am printat nodul la care ma aflam.Dupa am verificat daca vecinii nodului 
sunt vizitati si daca nu , apelam functia din nou punand pe stiva argumentele 
necesare apelari functiei , dar si valorile necesare acre imi trebuiau dupa 
pentru a continua bubla mark_neighbours pentru atunci cand ma intorceam din 
recursivitate.Continui pana cand toti veciniti au fost vizitati.

## Functional

* in cadrul acestui task am avut de implementat doua functionale in assembly x64 .
    - pentru map am implementat bucla for tinand seama de conventia pentru 
    apelul functiilor in x64 si anume ca argumentele functiei sunt transmise 
    prin registri rdi, rsi, rdx, rcx in aceasta ordine si nu prin stiva . 
    Am apelat pentru fiecare element din sursa functia de map, 
    mutant valoarea de la src[i], in rdi. Iar inainte de call am pus 
    toti registri pe stiva pentru a fi sigur ca nu mi modifica functia 
    de map , dupa call scotand elementele inapoi de pe stiva
    - pentru reduce am implementat bucla for tinand seama de conventia 
    pentru apelul functiilor in x64 si anume ca argumentele functiei sunt 
    transmise prin registri rdi, rsi, rdx, rcx, r8 in aceasta ordine si nu 
    prin stiva . Am apelat pentru fiecare element din sursa functia de 
    reduce , mutant acumulatorul in rdi si  valoarea de la src[i], in rsi. 
    Iar inainte de call am pus toti registri pe stiva pentru a fi sigur 
    ca nu mi modifica functia de reduce , dupa call scotand elementele 
    inapoi de pe stiva. Modific acumulatorul actual si continui bucla.
