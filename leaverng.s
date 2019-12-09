    section .text
    global leaverng

leaverng:
    push rbp
    mov rbp, rsp

     ;check if first character is '\0'
    mov cl, [rdi]
    cmp cl, 0
    jz end

    ;rsi lower bound
    cmp rsi, ' '
    jl end
    cmp rsi, '~'
    jg end

    ;upper bound
    cmp rdx, ' '
    jl end
    cmp rdx, '~'
    jg end

    mov rbx, rdi
    dec rdi

loop_1:
    inc rdi
    mov cl, [rdi]
    cmp cl, 0
    jz end_func
    cmp byte cl, sil
    jl oor
    cmp byte cl, dl
    jle loop_1
oor:
    mov [rbx], cl
    inc rbx
    jmp loop_1

end_func:
    mov byte [rbx], 0
end:
    mov rsp, rbp
    pop rbp
    ret
