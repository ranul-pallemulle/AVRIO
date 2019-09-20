cmake_dependent_option(AVRIO_MODULE_TWI
  "Build the TWI Library." ON
  "AVRIO_BUILD_LIBRARY" OFF)

if (NOT AVRIO_BUILD_LIBRARY)
  set(AVRIO_MODULE_TWI OFF CACHE INTERNAL "")
endif()

if (AVRIO_MODULE_TWI)
  set(TWI_SOURCES
    twi_slave.c
    twi_master.c
    )
  set(TWI_HEADERS
    twi_slave.h
    twi_master.h
    )
  add_library("TWI" STATIC ${TWI_SOURCES} ${TWI_HEADERS})
  target_include_directories("TWI"
    PUBLIC  ${CMAKE_CURRENT_SOURCE_DIR}
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/status_codes)
endif()

if (AVRIO_BUILD_TESTS)
  add_subdirectory(tests)
endif (AVRIO_BUILD_TESTS)
