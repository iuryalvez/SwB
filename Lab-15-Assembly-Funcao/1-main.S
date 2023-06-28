.section .rodata

str: .string "Hello"

.data

.globl val
.align 4
val: .long 432

.globl age
.align 2
age: .word 4

.globl r
.align 4
r: .long 0

.globl err
.align 8
err: .quad 2048

.text


.globl main

main:

   pushq %rbp

   movq  %rsp, %rbp

   # Seu código aqui...

   movq  $str, %rdi # movendo o primeiro parâmetro # (%rdi, %edi, %di, %dil)
   movl  val, %esi  # movendo o segundo parâmetro  # (%rsi, %esi, %si, #sil)
   movw  age, %dx   # movendo o terceiro parâmetro # (%rdx, %edx, %dx, %dl)
   movq  $r, %rcx   # movendo quarto parâmetro     # (%rcx, %ecx, %cx, %cl)

   call sum # chamando função

   movl  %eax, val

   movq  err, %rdi
   movl  val, %esi
   movq  r, %rdx

   call show

   movl  $0, %eax

   leave

   ret