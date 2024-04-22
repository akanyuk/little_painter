	; Interrputed calls flow

BEFORE_WAKE	equ #0658
WAKEUP	equ #06f0
GYMNASTIC	equ #0920
EAT	equ #0b70
PAINT_V1	equ #10c0
STAY1	equ #1600
STAY2	equ #1780
PAINT_V2	equ #1890
EAT2	equ #1b10
STAY3	equ #2006
STAY4	equ #2078
PAINT3	equ #2120
SLEEP	equ #2510
TRANSITION_OUT	equ #27c0

checker	db 0,0,0
	ld hl, (INTS_COUNTER)

1	ld de, BEFORE_WAKE : call checkInts : jr nz, 1f
	ld hl, beforeWake : jp startByInts
1	ld de, STAY1 : call checkInts : jr nz, 1f
	ld hl, stay1 : jp startByInts
1	ld de, STAY2 : call checkInts : jr nz, 1f
	ld hl, stay2 : jp startByInts
1	ld de, STAY3 : call checkInts : jr nz, 1f
	ld hl, stay1 : jp startByInts
1	ld de, STAY4 : call checkInts : jr nz, 1f
	ld hl, stay2 : jp startByInts
1	ld de, EAT : call checkInts : jr nz, 1f
	ld hl, eat : jp startByInts
1	ld de, EAT2 : call checkInts : jr nz, 1f
	ld hl, eat : jp startByInts
1	ld de, WAKEUP : call checkInts : jr nz, 1f
	ld hl, wakeup : jp startByInts
1	ld de, SLEEP : call checkInts : jr nz, 1f
	ld hl, sleep : jp startByInts
1	ld de, GYMNASTIC : call checkInts : jr nz, 1f
	ld hl, gymnastic : jp startByInts
1	ld de, PAINT_V1 : call checkInts : jr nz, 1f
	ld hl, paintV1 : jp startByInts
1	ld de, PAINT_V2 : call checkInts : jr nz, 1f
	ld hl, paintV2 : jp startByInts
1	ld de, PAINT3 : call checkInts : jr nz, 1f
	ld hl, paintV3 : jp startByInts
1	ld de, TRANSITION_OUT : call checkInts : jr nz, 1f
	ld hl, transitionOut : jp startByInts2
1	; TODO: next check
	ret

	; hl - current cnt
	; de - what checking
checkInts	ld a, h : cp d : ret nz
	ld a, l : cp e : ret nz
	xor a : or a
	ret
startByInts 	ld (starter8Addr), hl
	ld hl, checker
	ld (hl), #c3 : inc hl ; jp
	ld (hl), low(starter8) : inc hl ; jp
	ld (hl), high(starter8) ; jp
	ret
startByInts2 	ld (starter2Addr), hl
	ld hl, checker
	ld (hl), #c3 : inc hl ; jp
	ld (hl), low(starter2) : inc hl ; jp
	ld (hl), high(starter2) ; jp
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

starter2	ld a, (INTS_COUNTER) : and 1 : or a : jp nz, CopyAltScr
starter2Addr	equ $+1
	jp 0

starter8	ld a, (INTS_COUNTER) : and 7 : cp 1 : jp z, CopyAltScr : or a : ret nz
starter8Addr	equ $+1
	jp 0

	; scenes

beforeWake	ld hl, bed0_48x24 : ld a, 4 : call DispSpr48x24
	jp stopByInts

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
	ld a, 11 : call DispBgCol
	ld a, 11 : call DispBgCol
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

paintV3cnt	equ $+1
paintV3	ld a, 0 : inc a : ld (paintV3cnt), a
	cp 1 : jr nz, 1f
	ld a, 11 : call DispBgCol
	ld hl, sPnt0_32x24 : ld a, 12 : jp DispSpr32x24
1	cp 5 : ret c
	cp 30 : jr nc, 1f	
	ld hl, sPnt1_32x24
	ld a, (paintV3cnt) : and 1 : or a : jr nz, $ + 5
	ld hl, sPnt2_32x24
	ld a, 12 : jp DispSpr32x24
1	cp 30 : jr nz, 1f
	ld hl, sPnt0_32x24 : ld a, 12 : jp DispSpr32x24
1	cp 45 : ret c
	cp 76 : jr nc, 1f
	ld hl, sPnt1_32x24
	ld a, (paintV3cnt) : and 1 : or a : jr nz, $ + 5
	ld hl, sPnt2_32x24
	ld a, 12 : jp DispSpr32x24
1	cp 80 : jr nc, 1f
	ld hl, sPnt0_32x24 : ld a, 12 : jp DispSpr32x24
1	cp 100 : ret c	
1	; stop here	
	xor a : ld (paintV3cnt), a
	call DispBG
	jp stopByInts 

wakeupcnt	equ $+1
wakeup	ld a, 0 : inc a : ld (wakeupcnt), a
	cp 1 : jr nz, 1f
	ld hl, bed1_48x24 : ld a, 4 : jp DispSpr48x24
1	cp 10 : ret c : jr nz, 1f	
	ld hl, bed4_48x24 : ld a, 4 : jp DispSpr48x24
1	cp 30 : ret c : jr nz, 1f	
	ld hl, bed4_48x24 : ld a, 4 : jp DispSpr48x24
