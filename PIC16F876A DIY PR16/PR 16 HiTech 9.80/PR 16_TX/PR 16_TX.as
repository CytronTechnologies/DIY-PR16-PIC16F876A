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
# 15 "C:\Users\Phang\Desktop\9.80\PR 16_TX\PR16TX.c"
	psect config,class=CONFIG,delta=2 ;#
# 15 "C:\Users\Phang\Desktop\9.80\PR 16_TX\PR16TX.c"
	dw 0x3F32 ;#
	FNCALL	_main,_send_packet
	FNCALL	_send_packet,_uart_send
	FNROOT	_main
	global	main@F459
psect	idataBANK0,class=CODE,space=0,delta=2
global __pidataBANK0
__pidataBANK0:
	file	"C:\Users\Phang\Desktop\9.80\PR 16_TX\PR16TX.c"
	line	41

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
	global	_PORTB
_PORTB	set	6
	global	_TXREG
_TXREG	set	25
	global	_RA1
_RA1	set	41
	global	_RA2
_RA2	set	42
	global	_RA3
_RA3	set	43
	global	_SPEN
_SPEN	set	199
	global	_TXIF
_TXIF	set	100
	global	_ADCON1
_ADCON1	set	159
	global	_SPBRG
_SPBRG	set	153
	global	_TRISA
_TRISA	set	133
	global	_TRISB
_TRISB	set	134
	global	_BRGH
_BRGH	set	1218
	global	_SYNC
_SYNC	set	1220
	global	_TX9
_TX9	set	1222
	global	_TXEN
_TXEN	set	1221
	file	"PR 16_TX.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	dataBANK0,class=BANK0,space=1
global __pdataBANK0
__pdataBANK0:
	file	"C:\Users\Phang\Desktop\9.80\PR 16_TX\PR16TX.c"
main@F459:
       ds      16

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
	global	?_send_packet
?_send_packet:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?_uart_send
?_uart_send:	; 0 bytes @ 0x0
	global	??_uart_send
??_uart_send:	; 0 bytes @ 0x0
	global	uart_send@data
uart_send@data:	; 1 bytes @ 0x0
	ds	1
	global	??_send_packet
??_send_packet:	; 0 bytes @ 0x1
	ds	1
	global	send_packet@buffer
send_packet@buffer:	; 3 bytes @ 0x2
	ds	3
	global	send_packet@data
send_packet@data:	; 1 bytes @ 0x5
	ds	1
	global	send_packet@i
send_packet@i:	; 1 bytes @ 0x6
	ds	1
	global	??_main
??_main:	; 0 bytes @ 0x7
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
;;Data sizes: Strings 0, constant 0, data 16, bss 0, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14     11      11
;; BANK0           80     18      34
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:



;;
;; Critical Paths under _main in COMMON
;;
;;   _main->_send_packet
;;   _send_packet->_uart_send
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
;; (0) _main                                                22    22      0     483
;;                                              7 COMMON     4     4      0
;;                                              0 BANK0     18    18      0
;;                        _send_packet
;; ---------------------------------------------------------------------------------
;; (1) _send_packet                                          6     6      0     252
;;                                              1 COMMON     6     6      0
;;                          _uart_send
;; ---------------------------------------------------------------------------------
;; (2) _uart_send                                            1     1      0      22
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 2
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _send_packet
;;     _uart_send
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
;;DATA                 0      0      2F      12        0.0%
;;ABS                  0      0      2D       3        0.0%
;;NULL                 0      0       0       0        0.0%
;;STACK                0      0       2       2        0.0%
;;BANK0               50     12      22       5       42.5%
;;BITBANK0            50      0       0       4        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR0              0      0       0       1        0.0%
;;COMMON               E      B       B       1       78.6%
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 37 in file "C:\Users\Phang\Desktop\9.80\PR 16_TX\PR16TX.c"
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
;;		_send_packet
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"C:\Users\Phang\Desktop\9.80\PR 16_TX\PR16TX.c"
	line	37
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 6
; Regs used in _main: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	44
	
