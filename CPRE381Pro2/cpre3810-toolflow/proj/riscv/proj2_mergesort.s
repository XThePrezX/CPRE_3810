.data
array:      .word 65, 12, 10, 89, 11, 70, 67, 5, 9, 45, 90, 7  # Example array to sort
array_size: .word 12                               # Size of array
temp_array: .space 48                              # Temporary array for merging (12 * 4 bytes)
newline:    .string "\n"

.text
.globl main

main:
    # Initialize stack pointer to 0x7FFFF7F0 (simpler than 0x7FFFFFF0)
    lui  sp, 0x7FFFF              # sp = 0x7FFFF000
    nop                # NOP 1 (data hazard)
    nop                # NOP 2
    nop                # NOP 3
    addi sp, sp, 0x7F0            # sp = 0x7FFFF7F0

    
    # Load array address
    lui  a0, 0x10010              # Assuming data at 0x10010000
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    addi a0, a0, 0                # Add offset (0 for first data item)

    
    # Load array_size address
    lui  t0, 0x10010
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    addi t0, t0, 48               # Offset for array_size (12 words * 4 bytes = 48)
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    lw   a1, 0(t0)                # a1 = array size
    nop                # NOP 1 (load delay)
    nop                # NOP 2
    nop                # NOP 3
    
    # Prepare mergesort arguments
    lui  a0, 0x10010              # Reload array address
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    addi a0, a0, 0
    
    li   a1, 0                    # a1 = left index (0)
  
    
    lui  t0, 0x10010
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    addi t0, t0, 48
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    lw   a2, 0(t0)                # a2 = right index (size)
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    addi a2, a2, -1               # a2 = size - 1
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    jal  ra, mergesort
    nop                # NOP 1 (jump delay)
    nop                # NOP 2
    
    # Exit program
    jal  ra, program_end
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3

# mergesort(array, left, right)
# a0 = array address
# a1 = left index
# a2 = right index
mergesort:
    addi sp, sp, -16
    nop
    nop
    nop
    sw   ra, 12(sp)
    sw   a0, 8(sp)
    sw   a1, 4(sp)
    sw   a2, 0(sp)
    
    # Base case: if left >= right, return
    bge  a1, a2, mergesort_return
    nop                # NOP 1 (branch delay)
    nop                # NOP 2
    nop                # NOP 3
    
    # Calculate mid = (left + right) / 2
    add  t0, a1, a2               # t0 = left + right
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    srai t0, t0, 1                # t0 = (left + right) / 2 (mid)
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    # Save mid
    addi sp, sp, -4
    nop
    nop
    nop
    sw   t0, 0(sp)
    
    # mergesort(array, left, mid)
    lw   a0, 12(sp)               # Restore array address

    
    lw   a1, 8(sp)                # Restore left

    lw   a2, 0(sp)                # Load mid as right
  
    
    jal  ra, mergesort
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    
    # mergesort(array, mid+1, right)
    lw   a0, 12(sp)               # Restore array address

    
    lw   a1, 0(sp)                # Load mid
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    addi a1, a1, 1                # a1 = mid + 1

    
    lw   a2, 4(sp)                # Restore right
  
    
    jal  ra, mergesort
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    # merge(array, left, mid, right)
    lw   a0, 12(sp)               # Restore array address

    
    lw   a1, 8(sp)                # Restore left

    
    lw   a2, 0(sp)                # Load mid

    
    lw   a3, 4(sp)                # Restore right

    
    jal  ra, merge
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    # Clean up mid from stack
    addi sp, sp, 4
    nop
    nop
    nop

mergesort_return:
    lw   ra, 12(sp)
 
    
    lw   a0, 8(sp)

    
    lw   a1, 4(sp)

    lw   a2, 0(sp)

    addi sp, sp, 16
    nop
    nop
    nop
    ret
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3

