; subtask 1 - qsort

section .text
    global quick_sort


quick_sort:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    push ebx
    push edi
    push esi

    ;; recursive qsort implementation goes here
    ; buff = edi
    mov edi, [ebp + 8] 
    ; start = ebx
    mov ebx, [ebp + 12] 
    ; end = ecx
    mov ecx, [ebp + 16] 
    ; verific daca star > end pentru a opri recursivitatea
    cmp ebx, ecx 
    jl pivot_find
    jmp end_sort

continue_sorting:
    ; eax pivotul
    ; pentru a pune pe stiva pivot -1
    dec eax 
    ; pun pe stiva end pentru a l putea folosi la a doua apelare a quick_sort
    push ecx  
    ; pun pe stiva noul end ( pentru recursivitate)
    push eax  
    ; pun pe stiva start ( pentru recursivitate)
    push ebx  
    ; pun pe stiva buff ( pentru recursivitate)
    push edi 
    call quick_sort
    ; restabilesc stiva dupa ce am dat push la eax inainte de recursivitate
    add esp, 8
    ; scot de pe stiva pivot - 1
    pop eax 
    ; scot de pe stiva endul vechi pentru a putea reapela functia recursiv
    pop ecx 
    ; pentru a pune pe stiva pivot + 1
    add eax, 2 
    ; pun pe stiva end ( pentru recursivitate)
    push ecx  
     ; pun pe stiva noul start ( pentru recursivitate)
    push eax 
    ; pun pe stiva buff ( pentru recursivitate)
    push edi 
    call quick_sort
    ; readuc stiva la valorile de dinainte de apelarea quick sort
    add esp, 12
    jmp end_sort

pivot_find:
    ; mut in edx pixotul = cel mai din dreapta element
    mov edx, [edi + ecx  * 4]
    ; in eax pun cel mai mic index
    mov eax, ebx 
    dec eax
    ; pun pe stiva indexul de inceput
    push ebx 
    ; folosesc ebx drept contor la bucla (j)
    jmp swap_by_pivot

swap_by_pivot:
    ; verific daca am ajung de la start la ennd
    cmp ebx, ecx
    je end_swap_by_pivot
    ; compar elementul curent cu pivotul
    ; daca este mai mic decat pivotul il pun pe pozitia i+1
    cmp edx, [edi + ebx * 4]
    jge swap
    ; incrementez j
    jmp increm_ebx

increm_ebx:
    inc ebx
    jmp swap_by_pivot

swap:
    ; pun pe stiva edx si ecx  ca sa i pot folosi drept registrii auxiliari la swap
    push edx 
    push ecx
    ; i = eax
    inc eax 
    ; pun in edx valoarea lui buff[i], adaugand 4 sizeof(int32_u)
    mov edx, [edi + eax * 4]
    ; pun in ecx valoarea lui buff[j], adaugand 4 sizeof(int32_u)
    mov ecx, [edi + ebx * 4]
    ; fac swap intre valorile anterioare
    mov [edi + eax * 4], ecx
    ; fac swap intre valorile anterioare
    mov [edi + ebx * 4], edx
    pop ecx
    pop edx
    jmp increm_ebx

swap_end_and_pivot:
    ; pun pe stiva edx si ebx  ca sa i pot folosi drept registrii auxiliari la swap
    push edx 
    push ebx
    inc eax
    ; pun in edx valoarea lui buff[i +1], adaugand 4 sizeof(int32_u)
    mov edx, [edi + eax * 4]
    ; pun in ebx valoarea lui buff[end], adaugand 4 sizeof(int32_u)
    mov ebx, [edi + ecx * 4]
    ; fac swap intre valorile anterioare
    mov [edi + eax * 4], ebx
    ; fac swap intre valorile anterioare
    mov [edi + ecx * 4], edx
    pop ebx
    pop edx
    jmp end_pivot_find

end_swap_by_pivot:
    ; dupa ce am facut swap si am impartiti vectorul in 2 parti
    ; pun pivotul pe pozitia i+1
    jmp swap_end_and_pivot

end_pivot_find:
    ; scot ebx de pe stiva
    pop ebx
    ; dupa ce am calculat pivotul apelez functiile recursiv pe cele 2 ramuri
    jmp continue_sorting

end_sort:
    ;; restore the preserved registers
    pop esi
    pop edi
    pop ebx

    leave
    ret