l1796:	
;PR16TX.c: 39: unsigned char num,no;
;PR16TX.c: 41: unsigned char _7seg[16]={0b01111111,0b00001101,0b10110111,0b10011111,
;PR16TX.c: 42: 0b11001101,0b11011011,0b11111011,0b00001111,
;PR16TX.c: 43: 0b11111111,0b11011111,0b11101111,0b11111001,
;PR16TX.c: 44: 0b01110011,0b10111101,0b11110011,0b11100011};
	movlw	(main@_7seg)&0ffh
	movwf	fsr0
	movlw	low(main@F459)
	movwf	(??_main+0)+0
	movf	fsr0,w
	movwf	((??_main+0)+0+1)
	movlw	16
	movwf	((??_main+0)+0+2)
u2330:
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
	goto	u2330
	line	46
	
l1798:	
;PR16TX.c: 46: ADCON1= 0x06;
	movlw	(06h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(159)^080h	;volatile
	line	48
	
l1800:	
;PR16TX.c: 48: TRISA = 0b111111;
	movlw	(03Fh)
	movwf	(133)^080h	;volatile
	line	49
	
l1802:	
;PR16TX.c: 49: TRISB = 0b00000000;
	clrf	(134)^080h	;volatile
	line	52
	
l1804:	
;PR16TX.c: 52: BRGH = 0;
	bcf	(1218/8)^080h,(1218)&7
	line	53
	
l1806:	
;PR16TX.c: 53: SPBRG = 255;
	movlw	(0FFh)
	movwf	(153)^080h	;volatile
	line	54
	
l1808:	
;PR16TX.c: 54: TX9 = 0;
	bcf	(1222/8)^080h,(1222)&7
	line	55
	
l1810:	
;PR16TX.c: 55: TXEN = 1;
	bsf	(1221/8)^080h,(1221)&7
	line	56
	
l1812:	
;PR16TX.c: 56: SYNC = 0;
	bcf	(1220/8)^080h,(1220)&7
	line	58
	
l1814:	
;PR16TX.c: 58: SPEN = 1;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(199/8),(199)&7
	line	60
	
l1816:	
;PR16TX.c: 60: num=0;
	clrc
	movlw	0
	btfsc	status,0
	movlw	1
	movwf	(main@num)
	line	61
	
l1818:	
;PR16TX.c: 61: no=0;
	clrc
	movlw	0
	btfsc	status,0
	movlw	1
	movwf	(main@no)
	line	62
	
l1820:	
;PR16TX.c: 62: PORTB=_7seg[num];
	movf	(main@num),w
	addlw	main@_7seg&0ffh
	movwf	fsr0
	movf	indf,w
	movwf	(6)	;volatile
	goto	l1822
	line	64
;PR16TX.c: 64: while(1)
	
l499:	
	line	66
	
l1822:	
;PR16TX.c: 65: {
;PR16TX.c: 66: if(RA1==0)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfsc	(41/8),(41)&7
	goto	u2341
	goto	u2340
u2341:
	goto	l500
u2340:
	line	68
	
l1824:	
;PR16TX.c: 67: {
;PR16TX.c: 68: if(num==15) num=0;
	movf	(main@num),w
	xorlw	0Fh
	skipz
	goto	u2351
	goto	u2350
u2351:
	goto	l1828
u2350:
	
l1826:	
	clrc
	movlw	0
	btfsc	status,0
	movlw	1
	movwf	(main@num)
	goto	l1830
	line	69
	
l501:	
	
l1828:	
;PR16TX.c: 69: else num+=1;
	movlw	(01h)
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	addwf	(main@num),f
	goto	l1830
	
l502:	
	line	71
	
l1830:	
;PR16TX.c: 71: PORTB=_7seg[num];
	movf	(main@num),w
	addlw	main@_7seg&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(6)	;volatile
	line	73
;PR16TX.c: 73: while(RA1==0);
	goto	l503
	
l504:	
	
l503:	
	btfss	(41/8),(41)&7
	goto	u2361
	goto	u2360
u2361:
	goto	l503
u2360:
	goto	l1842
	
l505:	
	line	74
;PR16TX.c: 74: }
	goto	l1842
	line	76
	
l500:	
;PR16TX.c: 76: else if(RA2==0)
	btfsc	(42/8),(42)&7
	goto	u2371
	goto	u2370
u2371:
	goto	l507
u2370:
	line	78
	
l1832:	
;PR16TX.c: 77: {
;PR16TX.c: 78: if(num==0) num=15;
	movf	(main@num),f
	skipz
	goto	u2381
	goto	u2380
u2381:
	goto	l1836
u2380:
	
l1834:	
	movlw	(0Fh)
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(main@num)
	goto	l1838
	line	79
	
l508:	
	
l1836:	
;PR16TX.c: 79: else num-=1;
	movlw	low(01h)
	subwf	(main@num),f
	goto	l1838
	
l509:	
	line	81
	
l1838:	
;PR16TX.c: 81: PORTB=_7seg[num];
	movf	(main@num),w
	addlw	main@_7seg&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(6)	;volatile
	line	83
;PR16TX.c: 83: while(RA2==0);
	goto	l510
	
l511:	
	
l510:	
	btfss	(42/8),(42)&7
	goto	u2391
	goto	u2390
u2391:
	goto	l510
u2390:
	goto	l1842
	
l512:	
	line	84
;PR16TX.c: 84: }
	goto	l1842
	line	86
	
l507:	
;PR16TX.c: 86: else if(RA3==0)
	btfsc	(43/8),(43)&7
	goto	u2401
	goto	u2400
u2401:
	goto	l1842
u2400:
	line	88
	
l1840:	
;PR16TX.c: 87: {
;PR16TX.c: 88: no=num;
	movf	(main@num),w
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(main@no)
	line	89
;PR16TX.c: 89: while(RA3==0);
	goto	l515
	
l516:	
	
l515:	
	btfss	(43/8),(43)&7
	goto	u2411
	goto	u2410
u2411:
	goto	l515
u2410:
	goto	l1842
	
l517:	
	goto	l1842
	line	90
	
l514:	
	goto	l1842
	line	93
	
l513:	
	goto	l1842
	
l506:	
	
l1842:	
;PR16TX.c: 90: }
;PR16TX.c: 93: send_packet(no);
	movf	(main@no),w
	fcall	_send_packet
	goto	l1822
	line	94
	
l518:	
	line	64
	goto	l1822
	
l519:	
	line	95
	
l520:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_send_packet
psect	text97,local,class=CODE,delta=2
global __ptext97
__ptext97:

;; *************** function _send_packet *****************
;; Defined at:
;;		line 108 in file "C:\Users\Phang\Desktop\9.80\PR 16_TX\PR16TX.c"
;; Parameters:    Size  Location     Type
;;  data            1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  data            1    5[COMMON] unsigned char 
;;  buffer          3    2[COMMON] unsigned char [3]
;;  i               1    6[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         5       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         6       0       0       0       0
;;Total ram usage:        6 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_uart_send
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text97
	file	"C:\Users\Phang\Desktop\9.80\PR 16_TX\PR16TX.c"
	line	108
	global	__size_of_send_packet
	__size_of_send_packet	equ	__end_of_send_packet-_send_packet
	
_send_packet:	
	opt	stack 6
; Regs used in _send_packet: [wreg-fsr0h+status,2+status,0+pclath+cstack]
;send_packet@data stored from wreg
	line	115
	movwf	(send_packet@data)
	
l1770:	
;PR16TX.c: 109: unsigned char i;
;PR16TX.c: 112: unsigned char buffer[3];
;PR16TX.c: 115: buffer[0] = 0xaa;
	movlw	(0AAh)
	movwf	(??_send_packet+0)+0
	movf	(??_send_packet+0)+0,w
	movwf	(send_packet@buffer)
	line	118
;PR16TX.c: 118: buffer[1] = data;
	movf	(send_packet@data),w
	movwf	(??_send_packet+0)+0
	movf	(??_send_packet+0)+0,w
	movwf	0+(send_packet@buffer)+01h
	line	121
	
l1772:	
;PR16TX.c: 121: buffer[2] = (unsigned char)(0xaa + data);
	movf	(send_packet@data),w
	addlw	0AAh
	movwf	(??_send_packet+0)+0
	movf	(??_send_packet+0)+0,w
	movwf	0+(send_packet@buffer)+02h
	line	124
	
l1774:	
;PR16TX.c: 124: for (i = 0; i < 7; i++) uart_send(0x00);
	clrc
	movlw	0
	btfsc	status,0
	movlw	1
	movwf	(send_packet@i)
	movlw	(07h)
	subwf	(send_packet@i),w
	skipc
	goto	u2291
	goto	u2290
u2291:
	goto	l1778
u2290:
	goto	l1784
	
l1776:	
	goto	l1784
	
l529:	
	
l1778:	
	movlw	(0)
	fcall	_uart_send
	
l1780:	
	movlw	(01h)
	movwf	(??_send_packet+0)+0
	movf	(??_send_packet+0)+0,w
	addwf	(send_packet@i),f
	
l1782:	
	movlw	(07h)
	subwf	(send_packet@i),w
	skipc
	goto	u2301
	goto	u2300
u2301:
	goto	l1778
u2300:
	goto	l1784
	
l530:	
	line	127
	
l1784:	
;PR16TX.c: 127: for (i = 0; i < 3; i++) uart_send(buffer[i]);
	clrc
	movlw	0
	btfsc	status,0
	movlw	1
	movwf	(send_packet@i)
	
l1786:	
	movlw	(03h)
	subwf	(send_packet@i),w
	skipc
	goto	u2311
	goto	u2310
u2311:
	goto	l1790
u2310:
	goto	l533
	
l1788:	
	goto	l533
	
l531:	
	
l1790:	
	movf	(send_packet@i),w
	addlw	send_packet@buffer&0ffh
	movwf	fsr0
	movf	indf,w
	fcall	_uart_send
	
l1792:	
	movlw	(01h)
	movwf	(??_send_packet+0)+0
	movf	(??_send_packet+0)+0,w
	addwf	(send_packet@i),f
	
l1794:	
	movlw	(03h)
	subwf	(send_packet@i),w
	skipc
	goto	u2321
	goto	u2320
u2321:
	goto	l1790
u2320:
	goto	l533
	
l532:	
	line	128
	
l533:	
	return
	opt stack 0
GLOBAL	__end_of_send_packet
	__end_of_send_packet:
;; =============== function _send_packet ends ============

	signat	_send_packet,4216
	global	_uart_send
psect	text98,local,class=CODE,delta=2
global __ptext98
__ptext98:

;; *************** function _uart_send *****************
;; Defined at:
;;		line 101 in file "C:\Users\Phang\Desktop\9.80\PR 16_TX\PR16TX.c"
;; Parameters:    Size  Location     Type
;;  data            1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  data            1    0[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_send_packet
;; This function uses a non-reentrant model
;;
psect	text98
	file	"C:\Users\Phang\Desktop\9.80\PR 16_TX\PR16TX.c"
	line	101
	global	__size_of_uart_send
	__size_of_uart_send	equ	__end_of_uart_send-_uart_send
	
_uart_send:	
	opt	stack 6
; Regs used in _uart_send: [wreg]
;uart_send@data stored from wreg
	movwf	(uart_send@data)
	line	102
	
l1766:	
;PR16TX.c: 102: while(TXIF==0);
	goto	l523
	
l524:	
	
l523:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(100/8),(100)&7
	goto	u2281
	goto	u2280
u2281:
	goto	l523
u2280:
	goto	l1768
	
l525:	
	line	103
	
l1768:	
;PR16TX.c: 103: TXREG=data;
	movf	(uart_send@data),w
	movwf	(25)	;volatile
	line	104
	
l526:	
	return
	opt stack 0
GLOBAL	__end_of_uart_send
	__end_of_uart_send:
;; =============== function _uart_send ends ============

	signat	_uart_send,4216
psect	text99,local,class=CODE,delta=2
global __ptext99
__ptext99:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
