	; Interrputed calls flow
EAT	equ #0010
WAKEUP	equ #1018
GYMNASTIC	equ #0a08
PAINT_V2	equ #0680
PAINT_V1	equ #1430

checker	db 0,0,0
	ld hl, (INTS_COUNTER)

	ld de, EAT : call checkInts : jr nz, 1f
	ld hl, eat : jp startByInts
1	ld de, WAKEUP : call checkInts : jr nz, 1f
	ld hl, wakeup : jp startByInts
1	ld de, GYMNASTIC : call checkInts : jr nz, 1f
	ld hl, gymnastic : jp startByInts
1	ld de, PAINT_V1 : call checkInts : jr nz, 1f
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

wakeupcnt	equ $+1
wakeup	ld a, 0 : inc a : ld (wakeupcnt), a
	cp 1 : jr nz, 1f
	ld hl, bed1_48x24 : ld a, 4 : call DispSpr48x24
1	cp 20 : ret c : jr nz, 1f	
	ld hl, bed4_48x24 : ld a, 4 : call DispSpr48x24
1	cp 25 : ret c : jr nz, 1f	
	ld hl, bed1_48x24 : ld a, 4 : call DispSpr48x24
1	cp 35 : ret c : jr nz, 1f	
	ld hl, bed2_48x24 : ld a, 4 : call DispSpr48x24
1	cp 40 : ret c
	; stop here	
	xor a : ld (wakeupcnt), a
	call DispBG
	jp stopByInts 

gymcnt	equ $+1
gymnastic	ld a, 0 : inc a : ld (gymcnt), a
	cp 1 : jr nz, 1f
	ld hl, gym1_32x24 : ld a, 15 : jp DispSpr32x24
1	cp 10 : ret c
	cp 48 : jr nc, 1f	
	ld hl, gym3_32x24
	ld a, (gymcnt) : and 7 : cp 5 : jr c, $ + 5
	ld hl, gym2_32x24
	ld a, 15 : jp DispSpr32x24
1	cp 48 : jr nz, 1f
	ld hl, gym1_32x24 : ld a, 15 : jp DispSpr32x24
1	cp 61 : ret c
1	; stop here	
	xor a : ld (gymcnt), a
	call DispBG
	jp stopByInts 

eatcnt	equ $+1
eat	ld a, 0 : inc a : ld (eatcnt), a
	cp 1 : jr nz, 1f
	ld hl, eat1_24x24 : ld a, 27 : jp DispSpr24x24
1	cp 10 : ret c : jr nz, 1f
	ld hl, eat3_24x24 : ld a, 27 : jp DispSpr24x24
1	cp 13 : ret c : jr nz, 1f	
	ld hl, eat4_24x24 : ld a, 27 : jp DispSpr24x24
1	cp 16 : ret c
	cp 36 : jr nc, 1f
	ld hl, eat1_24x24
	ld a, (eatcnt) : and 1 : or a : jr nz, $ + 5
	ld hl, eat2_24x24
	ld a, 27 : jp DispSpr24x24
1	cp 45 : ret c : jr nz, 1f	
	ld hl, eat3_24x24 : ld a, 27 : jp DispSpr24x24
1	cp 48 : ret c : jr nz, 1f	
	ld hl, eat4_24x24 : ld a, 27 : jp DispSpr24x24
1	cp 51 : ret c
	cp 71 : jr nc, 1f
	ld hl, eat1_24x24
	ld a, (eatcnt) : and 1 : or a : jr nz, $ + 5
	ld hl, eat2_24x24
	ld a, 27 : jp DispSpr24x24
1	cp 85 : ret c : jr nz, 1f
	ld hl, eat5_24x24 : ld a, 27 : jp DispSpr24x24
1	cp 92 : ret c : jr nz, 1f
	ld hl, eat1_24x24 : ld a, 27 : jp DispSpr24x24
1	cp 104 : ret c
	cp 124 : jr nc, 1f
	ld hl, eat1_24x24
	ld a, (eatcnt) : and 1 : or a : jr nz, $ + 5
	ld hl, eat2_24x24
	ld a, 27 : jp DispSpr24x24
1	cp 132 : ret c

	; stop here	
	xor a : ld (eatcnt), a
	call DispBG
	jp stopByInts 
