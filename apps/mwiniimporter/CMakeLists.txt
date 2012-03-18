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
    ${Boost_LIBRARIES}
    components
)

if(BUILD_TGZ)
    INSTALL(TARGETS mwiniimport RUNTIME DESTINATION "." COMPONENT mwiniimport)
    exec_program("uname" ARGS "-m" OUTPUT_VARIABLE ARCH)
    SET_TARGET_PROPERTIES(mwiniimport
                          PROPERTIES OUTPUT_NAME mwiniimport.${ARCH})
endif(BUILD_TGZ)

if (BUILD_WITH_CODE_COVERAGE)
  add_definitions (--coverage)
  target_link_libraries(openmw-iniimporter gcov)
endif()
