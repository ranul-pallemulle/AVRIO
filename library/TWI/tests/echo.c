/**
 * @file echo.c
 * @author Ranul Pallemulle
 * @date 20/09/2019
 * @brief Test TWI slave functionality by receiving data from a master
 * and echoing it back.
 *
 * Response to the start condition on the bus, the device slave
 * address with the write/read bit set, response to data
 * transmission/receive requests from the master are all tested
 * here. While the microcontroller waits for TWI interrupts, it blinks
 * an LED as idle work.
 */

#include <avr/io.h>
#include <avr/interrupt.h>
#include <twi_slave.h>
#include <util/delay.h>

void my_callback_fn(unsigned char* buf, unsigned char len)
{
    
}

int main(void) {
    twi_slave_receiver_mode();
    twi_slave_init(0x10, 1);
    sei();
    
    DDRB |= (1 << DDB5);
    for ( ; ; ) {
	PORTB |= (1 << PB5);
	_delay_ms(500);
	PORTB &= ~(1 << PB5);
	_delay_ms(500);
    }
    return 0;
}
