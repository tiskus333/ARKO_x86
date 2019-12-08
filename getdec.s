    section .text
    global getdec

getdec:
    push rbp
    mov rbp, rsp

    mov dl, [rdi]
    cmp dl, 0
    jz end

    dec rdi

loop_1:
    inc rdi
    mov dl, [rdi]
    cmp dl, 0
    jz end

    cmp dl, '0'
    jl not_number
    cmp dl, '9'
    jg not_number

    mov r8b, 1
    sub dl, '0'
    lea rbx, [rbx*4 +rbx]
    lea rbx, [rdx + rbx*2]

    jmp loop_1
not_number:
    cmp r8b, 0
    jz loop_1

end:
    mov rax, rbx
    mov rsp, rbp
    pop rbp
    ret

