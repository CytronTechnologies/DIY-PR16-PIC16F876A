opt subtitle "HI-TECH Software Omniscient Code Generator (Lite mode) build 6738"

opt pagewidth 120

	opt lm

	processor	16F876A
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
# 14 "C:\Users\Phang\Desktop\9.80\PR 16\PR16RX.c"
	psect config,class=CONFIG,delta=2 ;#
# 14 "C:\Users\Phang\Desktop\9.80\PR 16\PR16RX.c"
	dw 0x3F32 ;#
	FNCALL	_main,_read_packet
	FNCALL	_read_packet,_uart_rec
	FNROOT	_main
	global	main@F459
psect	idataBANK0,class=CODE,space=0,delta=2
global __pidataBANK0
__pidataBANK0:
	file	"C:\Users\Phang\Desktop\9.80\PR 16\PR16RX.c"
	line	36

;initializer for main@F459
	retlw	07Fh
	retlw	0Dh
	retlw	0B7h
	retlw	09Fh
	retlw	0CDh
	retlw	0DBh
	retlw	0FBh
	retlw	0Fh
	retlw	0FFh
	retlw	0DFh
	retlw	0EFh
	retlw	0F9h
	retlw	073h
	retlw	0BDh
	retlw	0F3h
	retlw	0E3h
	global	read_packet@counter
	global	_PORTB
_PORTB	set	6
	global	_RCREG
_RCREG	set	26
	global	_CREN
_CREN	set	196
	global	_OERR
_OERR	set	193
	global	_RCIF
_RCIF	set	101
	global	_RX9
_RX9	set	198
	global	_SPEN
_SPEN	set	199
	global	_SPBRG
_SPBRG	set	153
	global	_TRISB
_TRISB	set	134
	global	_BRGH
_BRGH	set	1218
	file	"PR 16.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bssCOMMON,class=COMMON,space=1
global __pbssCOMMON
__pbssCOMMON:
read_packet@counter:
       ds      1

psect	dataBANK0,class=BANK0,space=1
global __pdataBANK0
__pdataBANK0:
	file	"C:\Users\Phang\Desktop\9.80\PR 16\PR16RX.c"
main@F459:
       ds      16

; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbssCOMMON)+0)&07Fh
global btemp
psect inittext,class=CODE,delta=2
global init_fetch,btemp
;	Called with low address in FSR and high address in W
init_fetch:
	movf btemp,w
	movwf pclath
	movf btemp+1,w
	movwf pc
global init_ram
;Called with:
;	high address of idata address in btemp 
;	low address of idata address in btemp+1 
;	low address of data in FSR
;	high address + 1 of data in btemp-1
init_ram:
	fcall init_fetch
	movwf indf,f
	incf fsr,f
	movf fsr,w
	xorwf btemp-1,w
	btfsc status,2
	retlw 0
	incf btemp+1,f
	btfsc status,2
	incf btemp,f
	goto init_ram
; Initialize objects allocated to BANK0
psect cinit,class=CODE,delta=2
global init_ram, __pidataBANK0
	bcf	status, 7	;select IRP bank0
	movlw low(__pdataBANK0+16)
	movwf btemp-1,f
	movlw high(__pidataBANK0)
	movwf btemp,f
	movlw low(__pidataBANK0)
	movwf btemp+1,f
	movlw low(__pdataBANK0)
	movwf fsr,f
	fcall init_ram
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	??_uart_rec
??_uart_rec:	; 0 bytes @ 0x0
	global	?_read_packet
?_read_packet:	; 1 bytes @ 0x0
	global	?_uart_rec
?_uart_rec:	; 1 bytes @ 0x0
	ds	1
	global	uart_rec@rec_data
uart_rec@rec_data:	; 1 bytes @ 0x1
	ds	1
	global	??_read_packet
??_read_packet:	; 0 bytes @ 0x2
	ds	1
	global	read_packet@checksum
read_packet@checksum:	; 1 bytes @ 0x3
	ds	1
	global	read_packet@data
read_packet@data:	; 1 bytes @ 0x4
	ds	1
	global	??_main
??_main:	; 0 bytes @ 0x5
	ds	4
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	main@_7seg
main@_7seg:	; 16 bytes @ 0x0
	ds	16
	global	main@no
main@no:	; 1 bytes @ 0x10
	ds	1
	global	main@num
main@num:	; 1 bytes @ 0x11
	ds	1
;;Data sizes: Strings 0, constant 0, data 16, bss 1, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      9      10
;; BANK0           80     18      34
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:



