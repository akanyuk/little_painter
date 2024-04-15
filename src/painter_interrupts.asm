	; Interrputed calls flow
PAINT_V1	equ 8
PAINT_V2	equ #061f

checker	db 0,0,0
	ld hl, (INTS_COUNTER)

	ld de, PAINT_V1 : call checkInts : jr nz, 1f
	ld hl, paintV1 : jp startByInts
1	ld de, PAINT_V2 : call checkInts : jr nz, 1f
	ld hl, paintV2 : jp startByInts
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
stopByInts 	ld hl, checker + 1
	ld (hl), low(_stpStage2)
	inc hl : ld (hl), high(_stpStage2) 
	ret
_stpStage2 	call CopyAltScr
	ld hl, checker
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
	ld hl, sPnt0_32x24 : ld a, 12 : jp DispSpr32x24
1	cp 5 : ret c
	cp 25 : jr nc, 1f	
	ld hl, sPnt1_32x24
	ld a, (paintV1cnt) : and 1 : or a : jr nz, $ + 5
	ld hl, sPnt2_32x24
	ld a, 12 : jp DispSpr32x24
1	cp 25 : jr nz, 1f
	ld hl, sPnt0_32x24 : ld a, 12 : jp DispSpr32x24
1	cp 40 : ret c
	cp 60 : jr nc, 1f
	ld hl, sPnt1_32x24
	ld a, (paintV1cnt) : and 1 : or a : jr nz, $ + 5
	ld hl, sPnt2_32x24
	ld a, 12 : jp DispSpr32x24
1	cp 68 : jr nc, 1f
	ld hl, sPnt0_32x24 : ld a, 12 : jp DispSpr32x24
1	cp 75 : jr nc, 1f
	ld hl, sPnt3_32x24 : ld a, 12 : jp DispSpr32x24
1	cp 79 : ret c : jr nz, 1f
	ld hl, sPnt0_32x24 : ld a, 12 : jp DispSpr32x24
1	cp 90 : ret c
	cp 110 : jr nc, 1f
	ld hl, sPnt1_32x24
	ld a, (paintV1cnt) : and 1 : or a : jr nz, $ + 5
	ld hl, sPnt2_32x24
	ld a, 12 : jp DispSpr32x24
1	cp 120 : jr nc, 1f
	ld hl, sPnt0_32x24 : ld a, 12 : jp DispSpr32x24
1	; stop here	
	xor a : ld (paintV1cnt), a
	call DispBG
	jp stopByInts 

paintV2cnt	equ $+1
paintV2	ld a, 0 : inc a : ld (paintV2cnt), a
	cp 1 : jr nz, 1f
	ld hl, sPnt0_32x24 : ld a, 12 : jp DispSpr32x24
1	cp 5 : ret c
	cp 25 : jr nc, 1f	
	ld hl, sPnt1_32x24
	ld a, (paintV2cnt) : and 1 : or a : jr nz, $ + 5
	ld hl, sPnt2_32x24
	ld a, 12 : jp DispSpr32x24
1	cp 25 : jr nz, 1f
	ld hl, sPnt0_32x24 : ld a, 12 : jp DispSpr32x24
1	cp 40 : ret c
	cp 60 : jr nc, 1f
	ld hl, sPnt1_32x24
	ld a, (paintV2cnt) : and 1 : or a : jr nz, $ + 5
	ld hl, sPnt2_32x24
	ld a, 12 : jp DispSpr32x24
1	cp 75 : jr nc, 1f
	ld hl, sPnt0_32x24 : ld a, 12 : jp DispSpr32x24
1	; stop here	
	xor a : ld (paintV2cnt), a
	call DispBG
	jp stopByInts 
