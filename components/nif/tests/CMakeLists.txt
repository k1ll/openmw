set(NIFTEST
    niftest.cpp
)
source_group(components\\nif\\tests FILES ${NIFTEST})

# Main executable
add_executable(niftest
    ${NIFTEST}
)

target_link_libraries(niftest
  ${Boost_LIBRARIES}
  components
)

if(BUILD_TGZ)
    INSTALL(TARGETS niftest RUNTIME DESTINATION "." COMPONENT niftest)
        exec_program("uname" ARGS "-m" OUTPUT_VARIABLE ARCH)
        SET_TARGET_PROPERTIES(niftest
                                  PROPERTIES OUTPUT_NAME niftest.${ARCH})
endif(BUILD_TGZ)

if (BUILD_WITH_CODE_COVERAGE)
  add_definitions (--coverage)
  target_link_libraries(niftest gcov)
endif()
