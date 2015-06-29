//==========================================================================
//	Author				: Cytron Technologies		
//	Project				: Sending Data using RF Module
//	Project description	: The receiver will receive the data(0->F) from transmitter 
//				and display the data on 7-segment display. 
//===========================================================================
//	include
//===========================================================================
#include <pic.h> 

//===========================================================================
// 	configuration
//============================================================================
__CONFIG (0x3F32);

//============================================================================
//	define
//============================================================================
#define display			PORTB
#define HEADER			0xaa

//=============================================================================
//	function prototype
//=============================================================================
unsigned char uart_rec(void);
unsigned char read_packet(void);

//============================================================================
//	main function
//============================================================================
void main(void)
{
	//assign variable
	unsigned char num,no;
										// 7 segment display
	unsigned char _7seg[16]={0b01111111,0b00001101,0b10110111,0b10011111,	//0,1,2,3
							 0b11001101,0b11011011,0b11111011,0b00001111,	//4,5,6,7
							 0b11111111,0b11011111,0b11101111,0b11111001,	//8,9,A,B
							 0b01110011,0b10111101,0b11110011,0b11100011};	//C,D,E,F

	//set I/O input output
	TRISB = 0b00000000;			//configure PORTB as output
		
	//setup USART
	BRGH = 0;					//baud rate low speed option
	SPBRG = 255;				//set boud rate to 1200bps for 20Mhz crystal 
	SPEN = 1;					//enable serial port
	RX9 = 0;					//8-bit reception
	CREN = 1;					//enable reception

	num=0;
	display=_7seg[num];

	while(1)					//infinity loop
	{
		CREN=1;							//enable continuos receive
		if(OERR==0) no=read_packet();	//receive sata if overrun error free
		else CREN=0;					//if overrun error, disable continuos receive
		
		if(no <= 0x0f) num=no;			//only accept the value from 0 to f

		display=_7seg[num]; 
	}
}

//==================================================================================
//	functions
//===================================================================================
unsigned char uart_rec(void)	//receive uart value
{
	unsigned char rec_data;
	while(RCIF==0);				//wait for data
	rec_data = RCREG;
	return rec_data;			//return the received data 
}



unsigned char read_packet(void)
{
	// Buffer for received byte.
	unsigned char received_byte;
	
	// Counter to indicate the current position of the received data packet. 
	static unsigned char counter = 0;
	
	// Buffers for the data and checksum.
	unsigned char data;
	unsigned char checksum;
	
	
	// We loop until the checksum is correct.
	do {
		// We will ignore the sync data and assume the header byte is the start of packet.
		// Keep reading until the header byte is received.
		while (uart_rec() != HEADER);
		
		// The following byte shoulde be the data byte.
		data = 	uart_rec();
		
		// Then the last byte is the checksum.
		checksum = 	uart_rec();
	} while (checksum != (unsigned char)(HEADER + data));
	
	// If the checksum is correct, return the data.
	return data;
}
