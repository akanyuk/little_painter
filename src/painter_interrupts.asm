	; Interrputed calls flow
PAINT_V1	equ #061f
MV_RIGHT 	equ #5000
MV_RIGHT_FST 	equ #6000

checker	db 0,0,0
	ld hl, (INTS_COUNTER)

	ld de, PAINT_V1 : call checkInts : jr nz, 1f
	ld hl, paintV1 : jp startByInts
1	ld de, MV_RIGHT : call checkInts : jr nz, 1f
	ld hl, moveRight : jp startByInts
1	ld de, MV_RIGHT_FST : call checkInts : jr nz, 1f
	ld hl, moveRightFast : jp startByInts
1	; TODO: next check
	ret

	; hl - current cnt
	; de - what checking
checkInts	ld a, h : cp d : ret nz
	ld a, l : cp e : ret nz
	xor a : or a
	ret
startByInts 	ld (starterAddr), hl
	ld hl, checker
	ld (hl), #c3 : inc hl ; jp
	ld (hl), low(starter) : inc hl ; jp
	ld (hl), high(starter) ; jp
	ret
stopByInts 	ld hl, checker
	ld (hl), 0 : inc hl 
	ld (hl), 0 : inc hl 
	ld (hl), 0 
	ret

starter	ld a, (INTS_COUNTER) : and 7 : cp 1 : jp z, CopyAltScr : or a : ret nz
starterAddr	equ $+1
	jp 0

	; scenes

paintV1cnt	equ $+1
paintV1	ld a, 0 : inc a : ld (paintV1cnt), a
	cp 1 : jr nz, 1f
	ld hl, bgBiblio_96x32 : ld a, 9 : jp DispSpr96x32
1	cp 5 : ret c : jr nz, 1f
	ld hl, sPnt0_32x32 : ld a, 12 : jp DispSpr32x32
1	cp 15 : ret c
	cp 35 : jr nc, 1f	
	ld hl, sPnt1_32x32
	ld a, (paintV1cnt) : and 1 : or a : jr nz, $ + 5
	ld hl, sPnt2_32x32
	ld a, 12 : jp DispSpr32x32
1	cp 35 : jr nz, 1f
	ld hl, sPnt0_32x32 : ld a, 12 : jp DispSpr32x32
1	cp 50 : ret c
	cp 70 : jr nc, 1f
	ld hl, sPnt1_32x32
	ld a, (paintV1cnt) : and 1 : or a : jr nz, $ + 5
	ld hl, sPnt2_32x32
	ld a, 12 : jp DispSpr32x32
1	cp 85 : jr nc, 1f
	ld hl, sPnt0_32x32 : ld a, 12 : jp DispSpr32x32
1	; stop here	
	xor a : ld (paintV1cnt), a
	call FillScreen
	jp stopByInts 

	; obsolete
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
