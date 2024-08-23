; subtask 2 - bsearch

section .text
    global binary_search
 

binary_search:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    push ebx
    push edi
    push esi

    ;; recursive bsearch implementation goes here
    ; in registrul ecx am salvat buff
    ; in edx  elementul pe care trebuie sa l gasesc
    ; pun buff in edi pentru a folosi registrul ecx
    mov edi, ecx 
    ; start
    mov ebx, [ebp + 8] 
    ; end
    mov ecx, [ebp + 12] 

    ; daca start > end inseamna ca nu am gasit elementul
    cmp ebx, ecx
    jg not_found

    ; in eax calculez mijlocul intervalului
    ; folosesc formula m = j-i/2 +i pentru a fi siguri ca nu ies din int32_t
    ; eax = end
    mov eax, ecx  
    ; eax = end - start
    sub eax, ebx  
    ; eax = (end - start) / 2
    shr eax, 1   
    ; eax = start + (end - start) / 2 
    add eax, ebx  

    ; calzulez elemenetul de la pozitia m(eax)
    mov esi, [edi + eax * 4]
    ; compar cu elementul pe care trebuie sa l gasesc 
    cmp edx, esi
    je found

    ; daca elementul de la pozitia m este mai mic decat elementul cautat
    ; atunci caut in intervalul [start, m-1]
    jl search_left

    ; daca elementul de la pozitia m este mai mare decat elementul cautat
    ; atunci caut in intervalul [m+1, end]
    jmp search_right

search_right:
    ; acutalizez start
    mov ebx, eax
    inc ebx
    ; pun pe stiva end ( pentru recursivitate)
    push ecx
    ; pun pe stiva start ( pentru recursivitate) 
    push ebx  
    ; repun buff in ecx
    mov ecx, edi 
    call binary_search
    ; golesc stiva
    add esp, 8 
    jmp end_recursivity

search_left:
    ; actualizez end
    mov ecx, eax 
    dec ecx
    ; pun pe stiva end ( pentru recursivitate)
    push ecx  
    ; pun pe stiva start ( pentru recursivitate)
    push ebx  
    ; repun buff in ecx
    mov ecx, edi 
    call binary_search
    ; golesc stiva
    add esp, 8 
    jmp end_recursivity

found:
    ; am deja in eax salvata pozitia cautata deci ma opresc
    jmp end_recursivity

not_found:
    ; daca nu gasesc elementul atunci pun in eax -1 si ma opresc
    mov eax, -1
    jmp end_recursivity

end_recursivity:
    ;; restore the preserved registers

    pop esi
    pop edi
    pop ebx
    leave
    ret