1	cp 30 : ret c : jr nz, 1f	
	ld hl, bed1_48x24 : ld a, 4 : jp DispSpr48x24
1	cp 40 : ret c : jr nz, 1f	
	ld hl, bed3_48x24 : ld a, 4 : jp DispSpr48x24
1	cp 45 : ret c : jr nz, 1f	
	ld a, 4 : call DispBgCol
	ld a, 5 : call DispBgCol
	ld hl, bed5_16x24 : xor a : jp DispSpr16x24
1	cp 50 : ret c : jr nz, 1f
	xor a : call DispBgCol
	ld a, 1 : jp DispBgCol
1	cp 55 : ret c
	; stop here	
	xor a : ld (wakeupcnt), a
	call DispBG
	jp stopByInts 

staycnt	equ $+1
stay1	ld a, 0 : inc a : ld (staycnt), a
	cp 1 : jr nz, 1f
	ld hl, stay0_16x24 : ld a, 16 : jp DispSpr16x24
	ld hl, stay0_16x24 : ld a, 16 : jp DispSpr16x24
1	cp 15 : ret c : jr nz, 1f	
	ld hl, stay1_16x24 : ld a, 16 : jp DispSpr16x24
	ld hl, stay1_16x24 : ld a, 16 : jp DispSpr16x24
1	cp 25 : ret c : jr nz, 1f	
	ld hl, stay0_16x24 : ld a, 16 : jp DispSpr16x24
	ld hl, stay0_16x24 : ld a, 16 : jp DispSpr16x24
1	cp 35 : ret c
	; stop here	
	xor a : ld (staycnt), a
	call DispBG
	jp stopByInts 

stay2cnt	equ $+1
stay2	ld a, 0 : inc a : ld (stay2cnt), a
	cp 1 : jr nz, 1f
	ld hl, stay2_0_16x24 : ld a, 11 : jp DispSpr16x24
	ld hl, stay2_0_16x24 : ld a, 11 : jp DispSpr16x24
1	cp 15 : ret c : jr nz, 1f	
	ld hl, stay2_1_16x24 : ld a, 11 : jp DispSpr16x24
	ld hl, stay2_1_16x24 : ld a, 11 : jp DispSpr16x24
1	cp 25 : ret c : jr nz, 1f	
	ld hl, stay2_0_16x24 : ld a, 11 : jp DispSpr16x24
	ld hl, stay2_0_16x24 : ld a, 11 : jp DispSpr16x24
1	; stop here	
	xor a : ld (stay2cnt), a
	jp stopByInts 

gymcnt	equ $+1
gymnastic	ld a, 0 : inc a : ld (gymcnt), a
	cp 1 : jr nz, 1f
	ld hl, gym1_32x24 : ld a, 15 : jp DispSpr32x24
1	cp 8 : ret c
	cp 60 : jr nc, 1f	
	cp 60 : jr nc, 1f	
	ld hl, gym3_32x24
	ld a, (gymcnt) : and 7 : cp 5 : jr c, $ + 5
	ld hl, gym2_32x24
	ld a, 15 : jp DispSpr32x24
1	cp 60 : jr nz, 1f
1	cp 60 : jr nz, 1f
	ld hl, gym1_32x24 : ld a, 15 : jp DispSpr32x24
1	cp 65 : ret c
1	cp 65 : ret c
1	; stop here	
	; xor a : ld (gymcnt), a
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
1	cp 100 : ret c : jr nz, 1f
	ld hl, eat1_24x24 : ld a, 27 : jp DispSpr24x24
1	cp 112 : ret c : jr nz, 1f
	ld hl, eat3_24x24 : ld a, 27 : jp DispSpr24x24
1	cp 115 : ret c : jr nz, 1f	
	ld hl, eat4_24x24 : ld a, 27 : jp DispSpr24x24
1	cp 118 : ret c
1	cp 142 : jr nc, 1f
	ld hl, eat1_24x24
	ld a, (eatcnt) : and 1 : or a : jr nz, $ + 5
	ld hl, eat2_24x24
	ld a, 27 : jp DispSpr24x24
1	cp 150 : ret c

	; stop here	
	xor a : ld (eatcnt), a
	call DispBG
	jp stopByInts 

sleepcnt	equ $+1
sleep	ld a, 0 : inc a : ld (sleepcnt), a
	cp 1 : jr nz, 1f
	ld hl, bed1_48x24 : ld a, 4 : jp DispSpr48x24
1	cp 8 : ret c : jr nz, 1f	
	ld hl, bed4_48x24 : ld a, 4 : jp DispSpr48x24
1	cp 50 : ret c : jr nz, 1f	
	ld hl, bed1_48x24 : ld a, 4 : jp DispSpr48x24
1	cp 72 : ret c : jr nz, 1f	
	ld hl, bed0_48x24 : ld a, 4 : jp DispSpr48x24
1	; stop here	
	; xor a : ld (sleepcnt), a
	; call DispBG
	jp stopByInts 

tOutCnt	equ $+1
transitionOut	ld a, 0 : inc a : ld (tOutCnt), a
	cp 110 : jp nz, TransitionOut
	; stop here	
	; xor a : ld (sleepcnt), a
	; call DispBG
	jp stopByInts 	