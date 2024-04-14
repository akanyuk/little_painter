	; Interrputed calls flow
MOVE_RIGHT_S 	equ #0010
MV_RIGHT_FST_S 	equ #0200

caller	db 0,0,0

	ld hl, (INTS_COUNTER)
	ld de, MOVE_RIGHT_S : call checkInts : jr nc, 1f
	ld hl, moveRight : jp startByInts
1	ld de, MV_RIGHT_FST_S : call checkInts : jr nc, 1f
	ld hl, moveRightFast : jp startByInts
1	; TODO: next check
	ret

	; hl - current cnt
	; de - what checking
checkInts	scf
	ld a, h : cp d : ret nz
	ld a, l : cp e : ret nz
	ccf
	ret
startByInts 	ld (starterAddr), hl
	ld hl, caller
	ld (hl), #c3 : inc hl ; jp
	ld (hl), low(starter) : inc hl ; jp
	ld (hl), high(starter) ; jp
	ret
stopByInts 	ld hl, caller
	ld (hl), 0 : inc hl 
	ld (hl), 0 : inc hl 
	ld (hl), 0 
	ret

starter	ld a, (INTS_COUNTER) : and 7 : cp 1 : jp z, CopyAltScr : or a : ret nz
starterAddr	equ $+1
	jp 0

moveRight	
_mvRightSt	equ $ + 1
	ld a, #ff : inc a : and #0f : ld (_mvRightSt), a
	or a : jr nz, _mrAddr

	ld hl, slow_player.movingRight.FRAME_0000
	ld (slow_player.playerReset), hl

	ld a, (_mrAddr + 1)
	inc a 
	cp #82
	jr nz, 1f
	; stopping proc
	xor a : ld (FillScreenBy), a : call FillScreen
	jp stopByInts 
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
	cp #88 : 
	jr nz, 1f
	; stopping proc
	xor a : ld (FillScreenBy), a : call FillScreen
	jp stopByInts 
1	ld (_mrfAddr + 1), a
_mrfAddr	ld de, #507f
	jp slow_player.play
