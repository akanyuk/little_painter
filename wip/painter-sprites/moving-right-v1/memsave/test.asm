	device zxspectrum128

	org #5d00
	ld sp, $-2
	ld hl, #5800
	ld de, #5801
	ld bc, #02ff
	ld (hl), %01000111
	ldir

1   ei : halt
    ld de, #4000
	ld a,1 : out (#fe),a
	call	player
	xor a : out (#fe),a
	jp	1b

player	module memsave
	include "player.asm"
	endmodule

	display /d, "Animation size: ", $-player
	savesna "memsave.sna", #5d00
