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
#include <twi.h>
#include <util/delay.h>

void my_callback_fn(unsigned char* buf, unsigned char len)
{
    
}

int main(void) {
    twi_slave_init(0x12, RESPOND_TO_GEN_CALL);
    twi_slave_set_callback(my_callback_fn);
    twi_slave_receiver_mode();
    sei();
    DDRB |= (1 << DDB5);
    for ( ; ; ) {
	PORTB |= (1 << PB5);
	_delay_ms(1000);
	PORTB &= ~(1 << PB5);
	_delay_ms(1000);
    }
    return 0;
}
