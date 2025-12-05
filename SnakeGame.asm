# Group 1: Alex Eng, Carter Do, Youseff Garcia, Evan Nguyen
# 11/21/2025
# Goal: Create a Snake Game

.data
frameBuffer: .space 131072 # 512 by 256 pixels
xPos: .word 50
yPos: .word 50 
# snake speed
xSpeed: .word 0
ySpeed: .word 0 
tail: .word 7624
#starting apple position
xApple: .word 32
yApple: .word 16
xConvert: .word 64 # num of tiles per row
yConvert: .word 4 # num of bytes per pixel

.text
main:
	la $t0, frameBuffer #Loads the frame buffer address
	li $t1, 2048 # number of writes in the bg_loop
	li $t2, 0xFFFFFF #Draws the background to be white

bg_loop:
	sw $t2, 0($t0)
	addi, $t0, $t0, 4 #Next spot to fill in the pixels
	addi, $t1, $t1, -1 #Decrease the number of pixel of needed
	bnez, $t1, bg_loop #Repeat the pixels until there is no pixels left to fill in the background

	la $t0, frameBuffer
	li $t1, 64
	li $t2, 0x00000000

border_top:
	sw $t2, 0($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, -1
	bnez $t1, border_top

	la $t0, frameBuffer
	li $t1, 32

border_bottom:
	sw $t2, 0($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, -1
	bnez $t1, border_bottom

	la $t0, frameBuffer
	li $t1, 32

border_left:
	sw $t2, 0($t0)
	addi $t0, $t0, 256
	addi $t1, $t1, -1
	bnez $t1, border_left

	la $t0, frameBuffer
	addi $t0, $t0, 252
	li $t1, 32

border_right:
	sw $t2, 0($t0)
	addi $t0, $t0, 256
	addi $t1, $t1, -1
	bnez $t1, border_right



# updating the snakeHeadPosition
# use addiu to make sure theres no overflow
updateSnakeHeadPosition:
	# prepare stack so it can use registers and run correctly
	addiu $sp, $sp, -24
	sw $fp, 0($sp)
	sw $ra, 4($sp)
	addiu $fp, $sp, 20
	
	# get the snakes current position and speed
	lw $t3, xSpeed
	lw $t4, ySpeed
	lw $t5, xPos
	lw $t6, yPos
	
	# move the snake head to its new position
	add $t5, $t5, $t3
	add $t6, $t6, $t4

	# store the updated position
	sw $t5, xPos
	sw $t6, yPos
	
	# restore stack and go back to where the function was orignally called
	lw $ra, 4($sp)
	lw $fp, 0($sp)
	addiu $sp, $sp, 24
	jr $ra


# creating the apple
drawApple:
	#set up stack
	addiu $sp, $sp, -24
	sw $fp, 0($sp)
	sw $ra, 4($sp)
	addiu $fp, $sp, 20
	
	#get apple's x and y
	lw $t0, xApple
	lw $t1, yApple
	
	#turn coordinate into a tile number
	lw $t2, xConvert
	mult $t1, $t2
	mflo $t3
	add $t3, $t3, $t0
	
	#turn tile number into byte address
	lw $t2, yConvert
	mult $t3, $t2
	mflo $t0
	
	#go to address in framebuffer
	la $t1, frameBuffer
	add $t0, $t1, $t0
	
	#create a red pixel for the apple
	li $t4, 0x00ff0000
	sw $t4, 0($t0)
	
	#restoring the stack
	lw $ra, 4($sp)
	lw $fp, 0($sp)
	addiu $sp, $sp, 24
	jr $ra

newAppleLocation:
    addiu $sp, $sp, -24
    sw $fp, 0($sp)
    sw $ra, 4($sp)
    addiu $fp, $sp, 20

	#random location for apple generation
randomGenerator:
    li $v0, 42
    li $a1, 63
    syscall
    move $t1, $a0

    li $v0, 42
    li $a1, 31
    syscall
    move $t2, $a0

    lw $t3, xConvert
    mult $t2, $t3
    mflo $t4
    add $t4, $t4, $t1
    lw $t3, yConvert
    mult $t4, $t3
    mflo $t4

    la $t0, frameBuffer
    add $t0, $t0, $t4
    lw $t5, 0($t0)

    li $t6, 0xffffff
    bne $t5, $t6, randomGenerator

    sw $t1, xApple
    sw $t2, yApple

    lw $ra, 4($sp)
    lw $fp, 0($sp)
    addiu $sp, $sp, 24
    jr $ra

gameOver:
    # exit 
    li $v0, 10
    syscall






