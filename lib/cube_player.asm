CUBE_DATA_LEN	equ 5
FRAME     	equ 0 ; Первый фрейм / Текущий фрейм
LAST_FRAME     	equ 1 ; Последний фрейм
PAUSE_START	equ 2 ; Задержка от начала сцены
SCR_LOW 	equ 3 ; Младший байт адреса вывода фрейма
SCR_HIGHT      	equ 4 ; Старший байт адреса вывода фрейма

; b: количество кубов	
; iy: настройки кубов
	ld de, CUBE_DATA_LEN
2	push bc
	push de
	call PlayCube
	pop de
	add iy, de
	pop bc : djnz 2b
	ret

PlayCube	; is over?
	ld a, (iy + LAST_FRAME) : cp (iy + FRAME) : ret z

	; pause before start
	ld a, (iy + PAUSE_START) : or a : jr z, 1f
	dec a : ld (iy + PAUSE_START), a
	ret

1	ld a, (iy + FRAME) : inc a : ld (iy + FRAME), a
	; determine animation address
	ld h, 0 : ld l, a : add hl, hl
	ld de, FRAMES : add hl, de
	ld e,(hl) : inc hl
	ld d,(hl) : inc hl
	ex de, hl

	; screen address from config
	ld e, (iy + SCR_LOW) 
	ld d, (iy + SCR_HIGHT) 

	; shifting screen address from animation
	ld c,(hl) : inc hl 
	ld b,(hl) : inc hl
	ex de,hl
	add hl,bc
	ex de,hl
	xor a : ld b,a
cycle	ld a,(hl)
	inc hl
	ld c,a
	rla
	jp nc,2f
	rlca		; cp  #80
	ret c
	; long jump
	ld  a,c
	and #0f
	add a,d : ld d,a
	bit 4,c
	jp  z, cycle
	ld a,#80
	add e
	ld e,a
	jp nc,cycle
	inc d
	jp  cycle
2	rlca
	jp c,nearJmp
	inc c		; copy N bytes to screen
	ldir
	jp cycle
nearJmp	ld a,c
	res 6,a
	inc a
	add e
	ld e,a
	jp nc,cycle
	inc d
	jp  cycle

FRAMES	dw FRAME_0000
	dw FRAME_0001
	dw FRAME_0002
	dw FRAME_0003
	dw FRAME_0004
	dw FRAME_0005
	dw FRAME_0006
	dw FRAME_0007
	dw FRAME_0008
	dw FRAME_0009
	dw FRAME_000a
	dw FRAME_000b
	dw FRAME_000c
	dw FRAME_000d
	dw FRAME_000e
	dw FRAME_000f
	dw FRAME_0010
	dw FRAME_0011
	dw FRAME_0012
	dw FRAME_0013
	dw FRAME_0014
	dw FRAME_0015
	dw FRAME_0016
	dw FRAME_0017
	dw FRAME_0018
	dw FRAME_0019
	dw FRAME_001a
	dw FRAME_001b
	dw FRAME_001c
	dw FRAME_001d
	dw FRAME_001e
	dw FRAME_001f

FRAME_0000	include "cubes/0000.asm"
FRAME_0001	include "cubes/0001.asm"
FRAME_0002	include "cubes/0002.asm"
FRAME_0003	include "cubes/0003.asm"
FRAME_0004	include "cubes/0004.asm"
FRAME_0005	include "cubes/0005.asm"
FRAME_0006	include "cubes/0006.asm"
FRAME_0007	include "cubes/0007.asm"
FRAME_0008	include "cubes/0008.asm"
FRAME_0009	include "cubes/0009.asm"
FRAME_000a	include "cubes/000a.asm"
FRAME_000b	include "cubes/000b.asm"
FRAME_000c	include "cubes/000c.asm"
FRAME_000d	include "cubes/000d.asm"
FRAME_000e	include "cubes/000e.asm"
FRAME_000f	include "cubes/000f.asm"
FRAME_0010	include "cubes/0010.asm"
FRAME_0011	include "cubes/0011.asm"
FRAME_0012	include "cubes/0012.asm"
FRAME_0013	include "cubes/0013.asm"
FRAME_0014	include "cubes/0014.asm"
FRAME_0015	include "cubes/0015.asm"
FRAME_0016	include "cubes/0016.asm"
FRAME_0017	include "cubes/0017.asm"
FRAME_0018	include "cubes/0018.asm"
FRAME_0019	include "cubes/0019.asm"
FRAME_001a	include "cubes/001a.asm"
FRAME_001b	include "cubes/001b.asm"
FRAME_001c	include "cubes/001c.asm"
FRAME_001d	include "cubes/001d.asm"
FRAME_001e	include "cubes/001e.asm"
FRAME_001f	include "cubes/001f.asm"
