; Interpret as 32 bits code
[bits 32]

%include "../include/io.mac"

section .text
; int check_parantheses(char *str)
global check_parantheses
check_parantheses:
    push ebp
    mov ebp, esp
    ; char *str
    mov ecx, dword [ebp + 8] 
    ; calculez lungimea stringului
    ; folosesc edx drept contor
    xor edx, edx 

length_string:
    mov al, byte [ecx]
    test al, al
    je end_length_string
    inc edx
    inc ecx
    jmp length_string

end_length_string:
    ; acum am lungimea stringului in edx
    ; verific daca stringul are paranteze corecte
    ; presupun ca stringul are paranteze corecte
    xor eax, eax 
    ; restabilesc stringul initial
    ; char *str
    mov edi, [ebp + 8] 
    ; la fiecare paranteza deschisa pun in stiva
    ; la fiecare paranteza inchisa scot din stiva
    ; daca o paranteza nu e inchisa corect, atunci parantezele nu sunt inchise
    ; corect
    ; daca la final stiva nu mai are paranteza inseamna ca parantezarea este 
    ; corecta

parantezare_corecta:
    ; compar contorul cu 0 pentru a ma opri
    cmp edx, 0
    je check_stack_done
    dec edx
    mov cl, byte [edi]
    inc edi
    ; compar cl cu (
    cmp cl , 0x28 
    je push_paranteza
    ; compar cl cu [
    cmp cl , 0x5B 
    je push_paranteza
    ; compar cl cu {
    cmp cl , 0x7B
    je push_paranteza
    ; compar cl cu )
    cmp cl , 0x29 
    je pop_paranteza_rotunda
    ; compar cl cu ]
    cmp cl , 0x5D 
    je pop_paranteza_dreapta
    ; comapr cl cu }
    cmp cl , 0x7D 
    je pop_acolada

push_paranteza:
    ; pun paranteza deschisa pe stiva
    push ecx
    jmp parantezare_corecta

pop_paranteza_rotunda:
    pop ecx
    ; compar cl cu (, complementaara lui )
    cmp cl, 0x28
    jne parantezare_gresita
    jmp parantezare_corecta

pop_paranteza_dreapta:
    pop ecx
    ; compar cl cu [, complementaara lui ]
    cmp cl, 0x5B
    jne parantezare_gresita
    jmp parantezare_corecta

pop_acolada:
    pop ecx
    ; compar cl cu {, complementaara lui }
    cmp cl, 0x7B
    jne parantezare_gresita
    jmp parantezare_corecta

parantezare_gresita:
    ; pun in eax 1 insemnand parantezare gresita
    mov eax, 1
    jmp end_parantezare_corecta

check_stack_done:
    pop ecx
    ; verific daca stiva e goala
    cmp ecx, [ebp]
    jne parantezare_gresita
    push ecx
    jmp end_parantezare_corecta

end_parantezare_corecta:


    leave
    ret
