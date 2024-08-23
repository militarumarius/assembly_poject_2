%include "../include/io.mac"

; The `expand` function returns an address to the following type of data
; structure.
struc neighbours_t
    .num_neighs resd 1  ; The number of neighbours returned.
    .neighs resd 1      ; Address of the vector containing the `num_neighs` neighbours.
                        ; A neighbour is represented by an unsigned int (dword).
endstruc

section .bss
; Vector for keeping track of visited nodes.
visited resd 10000
global visited

section .data
; Format string for printf.
fmt_str db "%u", 10, 0

section .text
global dfs
extern printf

; C function signiture:
;   void dfs(uint32_t node, neighbours_t *(*expand)(uint32_t node))
; where:
; - node -> the id of the source node for dfs.
; - expand -> pointer to a function that takes a node id and returns a structure
; populated with the neighbours of the node (see struc neighbours_t above).
; 
; note: uint32_t is an unsigned int, stored on 4 bytes (dword).
dfs:
    push ebp
    mov ebp, esp

    ;; save the preserved registers
    push ebx
    push edi
    push esi
    ; TODO: Implement the depth first search algorith, using the `expand`
    ; function to get the neighbours. When a node is visited, print it by
    ; calling `printf` with the format string in section .data.
    ; nodul , primul argument al fucntiei
    mov ebx, [ebp + 8]  
    ; pun pe stiva nodul curent vizitat si il afisez
    push ebx
    push fmt_str
    call printf
    ; readuc stiva la valorile initiale inainte de apelul lui printf
    add esp, 4
    pop ebx
    ; expand function
    mov ecx, [ebp + 12] 
    ; marchez nodul drept vizitat
    mov dword[visited + ebx * 4], 1
    ; calculez vecinii nodului dat , sunt salvati in eax
    push ecx
    push ebx
    ; apelez functia expand care imi calculeaza vecinii
    call ecx
    ; golesc stiva dupa printf doar cu 4 octeti pentru a 
    ; relua valoarea registrului ecx
    add esp, 4
    pop ecx
    ; pun in edx numarul de vecini
    mov edx, dword[eax + neighbours_t.num_neighs]
    ; pun in ebx adresa vectorului de vecini
    mov ebx, dword[eax + neighbours_t.neighs]
    ; folosesc drept contor la bucla mark_neighbours
    xor eax, eax 

mark_neighbours:
    cmp eax, edx
    je finish_mark_neighbours
    ; pun pe stiva numarul de vecini
    push edx
    ; pun pe stiva adresa vectorului de vecini
    push ebx
    ; pun contorul pe stiva ca sa l pot folosi in apelul recursiv
    push eax
    ; salvez ecx
    push ecx 
    ; pun in ecx vecinul curent
    mov ecx, dword[ebx + 4 * eax]
    ; daca nodul nu a fost vizitat, il vizitez prin apelul recursiv al dfs
    cmp dword[visited + 4 * ecx], 0
    je call_dfs
    ; daca nodul a fost vizitat, trec la urmatorul vecin
    jmp inc_eax

inc_eax:
    ; scot de pe stiva registrii necesari pentru continuarea forului
    pop ecx
    pop eax
    pop ebx
    pop edx
    ; incrementez contorul
    inc eax
    jmp mark_neighbours

call_dfs:
    ; aveam deja expand pe stiva
    push ecx
    ; apelez dfs pentru vecinul curent
    call dfs
    ; readuc stiva la valorile initiale inainte de apelul lui dfs
    add esp, 8
    ; extrag de pe stiva registri necesarii pentru continuarea buclei
    pop eax
    pop ebx
    pop edx
    ; incrementez contorul
    inc eax
    jmp mark_neighbours


finish_mark_neighbours:
    ;; restore the preserved registers
    pop esi
    pop edi
    pop ebx
    leave
    ret
