# Make sure the following are defined before this file is included:
# MCU, AVR_UPLOAD, AVR_UPLOAD_PROGRAMMER,

# macro for generating the elf, hex and lst files. Also add the flash
# target.
macro(add_avr_executable TARGET_NAME)
  set(ELF_FILE ${TARGET_NAME}-${MCU}.elf)
  set(MAP_FILE ${TARGET_NAME}-${MCU}.map)
  set(HEX_FILE ${TARGET_NAME}-${MCU}.hex)
  set(LST_FILE ${TARGET_NAME}-${MCU}.lst)

  add_executable(${ELF_FILE} ${ARGN})
  set_target_properties(${ELF_FILE}
    PROPERTIES
    LINK_FLAGS "-Wl,-Map,${MAP_FILE} ${AVR_LINKER_LIBS}")

  # command to generate the lst file
  add_custom_command(
    OUTPUT ${LST_FILE}
    COMMAND ${CMAKE_OBJDUMP} -h -S ${ELF_FILE} > ${LST_FILE}
    DEPENDS ${ELF_FILE})

  # command to generate the hex file
  add_custom_command(
    OUTPUT ${HEX_FILE}
    COMMAND ${CMAKE_OBJCOPY} -j .text -j .data -O ihex ${ELF_FILE}
    ${HEX_FILE}
    DEPENDS ${ELF_FILE})

  # command to print size of elf file
  add_custom_command(
    OUTPUT "print-size-${ELF_FILE}"
    COMMAND ${AVR_SIZE} ${ELF_FILE}
    DEPENDS ${ELF_FILE})

  # build the intel hex file for the device
  add_custom_target(
    ${TARGET_NAME}
    ALL
    DEPENDS ${HEX_FILE} ${LST_FILE} "print-size-${ELF_FILE}")

  set_target_properties(
    ${TARGET_NAME}
    PROPERTIES
    OUTPUT_NAME ${ELF_FILE})

  # command for flashing
  add_custom_command(
    OUTPUT "flash-${HEX_FILE}"
    COMMAND ${AVR_UPLOAD} -c${AVR_UPLOAD_PROGRAMMER} -p${MCU} -U
    flash:w:${HEX_FILE})

  # flash target
  add_custom_target(
    "flash-${TARGET_NAME}"
    DEPENDS "flash-${HEX_FILE}")

# by default, the map file generated is not deleted.
set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES
"${MAP_FILE}")
endmacro(add_avr_executable)