;;
;; Critical Paths under _main in COMMON
;;
;;   _main->_read_packet
;;   _read_packet->_uart_rec
;;
;; Critical Paths under _main in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 4, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                22    22      0     229
;;                                              5 COMMON     4     4      0
;;                                              0 BANK0     18    18      0
;;                        _read_packet
;; ---------------------------------------------------------------------------------
;; (1) _read_packet                                          4     4      0      91
;;                                              2 COMMON     3     3      0
;;                           _uart_rec
;; ---------------------------------------------------------------------------------
;; (2) _uart_rec                                             2     2      0      23
;;                                              0 COMMON     2     2      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 2
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _read_packet
;;     _uart_rec
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BANK3               60      0       0       9        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;BANK2               60      0       0      11        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITSFR2              0      0       0       5        0.0%
;;SFR1                 0      0       0       2        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;CODE                 0      0       0       0        0.0%
;;DATA                 0      0      2E      12        0.0%
;;ABS                  0      0      2C       3        0.0%
;;NULL                 0      0       0       0        0.0%
;;STACK                0      0       2       2        0.0%
;;BANK0               50     12      22       5       42.5%
;;BITBANK0            50      0       0       4        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR0              0      0       0       1        0.0%
;;COMMON               E      9       A       1       71.4%
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 32 in file "C:\Users\Phang\Desktop\9.80\PR 16\PR16RX.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  _7seg          16    0[BANK0 ] unsigned char [16]
;;  num             1   17[BANK0 ] unsigned char 
;;  no              1   16[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0      18       0       0       0
;;      Temps:          4       0       0       0       0
;;      Totals:         4      18       0       0       0
;;Total ram usage:       22 bytes
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_read_packet
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"C:\Users\Phang\Desktop\9.80\PR 16\PR16RX.c"
	line	32
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 6
; Regs used in _main: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	39
	
l1738:	
;PR16RX.c: 34: unsigned char num,no;
;PR16RX.c: 36: unsigned char _7seg[16]={0b01111111,0b00001101,0b10110111,0b10011111,
;PR16RX.c: 37: 0b11001101,0b11011011,0b11111011,0b00001111,
;PR16RX.c: 38: 0b11111111,0b11011111,0b11101111,0b11111001,
;PR16RX.c: 39: 0b01110011,0b10111101,0b11110011,0b11100011};
	movlw	(main@_7seg)&0ffh
	movwf	fsr0
	movlw	low(main@F459)
	movwf	(??_main+0)+0
	movf	fsr0,w
	movwf	((??_main+0)+0+1)
	movlw	16
	movwf	((??_main+0)+0+2)
u2230:
	movf	(??_main+0)+0,w
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	
	movf	indf,w
	movwf	((??_main+0)+0+3)
	incf	(??_main+0)+0,f
	movf	((??_main+0)+0+1),w
	movwf	fsr0
	
	movf	((??_main+0)+0+3),w
	movwf	indf
	incf	((??_main+0)+0+1),f
	decfsz	((??_main+0)+0+2),f
	goto	u2230
	line	42
	
l1740:	
;PR16RX.c: 42: TRISB = 0b00000000;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(134)^080h	;volatile
	line	45
	
l1742:	
;PR16RX.c: 45: BRGH = 0;
	bcf	(1218/8)^080h,(1218)&7
	line	46
	
l1744:	
;PR16RX.c: 46: SPBRG = 255;
	movlw	(0FFh)
	movwf	(153)^080h	;volatile
	line	47
	
l1746:	
;PR16RX.c: 47: SPEN = 1;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(199/8),(199)&7
	line	48
	
l1748:	
;PR16RX.c: 48: RX9 = 0;
	bcf	(198/8),(198)&7
	line	49
	
l1750:	
;PR16RX.c: 49: CREN = 1;
	bsf	(196/8),(196)&7
	line	51
	
l1752:	
;PR16RX.c: 51: num=0;
	clrc
	movlw	0
	btfsc	status,0
	movlw	1
	movwf	(main@num)
	line	52
	
l1754:	
;PR16RX.c: 52: PORTB=_7seg[num];
	movf	(main@num),w
	addlw	main@_7seg&0ffh
	movwf	fsr0
	movf	indf,w
	movwf	(6)	;volatile
	goto	l1756
	line	54
;PR16RX.c: 54: while(1)
	
l499:	
	line	56
	
l1756:	
;PR16RX.c: 55: {
;PR16RX.c: 56: CREN=1;
	bsf	(196/8),(196)&7
	line	57
	
l1758:	
;PR16RX.c: 57: if(OERR==0) no=read_packet();
	btfsc	(193/8),(193)&7
	goto	u2241
	goto	u2240
u2241:
	goto	l500
u2240:
	
l1760:	
	fcall	_read_packet
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(main@no)
	goto	l1762
	line	58
	
l500:	
;PR16RX.c: 58: else CREN=0;
	bcf	(196/8),(196)&7
	goto	l1762
	
l501:	
	line	60
	
l1762:	
;PR16RX.c: 60: if(no <= 0x0f) num=no;
	movlw	(010h)
	subwf	(main@no),w
	skipnc
	goto	u2251
	goto	u2250
u2251:
	goto	l1766
u2250:
	
l1764:	
	movf	(main@no),w
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(main@num)
	goto	l1766
	
l502:	
	line	62
	
l1766:	
;PR16RX.c: 62: PORTB=_7seg[num];
	movf	(main@num),w
	addlw	main@_7seg&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(6)	;volatile
	goto	l1756
	line	63
	
l503:	
	line	54
	goto	l1756
	
l504:	
	line	64
	
l505:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_read_packet
psect	text109,local,class=CODE,delta=2
global __ptext109
__ptext109:

;; *************** function _read_packet *****************
;; Defined at:
;;		line 80 in file "C:\Users\Phang\Desktop\9.80\PR 16\PR16RX.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  data            1    4[COMMON] unsigned char 
;;  checksum        1    3[COMMON] unsigned char 
;;  received_byt    1    0        unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         2       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         3       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_uart_rec
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text109
	file	"C:\Users\Phang\Desktop\9.80\PR 16\PR16RX.c"
	line	80
	global	__size_of_read_packet
	__size_of_read_packet	equ	__end_of_read_packet-_read_packet
	
_read_packet:	
	opt	stack 6
; Regs used in _read_packet: [wreg+status,2+status,0+pclath+cstack]
	line	93
;PR16RX.c: 82: unsigned char received_byte;
;PR16RX.c: 85: static unsigned char counter = 0;
;PR16RX.c: 88: unsigned char data;
;PR16RX.c: 89: unsigned char checksum;
;PR16RX.c: 93: do {
	
l516:	
	line	96
;PR16RX.c: 96: while (uart_rec() != 0xaa);
	goto	l1728
	
l518:	
	goto	l1728
	
l517:	
	
l1728:	
	fcall	_uart_rec
	xorlw	0AAh
	skipz
	goto	u2211
	goto	u2210
u2211:
	goto	l1728
u2210:
	goto	l1730
	
l519:	
	line	99
	
l1730:	
;PR16RX.c: 99: data = uart_rec();
	fcall	_uart_rec
	movwf	(??_read_packet+0)+0
	movf	(??_read_packet+0)+0,w
	movwf	(read_packet@data)
	line	102
;PR16RX.c: 102: checksum = uart_rec();
	fcall	_uart_rec
	movwf	(??_read_packet+0)+0
	movf	(??_read_packet+0)+0,w
	movwf	(read_packet@checksum)
	line	103
	
l1732:	
;PR16RX.c: 103: } while (checksum != (unsigned char)(0xaa + data));
	movf	(read_packet@data),w
	addlw	0AAh
	xorwf	(read_packet@checksum),w
	skipz
	goto	u2221
	goto	u2220
u2221:
	goto	l516
u2220:
	goto	l1734
	
l520:	
	line	106
	
l1734:	
;PR16RX.c: 106: return data;
	movf	(read_packet@data),w
	goto	l521
	
l1736:	
	line	107
	
l521:	
	return
	opt stack 0
GLOBAL	__end_of_read_packet
	__end_of_read_packet:
;; =============== function _read_packet ends ============

	signat	_read_packet,89
	global	_uart_rec
psect	text110,local,class=CODE,delta=2
global __ptext110
__ptext110:

;; *************** function _uart_rec *****************
;; Defined at:
;;		line 70 in file "C:\Users\Phang\Desktop\9.80\PR 16\PR16RX.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  rec_data        1    1[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         2       0       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_read_packet
;; This function uses a non-reentrant model
;;
psect	text110
	file	"C:\Users\Phang\Desktop\9.80\PR 16\PR16RX.c"
	line	70
	global	__size_of_uart_rec
	__size_of_uart_rec	equ	__end_of_uart_rec-_uart_rec
	
_uart_rec:	
	opt	stack 6
; Regs used in _uart_rec: [wreg]
	line	72
	
l1722:	
;PR16RX.c: 71: unsigned char rec_data;
;PR16RX.c: 72: while(RCIF==0);
	goto	l508
	
l509:	
	
l508:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(101/8),(101)&7
	goto	u2201
	goto	u2200
u2201:
	goto	l508
u2200:
	goto	l1724
	
l510:	
	line	73
	
l1724:	
;PR16RX.c: 73: rec_data = RCREG;
	movf	(26),w	;volatile
	movwf	(??_uart_rec+0)+0
	movf	(??_uart_rec+0)+0,w
	movwf	(uart_rec@rec_data)
	line	74
;PR16RX.c: 74: return rec_data;
	movf	(uart_rec@rec_data),w
	goto	l511
	
l1726:	
	line	75
	
l511:	
	return
	opt stack 0
GLOBAL	__end_of_uart_rec
	__end_of_uart_rec:
;; =============== function _uart_rec ends ============

	signat	_uart_rec,89
psect	text111,local,class=CODE,delta=2
global __ptext111
__ptext111:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
