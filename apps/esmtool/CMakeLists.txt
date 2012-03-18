set(ESMTOOL
  esmtool.cpp
  labels.hpp
  labels.cpp
  record.hpp
  record.cpp
)
source_group(apps\\esmtool FILES ${ESMTOOL})

# Main executable
add_executable(esmtool
  ${ESMTOOL}
)

target_link_libraries(esmtool
  ${Boost_LIBRARIES}
  components
)

if(BUILD_TGZ)
    INSTALL(TARGETS esmtool RUNTIME DESTINATION "." COMPONENT esmtool)
    exec_program("uname" ARGS "-m" OUTPUT_VARIABLE ARCH)
    SET_TARGET_PROPERTIES(esmtool
                          PROPERTIES OUTPUT_NAME esmtool.${ARCH})
endif(BUILD_TGZ)

if (BUILD_WITH_CODE_COVERAGE)
  add_definitions (--coverage)
  target_link_libraries(esmtool gcov)
endif()
