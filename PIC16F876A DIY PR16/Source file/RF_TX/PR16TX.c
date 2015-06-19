//==========================================================================
//	Author				: Cytron Technologies		
//	Project				: Sending Data using RF Module
//	Project description : The transmitter will send 0->F (data in Hexadecimal).
//                        This project use PIC16F876A.Compatible with
//                        MPLAB IDE with HITECH C compiler v 9.80/v9.83 or
//                        using MPLABX with HITECH C compiler v 9.80/v9.83 and XC8 compiler.
//==========================================================================

//===================================================================================
//	include
//===================================================================================
#if defined(__XC8)						
   #include <xc.h>                      
   #pragma config CONFIG = 0x3F32
#else
#include <htc.h>                        //include the PIC microchip header file

//===================================================================================
//	configuration
//===================================================================================
__CONFIG (0x3F32);
//FOSC = HS        // Oscillator Selection bits (HS oscillator)
//WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
//PWRTE = ON       // Power-up Timer Enable bit (PWRT enabled)
//BOREN = OFF      // Brown-out Reset Enable bit (BOR disabled)
//LVP = OFF        // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
//CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
//WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
//CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)
#endif
//===================================================================================
//	define
//===================================================================================
#define	inc_button	RA1
#define dec_button 	RA2
#define	send_button	RA3
#define display		PORTB

#define SYNC_DATA		0x00
#define HEADER			0xaa

//===================================================================================
//	function prototype
//===================================================================================
void uart_send(unsigned char data);
void send_packet(unsigned char data);

//	main function
//===================================================================================
void main(void)
{
	//assign variable
	unsigned char num,no;
										//7 segment display
	unsigned char _7seg[16]={0b01111111,0b00001101,0b10110111,0b10011111,	//0,1,2,3
							 0b11001101,0b11011011,0b11111011,0b00001111,	//4,5,6,7
							 0b11111111,0b11011111,0b11101111,0b11111001,	//8,9,A,B
							 0b01110011,0b10111101,0b11110011,0b11100011};	//C,D,E,F

	ADCON1= 0x06;				//configure PortA as digital I/O

	TRISA = 0b111111;			//configure PORTA input
	TRISB = 0b00000000;			//configure PORTB as output
	
	//setup USART
	BRGH = 0;					//baud rate low speed option
	SPBRG = 255;				//set boud rate to 1200bps for 20Mhz crystal 
	TX9 = 0;					//8-bit transmission
	TXEN = 1;					//enable transmission
	SYNC = 0;					//asynchronous
	
	SPEN = 1;					//enable serial port
	
	num=0;    
	no=0;
	display=_7seg[num];

	while(1)						//infinity loop
	{
		if(inc_button==0)			//increase number per press
		{
			if(num==15) num=0;		//back to 0 after F
			else num+=1;			//one increment

			display=_7seg[num];		//display number on 7 segment

			while(inc_button==0);	//wait until the button is released
		}
	
		else if(dec_button==0)		//decrease number per press
		{
			if(num==0) num=15;		//go to F after 0
			else num-=1;			//one decrement

			display=_7seg[num];		//display number on 7 segment

			while(dec_button==0);	//wait until the button is released
		}

		else if(send_button==0)		//send the desired number
		{
			no=num;
			while(send_button==0);	//wait until the button is released
		}	
		
		
		send_packet(no);			//continuous send data
	}		
}

//===================================================================================
//	functions
//===================================================================================
void uart_send(unsigned char data)
{	
	while(TXIF==0);				//only send the new data after 
	TXREG=data;					//the previous data finish sent
}


void send_packet(unsigned char data)
{
	unsigned char i;
	
	// Buffer for the data in one packet.
	unsigned char buffer[3];
	
	// Byte 0 is the header.
	buffer[0] = HEADER;
	
	// Byte 1 is the data.
	buffer[1] = data;
	
	// Byte 2 is the checksum.
	buffer[2] = (unsigned char)(HEADER + data);
	
	// Clocking for a while before sending the data so that the Tx and Rx are in sync.
	for (i = 0; i < 7; i++) uart_send(SYNC_DATA);
	
	// Transmit the packet using UART.
	for (i = 0; i < 3; i++) uart_send(buffer[i]);
}

