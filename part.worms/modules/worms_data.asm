WORM_DATA_LEN           equ 13 
LENGTH     	equ 0 ; original length
PILLAR_SRC	equ 1 ; src pillar
PILLAR_DST 	equ 2 ; dst pillar
DST_X        	equ 3 ; dst x coord
DST_Y        	equ 4 ; dst y coord
CUR_X      	equ 5 ; current head x
CUR_Y      	equ 6 ; current head y
CUR_ASS_X  	equ 7 ; current ass x
CUR_ASS_Y  	equ 8 ; current ass y
LATENCY    	equ 9 ; cur length (latency)
MOVE_DIR   	equ 10 ; current direction
LAST_DIR	equ 11 ; last moving direction
COLOR	equ 12 ; worm color

	; Build worms data
	;
	; PARAMS:
	; A - min length: 7, 15, 31... 
	; HL - address of colors (8 bytes)
Build	ld (.minLen1 + 1), a
	ld (.minLen2 + 1), a
	ld a, (NUM_WORMS)
	ld ix, WormsTable
	ld de, WORM_DATA_LEN
1	push af, hl

	ld (ix + PILLAR_SRC), #ff
	ld (ix + PILLAR_DST), a

	and %00000111
	ld b, 0 : ld c, a
	add hl, bc
	ld a, (hl)
	ld (ix + COLOR), a

	call Rnd
.minLen1	and 0	
.minLen2	add 0	
	ld (ix + LENGTH), a

	ld (ix + MOVE_DIR), DIRECTION_UNKNOWN
	ld (ix + LAST_DIR), DIRECTION_UNKNOWN

	add ix, de
	pop hl, af
	dec a : jr nz, 1b
	ret

	; Reset worms data
Reset	ld a, (NUM_WORMS) : ld b, a
	ld ix, WormsTable
1	push bc
	call worm.ResetWorm
	ld de, worms_data.WORM_DATA_LEN : add ix, de
	pop de : djnz 1b	
	
	jp worm.Start

	; Change worm path color
	;
	; PARAMS:
	; IX - worm data
ColorizeWay	ld a, (ix + MOVE_DIR)
	cp DIRECTION_LEFT : jr nz, .cwr
	call .attrAddr

		
	call pillars_data.GetBtw
	and %11111000
	rrca : rrca : rrca
	ld b, a
	dec b
	
	ld a, (ix + COLOR)
1	dec hl
	ld (hl), a
	djnz 1b
	ret

.cwr	cp DIRECTION_RIGHT : jr nz, .cwu
	call .attrAddr

		
	call pillars_data.GetBtw
	and %11111000
	rrca : rrca : rrca
	ld b, a
	dec b
	
	ld a, (ix + COLOR)
1	inc hl
	ld (hl), a
	djnz 1b
	ret

.cwu	cp DIRECTION_UP : jr nz, .cwd
	call .attrAddr

		
	call pillars_data.GetBtw
	and %11111000
	rrca : rrca : rrca
	ld b, a
	dec b
	
	ld a, (ix + COLOR)
	ld de, -32
1	add hl, de
	ld (hl), a
	djnz 1b
	ret

.cwd	call .attrAddr
		
	call pillars_data.GetBtw
	and %11111000
	rrca : rrca : rrca
	ld b, a
	dec b
	
	ld a, (ix + COLOR)
	ld de, 32
1	add hl, de
	ld (hl), a
	djnz 1b
	ret

.attrAddr	ld c, (ix + CUR_Y)
	ld b, (ix + CUR_X)
	jp AttrAddr
