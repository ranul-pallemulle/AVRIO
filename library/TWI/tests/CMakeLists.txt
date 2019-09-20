# TWI slave echo test
add_avr_executable(echo echo.c)
target_link_libraries(echo-${MCU}.elf LINK_PUBLIC TWI)
