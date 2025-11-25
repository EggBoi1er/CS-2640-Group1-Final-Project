# Snake Head Position
# Only tests updateSnakeHeadPosition

.data
xPos:   .word 50 # initial x position
yPos:   .word 50 # initial y position
xSpeed: .word 1 # move right
ySpeed: .word 0 # no vertical movement

.text
main:
	# call the function 5 times to see if it increases
	jal updateSnakeHeadPosition
	jal updateSnakeHeadPosition
	jal updateSnakeHeadPosition
	jal updateSnakeHeadPosition
	jal updateSnakeHeadPosition

	# exit
	li $v0, 10
	syscall

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

# it worked because t5 and t6 changed
