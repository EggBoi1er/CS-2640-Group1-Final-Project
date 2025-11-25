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
	sw $t2, 0(t0)
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
	addiu $sp, $sp, -24
	sw $fp, 0($sp)
	sw $ra, 4($sp)
	addiu $fp, $sp, 20