# merge(array, left, mid, right)
# a0 = array address
# a1 = left index
# a2 = mid index
# a3 = right index
merge:
    addi sp, sp, -32
    nop
    nop
    nop
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    sw   s1, 20(sp)
    sw   s2, 16(sp)
    sw   s3, 12(sp)
    sw   s4, 8(sp)
    sw   s5, 4(sp)
    sw   s6, 0(sp)
    
    mv   s0, a0                   # s0 = array address

    
    mv   s1, a1                   # s1 = i = left

    
    addi s2, a2, 1                # s2 = j = mid + 1

    
    mv   s3, a1                   # s3 = k = left

    mv   s4, a2                   # s4 = mid

    
    mv   s5, a3                   # s5 = right

    
    # Copy array to temp_array
    lui  s6, 0x10010              # s6 = temp array address base
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    addi s6, s6, 52               # Offset: 12*4 (array) + 4 (size) = 52

    
    mv   t0, a1                   # t0 = counter (left)
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3

copy_loop:
    bgt  t0, a3, copy_done        # if counter > right, done
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    slli t1, t0, 2                # t1 = counter * 4
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    add  t2, s0, t1               # t2 = &array[counter]
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    lw   t3, 0(t2)                # t3 = array[counter]
 
    add  t4, s6, t1               # t4 = &temp[counter]
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    sw   t3, 0(t4)                # temp[counter] = array[counter]
    
    addi t0, t0, 1                # counter++

    
    j    copy_loop
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3

copy_done:
merge_loop:
    bgt  s1, s4, merge_right      # if i > mid, copy from right
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    bgt  s2, s5, merge_left       # if j > right, copy from left
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    slli t0, s1, 2
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    add  t0, s6, t0
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    lw   t1, 0(t0)                # t1 = temp[i]
 
    slli t0, s2, 2
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    add  t0, s6, t0
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    lw   t2, 0(t0)                # t2 = temp[j]
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    ble  t1, t2, take_left        # if temp[i] <= temp[j], take left
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3

take_right:
    slli t0, s3, 2
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    add  t0, s0, t0
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    sw   t2, 0(t0)                # array[k] = temp[j]
    
    addi s2, s2, 1                # j++
    
    
    addi s3, s3, 1                # k++
    
    j    merge_loop
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3

take_left:
    slli t0, s3, 2
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    add  t0, s0, t0
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    sw   t1, 0(t0)                # array[k] = temp[i]
    
    addi s1, s1, 1                # i++
  
    
    addi s3, s3, 1                # k++
    
    
    j    merge_loop
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3

merge_left:
    bgt  s1, s4, merge_done       # if i > mid, done
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    slli t0, s1, 2
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    add  t0, s6, t0
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    lw   t1, 0(t0)                # t1 = temp[i]
   
    
    slli t0, s3, 2
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    add  t0, s0, t0
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    sw   t1, 0(t0)                # array[k] = temp[i]
    
    addi s1, s1, 1                # i++
   
    
    addi s3, s3, 1                # k++
    
    
    j    merge_left
    nop                # NOP 1
    nop                # NOP 2
    nop               # NOP 3

merge_right:
    bgt  s2, s5, merge_done       # if j > right, done
    nop                # NOP 1
    nop                # NOP 2
    nop               # NOP 3
    
    slli t0, s2, 2
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    add  t0, s6, t0
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    lw   t1, 0(t0)                # t1 = temp[j]
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    slli t0, s3, 2
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    add  t0, s0, t0
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3
    
    sw   t1, 0(t0)                # array[k] = temp[j]
    
    addi s2, s2, 1                # j++
   
    
    addi s3, s3, 1                # k++
    
    
    j    merge_right
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3

merge_done:
    lw   ra, 28(sp)
    
    lw   s0, 24(sp)
   
    
    lw   s1, 20(sp)
   
    
    lw   s2, 16(sp)
    
    
    lw   s3, 12(sp)
   
    lw   s4, 8(sp)
   
    
    lw   s5, 4(sp)
  
    
    lw   s6, 0(sp)
  
    
    addi sp, sp, 32
    nop
    nop
    nop
    
    ret
    nop                # NOP 1
    nop                # NOP 2
    nop                # NOP 3

program_end:
    wfi

