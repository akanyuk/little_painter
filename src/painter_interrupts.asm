	; Interrputed calls flow
MOVE_RIGHT_S 	equ #0660
MOVE_RIGHT_E 	equ #0a20

MV_RIGHT_FST_S 	equ #0a22
MV_RIGHT_FST_E 	equ #1000

	ld hl, (INTS_COUNTER)
	
	ld de, MOVE_RIGHT_S
	ld a, l : cp e : jr nz, 1f
	ld a, h : cp d : jr nz, 1f
	ld hl, moveRight : ld (caller), hl : xor a : ld (skipper), a : ret

1	ld de, MOVE_RIGHT_E
	ld a, l : cp e : jr nz, 1f
	ld a, h : cp d : jr nz, 1f
	ld a, #c9 : ld (skipper), a
	xor a : ld (FillScreenBy), a : call FillScreen
	jp CopyAltScr

1	ld de, MV_RIGHT_FST_S
	ld a, l : cp e : jr nz, 1f
	ld a, h : cp d : jr nz, 1f
	ld hl, moveRightFast : ld (caller), hl : xor a : ld (skipper), a : ret

1	ld de, MV_RIGHT_FST_E
	ld a, l : cp e : jr nz, 1f
	ld a, h : cp d : jr nz, 1f
	ld a, #c9 : ld (skipper), a
	xor a : ld (FillScreenBy), a : call FillScreen
	jp CopyAltScr

1	; TODO: next check

skipper	ret ; nothing to do
	ld a, (INTS_COUNTER) : and 7 : cp 1 : jp z, CopyAltScr : or a : ret nz
caller	equ $+1	
	jp 0

	; calls here
moveRight	
_mvRightSt	equ $ + 1
	ld a, #ff : inc a : and #0f : ld (_mvRightSt), a
	or a : jr nz, _mrAddr

	ld hl, slow_player.movingRight.FRAME_0000
	ld (slow_player.playerReset), hl

	ld a, (_mrAddr + 1)
	inc a 
	cp #9e
	jr nz, 1f
	xor a : ld (FillScreenBy), a : call FillScreen
	ld a, #80
1	ld (_mrAddr + 1), a
_mrAddr	ld de, #507f
	jp slow_player.play

moveRightFast	
_mvRightFstSt	equ $+1
	ld a, #ff : inc a : and #07 : ld (_mvRightFstSt), a
	or a : jr nz, _mrfAddr

	ld hl, slow_player.movingRightFast.FRAME_0000
	ld (slow_player.playerReset), hl

	ld a, (_mrfAddr + 1)
	inc a 
	cp #9e
	jr nz, 1f
	xor a : ld (FillScreenBy), a : call FillScreen
	ld a, #80
1	ld (_mrfAddr + 1), a
_mrfAddr	ld de, #507f
	jp slow_player.play
