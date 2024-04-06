PILLAR_DATA_LEN         equ 7

BUSY 	equ 0 ; is busy; #00 - free
OUT_X	equ 1
OUT_Y	equ 2
PILLAR_LEFT	equ 3 ; next pillar; #ff - none	
PILLAR_RIGHT	equ 4 ; next pillar; #ff - none	
PILLAR_UP	equ 5 ; next pillar; #ff - none	
PILLAR_DOWN	equ 6 ; next pillar; #ff - none	

SETTINGS	block 9, 0
SETTINGS_BTW	equ 0
SETTINGS_COLS	equ 1
SETTINGS_ROWS	equ 2
SETTINGS_COLS_DEC	equ 3
SETTINGS_ROWS_DEC	equ 4
SETTINGS_MRGX	equ 5
SETTINGS_MRGY	equ 6
SETTINGS_COLOR_EMPTY	equ 7
SETTINGS_COLOR_BUSY	equ 8

	; Get number of pixels between pillars
	;
	; RETURNS:
	; A - number of pixels between pillars
GetBtw	ld a, (SETTINGS + SETTINGS_BTW)
	ret

	; Get color of empty pillar
	;
	; RETURNS:
	; A - color value
GetColorEmpty	ld a, (SETTINGS + SETTINGS_COLOR_EMPTY)
	ret

	; Get color of busy pillar
	;
	; RETURNS:
	; A - color value
GetColorBusy	ld a, (SETTINGS + SETTINGS_COLOR_BUSY)
	ret

	; Setup rows and cols
	;
	; PARAMS:
	; D - cols
	; E - rows
SetupDimension	ld iy, SETTINGS
	ld (iy + SETTINGS_COLS), d
	dec d : ld (iy + SETTINGS_COLS_DEC), d
	ld (iy + SETTINGS_ROWS), e
	dec e : ld (iy + SETTINGS_ROWS_DEC), e
	ret

	; Setup margins
	;
	; PARAMS:
	; D - margin x
	; E - margin y
SetupMargins	ld iy, SETTINGS
	ld a, 3 : add d : ld (iy + SETTINGS_MRGX), a
	ld a, 3 : add e : ld (iy + SETTINGS_MRGY), a
	ret

	; Setup colors
	;
	; PARAMS:
	; D - color of empty pillar
	; E - color of busy pillar
SetupColors	ld iy, SETTINGS
	ld (iy + SETTINGS_COLOR_EMPTY), d
	ld (iy + SETTINGS_COLOR_BUSY), e
	ret

	; Build pillars data
	; 
	; PARAMS:
	; A - pixels between pillars
Build	ld (.btw1 + 1), a
	ld (.btw2 + 1), a
	ld iy, SETTINGS
	ld (iy + SETTINGS_BTW), a

	ld ix, PillarsTable
	ld de, PILLAR_DATA_LEN
	xor a ; start row
.buidRow	push af
	ld (.CUR_ROW + 1), a
	xor a ; start col
.buidCol	push af
	ld (.CUR_COL + 1), a

	ld c, 0 : ld (ix + BUSY), 0 ; free

.CUR_ROW	ld b, 0
	inc b
	ld a, (iy + SETTINGS_BTW) : neg : add (iy + SETTINGS_MRGY)
.btw1	add a, 0
	djnz .btw1
	ld (ix + OUT_Y), a

.CUR_COL	ld b, 0
	inc b
	ld a, (iy + SETTINGS_BTW) : neg : add (iy + SETTINGS_MRGX)
.btw2	add a, 0
	djnz .btw2 
	ld (ix + OUT_X), a

	ld a, #ff
	ld (ix + PILLAR_LEFT), a
	ld (ix + PILLAR_RIGHT), a
	ld (ix + PILLAR_UP), a
	ld (ix + PILLAR_DOWN), a

	; left sibling
	ld a, (.CUR_COL + 1) : or a : jr z, 1f
	call .multCurRow : dec a : ld (ix + PILLAR_LEFT), a
1
	; right sibling
	ld a, (.CUR_COL + 1) : cp (iy + SETTINGS_COLS_DEC) : jr z, 1f
	call .multCurRow : inc a : ld (ix + PILLAR_RIGHT), a

1	ld hl, .CUR_COL + 1

	; up sibling
	ld a, (.CUR_ROW + 1) : or a : jr z, 1f
	call .curRowMultiplier
	sub (iy + SETTINGS_COLS)
	add (hl)
	ld (ix + PILLAR_UP), a
1
	; down sibling
	ld a, (.CUR_ROW + 1) : cp (iy + SETTINGS_ROWS_DEC) : jr z, 1f
	call .curRowMultiplier
	add (iy + SETTINGS_COLS)
	add (hl)
	ld (ix + PILLAR_DOWN), a
1
	add ix, de
	pop af : inc a : cp (iy + SETTINGS_COLS) : jp nz, .buidCol ; next col
	pop af : inc a : cp (iy + SETTINGS_ROWS) : jp nz, .buidRow ; next row
	ld (ix + 0), #ff ; stop byte
	ret

	; PARAMS:
	; IY - setups address
.multCurRow	ex af, af'
	ld a, (.CUR_ROW + 1)
	ld b, a
	inc b
	ex af, af'
1	add (iy + SETTINGS_COLS)
	djnz 1b
	sub (iy + SETTINGS_COLS)
	ret

	; PARAMS:
	; IY - setups address
.curRowMultiplier	ld a, (.CUR_ROW + 1)
	ld b, a
	inc b
	ld a, (iy + SETTINGS_COLS) : : neg
1	add (iy + SETTINGS_COLS)
	djnz 1b
	ret

	; Display current builded pillars
Show	ld ix, PillarsTable
1	ld a, (ix + 0) : cp #ff : ret z

	ld b, (ix + OUT_X)
	ld c, (ix + OUT_Y)
	call AttrAddr
	ld a, (SETTINGS + SETTINGS_COLOR_EMPTY) : ld  (hl), a

	ld de, PILLAR_DATA_LEN
	add ix, de
	jr 1b

