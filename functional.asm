; Interpret as 64 bits code
[bits 64]



section .text
global map
global reduce
map:
   
    push rbp
    mov rbp, rsp
    push rbx
    ; sa-nceapa turneu'
    ; rdi destinatia
    ; rsi sursa
    ; rdx nr elemente
    ; rcx  functia de map
    ; contor pentru bucla
    xor rbx, rbx 
map_for:
    ; compar contorul cu nr de elemente 
    cmp rdx, rbx
    je map_end
    ; pun pe stiva toti registri necesari pentru a fii sigur
    ; ca nu se modifica de apelul functia de map
    push rdi
    push rsi
    push rdx
    push rcx
    push rbx
    ; pun in rdi argumentul functiei map adica src[i]
    mov rdi, [rsi + rbx * 8]
    ; apelez functia de map
    call rcx
    ; dau pop la registri pentru a-i recupera
    pop rbx
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    ; pun rezultatul in destinatie
    mov [rdi + rbx * 8], rax
    ; incrementez contorul
    inc rbx
    ; sar la inceputul buclei
    jmp map_for
map_end:
    pop rbx

    leave
    ret


; int reduce(int *dst, int *src, int n, int acc_init, int(*f)(int, int));
; int f(int acc, int curr_elem);
reduce:

    push rbp
    mov rbp, rsp

    push rbx
    ; sa-nceapa festivalu'
    ; rdi destinatia
    ; rsi sursa
    ; rdx nr elemente
    ; rcx  acumulatorul initial
    ; r8   functia de reduce
    ; contor pentru bucla
    xor rbx, rbx 
reduce_for:
    cmp rdx, rbx
    je reduce_end
    ; pun pe stiva toti registri necesari pentru a fii sigur
    ; ca nu se modifica de apelul functia de reduce
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push rbx
    ; pun in rdi si rsi argumentele pentru functia de reduce
    mov rdi, rcx
    ; pun in rsi valoarea lui src[i], adaugand 8*rbx 
    ; pentru ca rbx este pe 8 octeti
    mov rsi, [rsi + rbx * 8]
    ; apelez functia de reduce
    call r8
    ; dau pop la registri pentru a-i recupera
    pop rbx
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    ; pun rezultatul in acumulator
    mov rcx, rax
    ; incrementez contorul
    inc rbx
    ; sar la inceputul buclei
    jmp reduce_for

reduce_end:
    pop rbx
    leave
    ret

