	; Interrputed calls flow
; DISP_BG	equ #0008
; WAKEUP	equ #0018

DISP_BG	equ #0620
WAKEUP	equ #06f0
GYMNASTIC	equ #0920
EAT	equ #0b70
PAINT_V1	equ #10e0
STAY1	equ #1600
STAY2	equ #1780
PAINT_V2	equ #1890
EAT2	equ #1b30
STAY3	equ #2006
STAY4	equ #20a8
PAINT3	equ #21b8
SLEEP	equ #24b0

checker	db 0,0,0
	ld hl, (INTS_COUNTER)

1	ld de, DISP_BG : call checkInts : jr nz, 1f
	ld hl, dispBG : jp startByInts
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
1	ld de, PAINT3 : call checkInts : jr nz, 1f
	ld hl, paintV3 : jp startByInts
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

dispBG	ld a, %00101000
	call SetScreenAttr
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
1	cp 12 : ret c : jr nz, 1f	
	ld hl, bed4_48x24 : ld a, 4 : jp DispSpr48x24
1	cp 48 : ret c : jr nz, 1f	
	ld hl, bed1_48x24 : ld a, 4 : jp DispSpr48x24
1	cp 80 : ret c : jr nz, 1f	
	ld hl, bed0_48x24 : ld a, 4 : jp DispSpr48x24
1	; stop here	
	; xor a : ld (sleepcnt), a
	; call DispBG
	jp stopByInts 