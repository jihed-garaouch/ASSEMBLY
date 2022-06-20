global _start

section .text

_start:
    mov rax , 2
    mov rdi  , file
    mov rsi , 65
    mov rdx ,0644o
    syscall
    push rax 
    mov rdi ,rax 
    mov rax, 1
    mov rsi, text
    mov rdx, 31
    syscall
    mov rax , 3
    pop rdi 
    syscall
    mov rax,60
    mov rdi, 0
    syscall

section .data
    file: db "newFile.txt",0
    text : db "this file created with assembly"
