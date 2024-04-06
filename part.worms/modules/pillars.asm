	; Get pillar parameters
	;
	; PARAMS:
	; A - current pillar index
	;
	; RETURN: 
	; E - x coord
	; L - y coord
GetParams	call seek
	ld e, (iy + pillars_data.OUT_X)
	ld l, (iy + pillars_data.OUT_Y)
	ret

	; Next pillar index and direction
	;
	; PARAMS:
	; A - current pillar index;
	; L - last moving direction (prefering backware moving)
	; RETURN: 
	; A - pillar index (#FF - no free pillars);
	; C - direction
Next	
	push ix
	ld ix, .next_available
	ld (ix + 0), #ff
	ld (ix + 2), #ff
	ld (ix + 4), #ff
	
	call seek

	ld a, l : cp DIRECTION_RIGHT : jr z, 1f
	ld a, (iy + pillars_data.PILLAR_LEFT) : ld c, a 
	call isBusy : or a : jr nz, 1f
	ld (ix + 0), c
	ld a, DIRECTION_LEFT : ld (ix + 1), a
	inc ix : inc ix

1	ld a, l : cp DIRECTION_LEFT : jr z, 1f
	ld a, (iy + pillars_data.PILLAR_RIGHT) : ld c, a
	call isBusy : or a : jr nz, 1f
	ld (ix + 0), c
	ld a, DIRECTION_RIGHT : ld (ix + 1), a
	inc ix : inc ix

1	ld a, l : cp DIRECTION_DOWN : jr z, 1f
	ld a, (iy + pillars_data.PILLAR_UP) : ld c, a
	call isBusy : or a : jr nz, 1f
	ld (ix + 0), c
	ld a, DIRECTION_UP : ld (ix + 1), a
	inc ix : inc ix

1	ld a, l : cp DIRECTION_UP : jr z, 1f
	ld a, (iy + pillars_data.PILLAR_DOWN) : ld c, a
	call isBusy : or a : jr nz, 1f
	ld (ix + 0), c
	ld a, DIRECTION_DOWN : ld (ix + 1), a

1	; give rnd direction
	call Rnd : and %00000011
	ld hl, .next_available - 2
1	inc hl : inc hl
	dec a : cp #ff : jr nz, 1b
	ld a, (hl)
	inc hl : ld c, (hl)
	
	pop ix 
	ret
.next_available	block 6, 0
	db #ff, #ff

	; Lock pillar
	;
	; PARAMS:
	; A - pillar index
Lock	cp #ff : ret z
	push af 
	call seek 
	ld (iy + pillars_data.BUSY), 1
	pop af
	ret

	; Release pillar
	; 
	; PARAMS:
	; A - pillar index
Release	cp #ff : ret z
	push af 
	call seek 
	ld (iy + pillars_data.BUSY), 0
	pop af
	ret

	; Worm going into pillar
	;
	; PARAMS:
	; A - pillar index
GoIn	cp #ff : ret z
	push af, bc
	call seek 
	ld b, (iy + pillars_data.OUT_X)
	ld c, (iy + pillars_data.OUT_Y)
	call AttrAddr
	call pillars_data.GetColorBusy
	ld  (hl), a
	pop bc, af
	ret

	; Worm going out from pillar
	;
	; PARAMS:
	; A - pillar index
GoOut	cp #ff : ret z
	push af, bc
	call seek 
	ld b, (iy + pillars_data.OUT_X)
	ld c, (iy + pillars_data.OUT_Y)
	call AttrAddr
	call pillars_data.GetColorEmpty
	ld  (hl), a
	pop bc, af
	ret

	; Check if pillar already busy
	;
	; PARAMS:
	; A - pillar index
	;
	; RETURN:
	; A - 0: free; not 0: busy
isBusy	cp #ff : ret z ; no pillar = busy
	push iy
	call seek
	ld a, (iy + pillars_data.BUSY)
	pop iy
	ret

	; Finding pillar data address
	;
	; PARAMS:
	; A : pillar index
	;
	; RETURN:
	; IY - data address
seek	ld iy, PillarsTable
	ld de, pillars_data.PILLAR_DATA_LEN
1	dec a : cp #ff : ret z
	add iy, de
	jr 1b

