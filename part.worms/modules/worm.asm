	; Stop moving worms
Stop	ld a, #c9 : ld (waitMove), a : ret

	; Start moving worms
Start	xor a : ld (waitMove), a : ret

Move	ld a, (ix + worms_data.MOVE_DIR)
	cp DIRECTION_LEFT : jr nz, 1f : jp moveLeft
1	cp DIRECTION_RIGHT : jr nz, 1f : jp moveRight
1	cp DIRECTION_UP : jr nz, 1f : jp moveUp
1	cp DIRECTION_DOWN : jr nz, 1f : jp moveDown
1	jp waitMove ; no free pillars - wait
	ret

	; ix - WORMS_DATA
ResetWorm	ld a, DIRECTION_UNKNOWN : ld (ix + worms_data.MOVE_DIR), a
	ld a, (ix + worms_data.LENGTH) : ld (ix + worms_data.LATENCY), a
	
	ld a, (ix + worms_data.PILLAR_DST) : ld (ix + worms_data.PILLAR_SRC), a
	call pillars.Lock
	call pillars.GetParams
	ld (ix + worms_data.CUR_X), e
	ld (ix + worms_data.CUR_ASS_X), e
	ld (ix + worms_data.CUR_Y), l
	ld (ix + worms_data.CUR_ASS_Y), l
	ret
	
waitMove	db #00
	ld a, (ix + worms_data.PILLAR_SRC)
	ld l, (ix + worms_data.LAST_DIR)
	call pillars.Next
	cp #ff : ret z

	ld (ix + worms_data.MOVE_DIR), c
	ld (ix + worms_data.LAST_DIR), c
	
	ld (ix + worms_data.PILLAR_DST), a
	call pillars.Lock
	call pillars.GetParams
	ld (ix + worms_data.DST_X), e
	ld (ix + worms_data.DST_Y), l

	call worms_data.ColorizeWay
	ret

moveLeft
	; latency (clean ass)
	ld a, (ix + worms_data.LATENCY)
	cp #01 : jp z, releaseAss 
	or a : jr nz, 1f
	ld a, (ix + worms_data.CUR_ASS_X) : cp (ix + worms_data.DST_X) : jp z, ResetWorm

	dec a ; x2
	dec a : ld (ix + worms_data.CUR_ASS_X), a
	ld e, a	
	ld l, (ix + worms_data.CUR_ASS_Y)
	call dot2x2.ClearLeft
	jr 2f
1	dec (ix + worms_data.LATENCY)
2	ld a, (ix + worms_data.CUR_X) : cp (ix + worms_data.DST_X) : jp z, goIn
	dec a ; x2
	dec a : ld (ix + worms_data.CUR_X), a
	ld e, a	
	ld l, (ix + worms_data.CUR_Y)
	jp dot2x2.Set

moveRight
	; latency (clean ass)
	ld a, (ix + worms_data.LATENCY)
	cp #01 : jp z, releaseAss 
	or a : jr nz, 1f
	ld a, (ix + worms_data.CUR_ASS_X) : cp (ix + worms_data.DST_X) : jp z, ResetWorm

	inc a ; x2
	inc a : ld (ix + worms_data.CUR_ASS_X), a
	ld e, a	
	ld l, (ix + worms_data.CUR_ASS_Y)
	call dot2x2.ClearRight
	jr 2f
1	dec (ix + worms_data.LATENCY)
2	ld a, (ix + worms_data.CUR_X) : cp (ix + worms_data.DST_X) : jp z, goIn
	inc a ; x2
	inc a : ld (ix + worms_data.CUR_X), a
	ld e, a	
	ld l, (ix + worms_data.CUR_Y)
	jp dot2x2.Set

moveUp
	; latency (clean ass)
	ld a, (ix + worms_data.LATENCY)
	cp #01 : jp z, releaseAss 
	or a : jr nz, 1f
	ld a, (ix + worms_data.CUR_ASS_Y) : cp (ix + worms_data.DST_Y) : jp z, ResetWorm

	dec a ; x2
	dec a : ld (ix + worms_data.CUR_ASS_Y), a
	ld l, a	
	ld e, (ix + worms_data.CUR_ASS_X)
	call dot2x2.ClearUp
	jr 2f
1	dec (ix + worms_data.LATENCY)
2	ld a, (ix + worms_data.CUR_Y) : cp (ix + worms_data.DST_Y) : jp z, goIn
	dec a ; x2
	dec a : ld (ix + worms_data.CUR_Y), a
	ld l, a	
	ld e, (ix + worms_data.CUR_X)
	jp dot2x2.Set

moveDown
	; latency (clean end)
	ld a, (ix + worms_data.LATENCY)
	cp #01 : jp z, releaseAss 
	or a : jr nz, 1f
	ld a, (ix + worms_data.CUR_ASS_Y) : cp (ix + worms_data.DST_Y) : jp z, ResetWorm

	inc a ; x2
	inc a : ld (ix + worms_data.CUR_ASS_Y), a
	ld l, a	
	ld e, (ix + worms_data.CUR_ASS_X)
	call dot2x2.ClearDown
	jr 2f
1	dec (ix + worms_data.LATENCY)
2	ld a, (ix + worms_data.CUR_Y) : cp (ix + worms_data.DST_Y) : jp z, goIn
	inc a ; x2
	inc a : ld (ix + worms_data.CUR_Y), a
	ld l, a	
	ld e, (ix + worms_data.CUR_X)
	jp dot2x2.Set

goIn	ld a, (ix + worms_data.PILLAR_DST)
	call pillars.GoIn

	ret

releaseAss	dec (ix + worms_data.LATENCY)
	ld a, (ix + worms_data.PILLAR_SRC)
	call pillars.GoOut
	jp pillars.Release

	