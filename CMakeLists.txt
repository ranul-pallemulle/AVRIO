cmake_minimum_required(VERSION 3.1.3)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR avr)
set(CMAKE_CROSSCOMPILING 1)
set(CMAKE_C_COMPILER "avr-gcc")
set(CMAKE_CXX_COMPILER "avr-g++")
set(CMAKE_AR "avr-ar")
set(CMAKE_LINKER "avr-ld")
set(CMAKE_NM "avr-nm")
set(CMAKE_OBJCOPY "avr-objcopy")
set(CMAKE_OBJDUMP "avr-objdump")
set(CMAKE_STRIP "avr-strip")
set(CMAKE_RANLIB "avr-ranlib")
set(AVR_SIZE "avr-size")
set(AVR_LINKER_LIBS "-lc -lm -lgcc")
set(CMAKE_C_STANDARD 99)
project(AVRIO LANGUAGES C)

option(AVRIO_BUILD_LIBRARY    "Build AVRIO hardware libraries."      ON)
option(AVRIO_BUILD_UTILITIES  "Build the AVRIO utility programs"     ON)
option(AVRIO_BUILD_TESTS      "Build integration tests."             ON)
option(AVRIO_BUILD_UNIT_TESTS "Build unit tests."                    ON)

# Add support for CMAKE_DEPENDENT_OPTION and CMAKE_PARSE_ARGUMENTS
include(CMakeDependentOption)
include(CMakeParseArguments)

set(MCU "ATMEGA328P" CACHE STRING
  "AVR microcontroller to compile for.")
string(TOUPPER ${MCU} MCU)
set(DEVICE "DEVICE_${MCU}")
add_compile_definitions(${DEVICE})
string(TOLOWER ${MCU} MCU)
add_compile_options(-mmcu=${MCU})

set(CPU_FREQ "8000000UL" CACHE STRING
  "AVR microcontroller CPU frequency.")
string(TOUPPER ${CPU_FREQ} CPU_FREQ)
add_compile_definitions(F_CPU=${CPU_FREQ})

find_program(AVR_UPLOAD
  NAME avrdude
  PATHS /usr/bin
  $ENV{AVR_ROOT})

# if (NOT AVR_UPLOAD_BAUD)
#   set(AVR_UPLOAD_BAUD 57600 CACHE STRING
#     "Upload baud rate.")
#   message("Warning: Using the default baud rate (${AVR_UPLOAD_BAUD}) for 
# uploading using avrdude.")
# endif (NOT AVR_UPLOAD_BAUD)

if (NOT AVR_UPLOAD_PROGRAMMER)
  set(AVR_UPLOAD_PROGRAMMER "dragon_isp" CACHE STRING
    "Programmer name to supply to AVRDUDE.")
 #  message("Warning: Using the default programmer (${AVR_UPLOAD_PROGRAMMER}) for
 # uploading using avrdude.")
endif (NOT AVR_UPLOAD_PROGRAMMER)

# if(NOT AVR_UPLOAD_PORT)
#   set(AVR_UPLOAD_PORT "unknown")
#   if(CMAKE_HOST_UNIX)
#     set(AVR_UPLOAD_PORT "/dev/ttyUSB0" CACHE STRING
#       "USB port the programmer is connected to.")
#   endif(CMAKE_HOST_UNIX)
#   if(CMAKE_HOST_WIN32)
#     set(AVR_UPLOAD_PORT "COM3" CACHE STRING
#       "USB port the programmer is connected to.")
#   endif(CMAKE_HOST_WIN32)
#   message("Warning: Using the default port (${AVR_UPLOAD_PORT}) for uploading 
# using avrdude.")
# endif(NOT AVR_UPLOAD_PORT)

# Find modules in the ./cmake directory
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH})
include(Doxygen)
include(AVRIOCommon)

if (AVRIO_BUILD_LIBRARY)
  add_subdirectory(library)
endif()

if (AVRIO_BUILD_UTILITIES)
  add_subdirectory(utilities)
endif()

if (AVRIO_BUILD_UNIT_TESTS)
  enable_testing()
endif()


add_subdirectory(I2C_LCD_Controller)
