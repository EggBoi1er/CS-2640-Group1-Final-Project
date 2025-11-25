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

drawBorderTop:

drawBorderBot:

drawBorderLeft:

drawBorderRight:




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

