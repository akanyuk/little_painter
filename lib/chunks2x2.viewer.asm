	/*
	Работа с чанками 2х2 на основе изображения 128х80, 16 оттенков яркости
	*/
	jp init	; START + 0 - инициализация модуля. hl - адрес с данными
	jp main	; START + 3 - основная процедура вывода кадра
	jp setBright	; START + 6 - установка яркости. A - яркость [0-3], C - индекс цвета [0-f]

main	ld ix, 0
	ld h, high CHUNK_SRC

	ld b, 80
1	push bc
	push de
	ld b, 32
2	push bc

	// draw 4 chunks from two bytes of source data 
	; top line
	ld a, (ix + 0)
	ld b, a
	and %00001111
	add a : ld l, a  
	ld a, (hl) : and %00110000 : ld c, a
	inc l : ld a, (hl) : and %00110000 : push af

	ld a, b
	rra : rra : rra
	and %00011110
	ld l, a
	ld a, (hl) : and %11000000 : or c : ld c, a
	inc l : ld a, (hl) : and %11000000 : push af

	ld a, (ix + 1)
	ld b, a
	and %00001111
	add a : ld l, a
	ld a, (hl) : and %00000011 : or c : ld c, a
	inc l : ld a, (hl) : and %00000011 : push af

	ld a, b
	rra : rra : rra
	and %00011110
	ld l, a
	ld a, (hl) : and %00001100 : or c : ld c, a
	inc l : ld a, (hl) : and %00001100 : push af

	ld a, c : ld (de), a
	
	// bottom line
	inc d
	pop af
	pop bc : or b
	pop bc : or b
	pop bc : or b
	ld (de), a
	dec d

	inc ix : inc ix
	inc de
	pop bc
	djnz 2b

	pop de
	inc d : call downDE
	pop bc
	djnz 1b

	ret
downDE	inc d : ld a,d : and #07 : ret nz : ld a,e : sub #e0 : ld e,a : sbc a,a : and #f8 : add a,d : ld d,a : ret

init	ld (main + 2), hl
	ret

setBright	ld de, CHUNK_SRC
	ld h, 0 : ld l, c : add hl, hl
	add hl, de
	cp 3 : jr nz, sc1
	ld (hl), %11111111 : inc hl : ld (hl), %11111111
	ret
sc1	cp 2 : jr nz, sc2
	ld (hl), %01010101 : inc hl : ld (hl), %10101010
	ret
sc2	cp 1 : jr nz, sc3
	ld (hl), %01010101 : inc hl : ld (hl), %00000000
	ret
sc3	ld (hl), 0 : inc hl : ld (hl), 0
	ret

	align #100
	;  db upperLine, lowerLine
CHUNK_SRC	block 32, 0

