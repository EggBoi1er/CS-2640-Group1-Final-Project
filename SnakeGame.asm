# Group 1: Alex Eng, Carter Do, Youseff Garcia, Evan Nguyen
# 11/21/2025
# Goal: Create a Snake Game

.data
frameBuffer: .space 0x80000
xPos: .word 50
yPos: .word 50  

.text
main:
    la 	$t0, frameBuffer #Loads the frame buffer address
    li $t1, 2048 # 512 by 256 pixels
    li $t2, 0xFFFFFF #Draws the background to be white

bg_loop:
    sw $t2, 0(t0)
    addi, $t0, $t0, 4 #Next spot to fill in the pixels
    addi, $t1, $t1, -1 #Decrease the number of pixel of needed
    bnez, $t1, bg_loop #Repeat the pixels until there is no pixels left to fill in the background

    la $t0, bg_loop
    li $t1, 64
    li $t2, 0x00000000

drawBorderTop:

drawBorderBot:

drawBorderLeft:

drawBorderRight: