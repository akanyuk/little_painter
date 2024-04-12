	ld a, 127
	ld hl, #4062
	ld (hl), a
	inc h
	ld (hl), a
	inc h
	ld (hl), a
	ld (#4462), a
	ld a, 224
	ld (#4161), a
	ld (#4661), a
	ld a, 226
	ld (#4461), a
	ld a, 237
	ld (#4561), a
	ld a, 191
	ld (#4562), a
	ld a, 63
	ld (#4662), a
	ret
