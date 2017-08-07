set(MWINIIMPORT
    main.cpp
    importer.cpp
)

set(MWINIIMPORT_HEADER
    importer.hpp
)

source_group(launcher FILES ${MWINIIMPORT} ${MWINIIMPORT_HEADER})

add_executable(openmw-iniimporter
    ${MWINIIMPORT}
)

target_link_libraries(openmw-iniimporter
    ${Boost_PROGRAM_OPTIONS_LIBRARY}
    ${Boost_FILESYSTEM_LIBRARY}
    components
)

if(BUILD_TGZ)
    INSTALL(TARGETS openmw-iniimporter RUNTIME DESTINATION "." COMPONENT openmw-iniimporter)
    exec_program("uname" ARGS "-m" OUTPUT_VARIABLE ARCH)
    SET_TARGET_PROPERTIES(openmw-iniimporter
                          PROPERTIES OUTPUT_NAME openmw-iniimporter.${ARCH})
endif(BUILD_TGZ)

if (WIN32)
    target_link_libraries(openmw-iniimporter
    ${Boost_LOCALE_LIBRARY})
    INSTALL(TARGETS openmw-iniimporter RUNTIME DESTINATION ".")
endif(WIN32)

if (MINGW)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -municode")
endif()

if (BUILD_WITH_CODE_COVERAGE)
  add_definitions (--coverage)
  target_link_libraries(openmw-iniimporter gcov)
endif()
