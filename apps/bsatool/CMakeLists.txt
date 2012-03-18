set(BSATOOL
	bsatool.cpp
)
source_group(apps\\bsatool FILES ${BSATOOL})

# Main executable
add_executable(bsatool
	${BSATOOL}
)

target_link_libraries(bsatool
  ${Boost_LIBRARIES}
  components
)

if(BUILD_TGZ)
    INSTALL(TARGETS bsatool RUNTIME DESTINATION "." COMPONENT bsatool)
    exec_program("uname" ARGS "-m" OUTPUT_VARIABLE ARCH)
    SET_TARGET_PROPERTIES(bsatool
                          PROPERTIES OUTPUT_NAME bsatool.${ARCH})
endif(BUILD_TGZ)

if (BUILD_WITH_CODE_COVERAGE)
  add_definitions (--coverage)
  target_link_libraries(bsatool gcov)
endif()
