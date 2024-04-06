A_PART_WORMS_INIT   	equ EXTERNAL_PART_START 
A_PART_WORMS_MAIN 	equ EXTERNAL_PART_START + 3
A_PART_WORMS_STOP   	equ EXTERNAL_PART_START + 6
A_PART_WORMS_SCENE1 	equ EXTERNAL_PART_START + 9
A_PART_WORMS_SCENE2	equ EXTERNAL_PART_START + 12
A_PART_WORMS_SCENE3	equ EXTERNAL_PART_START + 15
A_PART_WORMS_SCENE4 	equ EXTERNAL_PART_START + 18
A_PART_WORMS_SCENE5 	equ EXTERNAL_PART_START + 21

	xor a : call lib.SetScreen
	call lib.ClearScreen
	ld a, %01000000 : call lib.SetScreenAttr

	; painterPlaceholder
	ld a, %01101000
	ld (#5aff), a
	ld (#5afe), a
	ld (#5afd), a
	ld (#5adf), a
	ld (#5ade), a
	ld (#5add), a
	ld (#5abf), a
	ld (#5abe), a
	ld (#5abd), a

	call A_PART_WORMS_INIT

	call A_PART_WORMS_SCENE1
	ld bc, #c020 : call mainShow

	call A_PART_WORMS_SCENE2
	ld bc, #ff20 : call mainShow

	call A_PART_WORMS_SCENE3
	ld bc, #ff20 : call mainShow

	call prepareWithBlink

	call A_PART_WORMS_SCENE4
	ld bc, #ff0d : call mainShow

	call prepareWithBlink

	call A_PART_WORMS_SCENE5
	ld bc, #ff0d : call mainShow

	xor a : call lib.SetScreenAttr

	jr pipelineWormsEnd

	; PARAMS:
	; b - main frames cnt
	; c - after stop frames cnt
mainShow	ld a, c
	ld (mainStopWaiter + 1), a
1	push bc
	halt
	call A_PART_WORMS_MAIN
	pop bc
	djnz 1b

	call A_PART_WORMS_STOP
	
mainStopWaiter	ld b, #00
1	push bc
	halt
	call A_PART_WORMS_MAIN
	pop bc 
	djnz 1b
	ret


prepareWithBlink
	ld a, %00111111 : call lib.SetScreenAttr
	ld a, #07 : out (#fe), a
	call lib.ClearScreen
	halt : halt
	ld a, %01000000 : call lib.SetScreenAttr
	xor a : out (#fe), a
	ret

pipelineWormsEnd