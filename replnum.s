    section .text
    global replnum

replnum:
    push rbp
    mov rbp, rsp

    ;check if first character is '\0'
    mov dl, [rdi]
    cmp dl, 0
    jz end

    ;check if character to replace with is a visible character
    cmp rsi, ' '
    jl end

    ;clear bl register, will bw used as number found flag
    xor bl, bl

    mov rcx, rdi
    dec rdi

loop_1:
    inc rdi 

    mov dl, [rdi]
    cmp dl, 0
    jz end

    cmp dl, '9'
    jg skip_digit
    cmp dl, '0'
    jge number_found
skip_digit:
    xor bl,bl
    mov [rcx], dl
    inc rcx
    jmp loop_1

number_found:
    cmp bl, 1
    je loop_1
    inc bl
    mov rdx, rsi
    mov [rcx], dl
    inc rcx
    jmp loop_1

end:
    mov byte [rcx], 0
    mov rsp, rbp
    pop rbp
    ret