.section rodata

    # sum = 0.0
    sum: .single 0.0

.data

.text

    .globl collect
    collect:
        
        # int i = 0
        movl    $0, %r12
