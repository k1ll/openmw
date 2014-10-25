macro (find_tgz_deps)
	exec_program("uname" ARGS "-m" OUTPUT_VARIABLE ARCH)
	if("${ARCH}" MATCHES "i686")
		set(MULTIARCH_PATH "i386-linux-gnu")
	else()
		set(MULTIARCH_PATH "${ARCH}-linux-gnu")
	endif()

	set(FREEIMAGE_LIBRARY "/usr/lib/libfreeimage.so.3")
	set(JPEG_LIBRARY "/usr/lib/${MULTIARCH_PATH}/libjpeg.so.8")
	#Don't package pthread it's just too system dependant
	#set(PTHREAD_LIBRARY "/lib/libpthread.so.0")
	set(UUID_LIBRARY "/lib/${MULTIARCH_PATH}/libuuid.so.1")
	set(FLAC_LIBRARY "/usr/lib/${MULTIARCH_PATH}/libFLAC.so.8")
	set(VORBISENC_LIBRARY "/usr/lib/${MULTIARCH_PATH}/libvorbisenc.so")
	set(VORBIS_LIBRARY "/usr/lib/${MULTIARCH_PATH}/libvorbis.so")
	set(OGG_LIBRARY "/usr/lib/${MULTIARCH_PATH}/libogg.so")
	set(ZZIP_LIBRARY "/usr/lib/libzzip.so")
	set(GOMP_LIBRARY "/usr/lib/${MULTIARCH_PATH}/libgomp.so.1")
	#set(PNG_LIBRARY "/lib/libpng12.so.0")

	### FIXME: just install these for now can be changed later ###
	if("${ARCH}" MATCHES "i686")
		INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/sse2/libspeex.so.1.5.0" DESTINATION "./lib" RENAME libspeex.so.1 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	else()
		INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libspeex.so.1.5.0" DESTINATION "./lib" RENAME libspeex.so.1 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	endif()
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libmp3lame.so.0.0.0" DESTINATION "./lib" RENAME libmp3lame.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libtheoraenc.so.1.1.2" DESTINATION "./lib" RENAME libtheoraenc.so.1 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libtheoradec.so.1.1.4" DESTINATION "./lib" RENAME libtheoradec.so.1 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libx264.so.132" DESTINATION "./lib" PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libvpx.so.1.1.0" DESTINATION "./lib" RENAME libvpx.so.1 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libopenjpeg-2.1.3.0.so" DESTINATION "./lib" RENAME libopenjpeg.so.2 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libschroedinger-1.0.so.0.11.0" DESTINATION "./lib" RENAME libschroedinger-1.0.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libgnutls.so.26.22.4" DESTINATION "./lib" RENAME libgnutls.so.26 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libtasn1.so.3.1.16" DESTINATION "./lib" RENAME libtasn1.so.3 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libgsm.so.1.0.12" DESTINATION "./lib" RENAME libgsm.so.1 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/lib/${MULTIARCH_PATH}/libpng12.so.0.49.0" DESTINATION "./lib" RENAME libpng12.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
#	INSTALL(FILES "/lib/libz.so.1.2.3.3" DESTINATION "./lib" RENAME libz.so.1 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libzzip-0.so.13.0.56" DESTINATION "./lib" RENAME libzzip-0.so.13 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/lib/${MULTIARCH_PATH}/libbz2.so.1.0.4" DESTINATION "./lib" RENAME libbz2.so.1.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libfreetype.so.6.8.1" DESTINATION "./lib" RENAME libfreetype.so.6 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/lib/${MULTIARCH_PATH}/libgcrypt.so.11.7.0" DESTINATION "./lib" RENAME libgcrypt.so.11 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/lib/${MULTIARCH_PATH}/libgpg-error.so.0.8.0" DESTINATION "./lib" RENAME libgpg-error.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
 
	#New ffmpeg dependencies
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libvo-amrwbenc.so.0.0.3" DESTINATION "./lib" RENAME libvo-amrwbenc.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libvo-aacenc.so.0.0.3" DESTINATION "./lib" RENAME libvo-aacenc.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libfdk-aac.so.0.0.2" DESTINATION "./lib" RENAME libfdk-aac.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libcrystalhd.so.3.6" DESTINATION "./lib" RENAME libcrystalhd.so.3 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/librtmp.so.0" DESTINATION "./lib" PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libmng.so.1.1.0.10" DESTINATION "./lib" RENAME libmng.so.1 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libIlmImf.so.6.0.0" DESTINATION "./lib" RENAME libIlmImf.so.6 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libImath.so.6.0.0" DESTINATION "./lib" RENAME libImath.so.6 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libHalf.so.6.0.0" DESTINATION "./lib" RENAME libHalf.so.6 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libIex.so.6.0.0" DESTINATION "./lib" RENAME libIex.so.6 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libIlmThread.so.6.0.0" DESTINATION "./lib" RENAME libIlmThread.so.6 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libraw.so.5.0.0" DESTINATION "./lib" RENAME libraw.so.5 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libva.so.1.3200.0" DESTINATION "./lib" RENAME libva.so.1 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libxvidcore.so.4.3" DESTINATION "./lib" RENAME libxvidcore.so.4 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libopus.so.0.0.0" DESTINATION "./lib" RENAME libopus.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libopencore-amrnb.so.0.0.3" DESTINATION "./lib" RENAME libopencore-amrnb.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libopencore-amrwb.so.0.0.3" DESTINATION "./lib" RENAME libopencore-amrwb.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libfaac.so.0.0.0" DESTINATION "./lib" RENAME libfaac.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libaacplus.so.2.0.2" DESTINATION "./lib" RENAME libaacplus.so.2 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libbluray.so.1.1.0" DESTINATION "./lib" RENAME libbluray.so.1 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libts-0.0.so.0.1.1" DESTINATION "./lib" RENAME libts-0.0.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/liborc-0.4.so.0.16.0" DESTINATION "./lib" RENAME liborc-0.4.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libp11-kit.so.0.0.0" DESTINATION "./lib" RENAME libp11-kit.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/libjasper.so.1.0.0" DESTINATION "./lib" RENAME libjasper.so.1 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")

	INSTALL(FILES "${MYGUI_LIB_DIR}/libMyGUIEngine.so.3.2.1" DESTINATION "./lib" RENAME "libMyGUIEngine.so.3" PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")

	string(REGEX REPLACE ".*;(/.*libSDL2).so;.*" "\\1" SDL2_LIBRARY_REAL "${SDL2_LIBRARY}")

	INSTALL(FILES "${SDL2_LIBRARY_REAL}-2.0.so.0.1.0" DESTINATION "./lib" RENAME libSDL2-2.0.so.0 PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")

        INSTALL(FILES "/usr/lib/${MULTIARCH_PATH}/liblcms.so.1.0.19" DESTINATION "./lib" RENAME "liblcms.so.1" PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")

	if(OGRE_Plugin_CgProgramManager_FOUND)
		find_package(Cg REQUIRED)
		#Cg always gets distributed only as libCg.so so we can copy it directly
		INSTALL(FILES "${Cg_LIBRARY_REL}" DESTINATION "./lib" PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	endif()

	exec_program("dirname" ARGS ${Boost_FILESYSTEM_LIBRARY} OUTPUT_VARIABLE BOOSTDIR)
	
	#dirty hack to keep the right boost libs for linking
	set(BOOST_TMP_LIBS ${Boost_LIBRARIES})
	
	if(Boost_VERSION GREATER 104900)
		SET(BOOST_PACKAGE_COMPONENTS ${BOOST_PACKAGE_COMPONENTS} chrono)
	endif()

	SET(BOOST_PACKAGE_COMPONENTS ${BOOST_PACKAGE_COMPONENTS} thread date_time wave)

	find_package(Boost REQUIRED COMPONENTS ${BOOST_PACKAGE_COMPONENTS})

	set(Boost_LIBRARIES ${BOOST_TMP_LIBS})

	#FIXME: Item names do not correspond linked names. How can we find those?

	#Reading symbolic links and copying the libs into ./lib
	INSTALL(DIRECTORY DESTINATION "./lib" COMPONENT "openmw")

	#TODO: Remove unnecessary commands and messages
	#TODO: Need better readlink algorithm for stuff like openal
	exec_program("dirname" ARGS ${OPENAL_LIBRARY} OUTPUT_VARIABLE OPENAL_DIRNAME)
	exec_program("readlink" ARGS ${OPENAL_LIBRARY} OUTPUT_VARIABLE NEXT_OPENAL_LINK)
	exec_program("readlink" ARGS "${OPENAL_DIRNAME}/${NEXT_OPENAL_LINK}" OUTPUT_VARIABLE REAL_OPENAL_LIBRARY)
#	message("${NEXT_OPENAL_LINK}")
#	message("${REAL_OPENAL_LIBRARY}")
	#TODO: We need to get rid of things like this extra stuff for pthread and freeimage ...
	#exec_program("readlink" ARGS ${PTHREAD_LIBRARY} OUTPUT_VARIABLE PTHREAD_READLINK)
	#INSTALL(FILES "/lib/${PTHREAD_READLINK}" DESTINATION "./lib" RENAME "libpthread.so.0" PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
	exec_program("readlink" ARGS ${FREEIMAGE_LIBRARY} OUTPUT_VARIABLE FREEIMAGE_READLINK)
	INSTALL(FILES "/usr/lib/${FREEIMAGE_READLINK}" DESTINATION "./lib" RENAME "libfreeimage.so.3" PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")

	#Libs that are linked with major version numbers
	set(LIBITEMS ${BULLET_DYNAMICS_LIBRARY} ${BULLET_COLLISION_LIBRARY} ${BULLET_MATH_LIBRARY} ${BULLET_SOFTBODY_LIBRARY}
	${MPG123_LIBRARY} ${FREETYPE_LIBRARY} ${SNDFILE_LIBRARY} ${PNG_LIBRARY} ${JPEG_LIBRARY} ${GOMP_LIBRARY} ${UUID_LIBRARY}
	${FLAC_LIBRARY} ${VORBISENC_LIBRARY} ${VORBIS_LIBRARY} ${OGG_LIBRARY} ${ZZIP_LIBRARY} ${SOUND_INPUT_LIBRARY}
	"${OPENAL_DIRNAME}/${REAL_OPENAL_LIBRARY}")

    if(BUILD_LAUNCHER)
        #This is also done in the Main CMakeLists.txt
        #but after the call to find_tgz_deps
        find_package(LIBUNSHIELD REQUIRED)
        if(NOT LIBUNSHIELD_FOUND)
               message(SEND_ERROR "Failed to find libunshield")
        endif(NOT LIBUNSHIELD_FOUND)

        set(LIBITEMS ${LIBITEMS} ${LIBUNSHIELD_LIBRARY})
    endif()

	message("Libraries linked with major version:")
foreach(CURRENT_ITEM ${LIBITEMS})
	message("${CURRENT_ITEM}")
endforeach(CURRENT_ITEM)
foreach(CURRENT_ITEM ${LIBITEMS})
	exec_program("readlink" ARGS ${CURRENT_ITEM} OUTPUT_VARIABLE ITEM_READLINK)
	#message("${ITEM_READLINK}")
	if("${ITEM_READLINK}" STREQUAL "")
		exec_program("basename" ARGS ${CURRENT_ITEM} OUTPUT_VARIABLE ITEM_NAME)
		string(REGEX REPLACE "(.+\\.so\\.[0-9]+)\\.[0-9]+\\.[0-9]+" "\\1" ITEM_MAJOR_VERSION_NAME ${ITEM_NAME})
		INSTALL(FILES "${CURRENT_ITEM}" DESTINATION "./lib" RENAME ${ITEM_MAJOR_VERSION_NAME} PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
#		message("${CURRENT_ITEM}")
#		message("${ITEM_NAME}")
	else()
		exec_program("dirname" ARGS ${CURRENT_ITEM} OUTPUT_VARIABLE ITEM_DIRNAME)
		exec_program("basename" ARGS ${CURRENT_ITEM} OUTPUT_VARIABLE ITEM_NAME)
		exec_program("basename" ARGS ${ITEM_READLINK} OUTPUT_VARIABLE ITEM_READLINK_NAME)
#		message("BASENAME: ${ITEM_NAME}")
		string(REGEX REPLACE "(.+\\.so\\.[0-9]+)\\.[0-9]+\\.[0-9]+" "\\1" ITEM_MAJOR_VERSION_NAME ${ITEM_READLINK_NAME})
		INSTALL(FILES "${ITEM_DIRNAME}/${ITEM_READLINK}" DESTINATION "./lib" RENAME ${ITEM_MAJOR_VERSION_NAME} PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
#		message("${ITEM_DIRNAME}/${ITEM_READLINK}")
#		message("Major Version Name: ${ITEM_MAJOR_VERSION_NAME}")
	endif("${ITEM_READLINK}" STREQUAL "")
endforeach(CURRENT_ITEM)


#Retrieve OGRE_LIB_DIR from OGRE_LIBRARIES
string(REGEX REPLACE "optimized(.*)/libOgreMain.sodebug.*" "\\1" OGRE_LIB_DIR ${OGRE_LIBRARIES})

	#Libs that are linked with the full version number
	if(${CMAKE_BUILD_TYPE} MATCHES "Debug")
		set(LIBITEMS ${Boost_DATE_TIME_LIBRARY_DBG} ${Boost_FILESYSTEM_LIBRARY} ${Boost_PROGRAM_OPTIONS_LIBRARY} ${Boost_SYSTEM_LIBRARY} ${Boost_THREAD_LIBRARY} ${Boost_WAVE_LIBRARY_DBG}
		${Boost_CHRONO_LIBRARY_DBG} ${OIS_LIBRARY_REL} "${OGRE_LIB_DIR}/libOgreMain_d.so" "${OGRE_LIB_DIR}/libOgreTerrain_d.so" "${OGRE_LIB_DIR}/libOgrePaging_d.so")
	else()
		set(LIBITEMS ${Boost_DATE_TIME_LIBRARY} ${Boost_FILESYSTEM_LIBRARY} ${Boost_PROGRAM_OPTIONS_LIBRARY} ${Boost_SYSTEM_LIBRARY} ${Boost_THREAD_LIBRARY} ${Boost_WAVE_LIBRARY}
		${Boost_CHRONO_LIBRARY} ${OIS_LIBRARY_REL} "${OGRE_LIB_DIR}/libOgreMain.so" "${OGRE_LIB_DIR}/libOgreTerrain.so" "${OGRE_LIB_DIR}/libOgrePaging.so")
		#Opencs currently always builds in debug mode - disabled for targz package now
		#if(BUILD_OPENCS)
		#	set(LIBITEMS ${LIBITEMS} "${OGRE_LIB_DIR}/libOgreMain_d.so")
		#endif(BUILD_OPENCS)
	endif()
	message("Libraries linked with full version:")
foreach(CURRENT_ITEM ${LIBITEMS})
	message("${CURRENT_ITEM}")
endforeach(CURRENT_ITEM)
foreach(CURRENT_ITEM ${LIBITEMS})
	exec_program("readlink" ARGS ${CURRENT_ITEM} OUTPUT_VARIABLE ITEM_READLINK)
	#message("${ITEM_READLINK}")
	if("${ITEM_READLINK}" STREQUAL "")
		INSTALL(FILES "${CURRENT_ITEM}" DESTINATION "./lib" PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
		#message("${CURRENT_ITEM}")
	else()
		exec_program("dirname" ARGS ${CURRENT_ITEM} OUTPUT_VARIABLE ITEM_DIRNAME)
		exec_program("basename" ARGS ${CURRENT_ITEM} OUTPUT_VARIABLE ITEM_NAME)
		#message("BASENAME: ${ITEM_NAME}")
		INSTALL(FILES "${ITEM_DIRNAME}/${ITEM_READLINK}" DESTINATION "./lib" PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE COMPONENT "openmw")
		#message("${ITEM_DIRNAME}/${ITEM_READLINK}")
	endif("${ITEM_READLINK}" STREQUAL "")
endforeach(CURRENT_ITEM)

endmacro (find_tgz_deps)
