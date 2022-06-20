section .bss
     digits resb 100
     d_spacePos resb 8 

section .text 
    global _start 

_start: 
    mov rax,985
    call _printRAXdigits
    mov rax ,60 
    mov rdi , 0
    syscall    
_printRAXdigits: 
    mov rcx ,digits
    mov rbx, 10 
    mov [rcx] ,rbx
    inc rcx 
    mov [d_spacePos] ,rcx ; to add end of line  \n 
_Loop : 
    mov rdx ,0 
    mov rbx ,10 
    div rbx 
    push rax 
    add rdx ,48 
    mov [rcx] ,dl 
    inc rcx 
    mov [d_spacePos],rcx 
    pop rax 
    cmp rax ,0
    jne _Loop
_printLoop: 
    mov rcx ,[d_spacePos]
    mov rax,1
    mov rdi ,1
    mov rsi ,rcx 
    mov rdx ,1 
    syscall 
    mov rcx , [d_spacePos]
    dec rcx 
    mov [d_spacePos] ,rcx 
    cmp rcx ,digits
    jge _printLoop