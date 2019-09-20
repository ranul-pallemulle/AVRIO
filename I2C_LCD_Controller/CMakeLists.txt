add_avr_executable(i2c_lcd_controller
  main.c)
target_link_libraries(i2c_lcd_controller-${MCU}.elf LINK_PUBLIC TWI)
