macro (find_tgz_deps)

	set(FREEIMAGE_LIBRARY "/usr/lib/libfreeimage.so.3")
	#Don't package pthread it's just too system dependant
	#set(PTHREAD_LIBRARY "/lib/libpthread.so.0")
	set(UUID_LIBRARY "/lib/libuuid.so.1")
	set(FLAC_LIBRARY "/usr/lib/libFLAC.so")
	set(VORBISENC_LIBRARY "/usr/lib/libvorbisenc.so")
	set(VORBIS_LIBRARY "/usr/lib/libvorbis.so")
	set(OGG_LIBRARY "/usr/lib/libogg.so")
	set(ZZIP_LIBRARY "/usr/lib/libzzip.so")
	#set(PNG_LIBRARY "/lib/libpng12.so.0")

	### FIXME: just install these for now can be changed later ###
	INSTALL(FILES "/usr/lib/libspeex.so.1.5.0" DESTINATION "./lib" RENAME libspeex.so.1 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libmp3lame.so.0.0.0" DESTINATION "./lib" RENAME libmp3lame.so.0 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libtheoraenc.so.1.1.2" DESTINATION "./lib" RENAME libtheoraenc.so.1 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libtheoradec.so.1.1.4" DESTINATION "./lib" RENAME libtheoradec.so.1 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libx264.so.120" DESTINATION "./lib" PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libvpx.so.0.9.6" DESTINATION "./lib" RENAME libvpx.so.0 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libopenjpeg-2.1.3.0.so" DESTINATION "./lib" RENAME libopenjpeg.so.2 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libschroedinger-1.0.so.0.2.0" DESTINATION "./lib" RENAME libschroedinger-1.0.so.0 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libgnutls.so.26.14.12" DESTINATION "./lib" RENAME libgnutls.so.26 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/liboil-0.3.so.0.3.0" DESTINATION "./lib" RENAME liboil-0.3.so.0 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libtasn1.so.3.1.7" DESTINATION "./lib" RENAME libtasn1.so.3 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libgsm.so.1.0.12" DESTINATION "./lib" RENAME libgsm.so.1 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/lib/libpng12.so.0.42.0" DESTINATION "./lib" RENAME libpng12.so.0 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/lib/libz.so.1.2.3.3" DESTINATION "./lib" RENAME libz.so.1 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libzzip-0.so.13.0.56" DESTINATION "./lib" RENAME libzzip-0.so.13 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/lib/libbz2.so.1.0.4" DESTINATION "./lib" RENAME libbz2.so.1.0 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/usr/lib/libfreetype.so.6.3.22" DESTINATION "./lib" RENAME libfreetype.so.6 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/lib/libgcrypt.so.11.5.2" DESTINATION "./lib" RENAME libgcrypt.so.11 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	INSTALL(FILES "/lib/libgpg-error.so.0.4.0" DESTINATION "./lib" RENAME libgpg-error.so.0 PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")

	INSTALL(FILES "${MYGUI_LIB_DIR}/libMyGUIEngine.so.3.2.0" DESTINATION "./lib" RENAME "libMyGUIEngine.so.3" PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")

	#Cg always gets distributed only as libCg.so so we can copy it directly
	INSTALL(FILES "${Cg_LIBRARY_REL}" DESTINATION "./lib" PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")

	#TODO: There are still many other libraries linked into the binaries or libraries which may not be present on all systems. What should we do with them? 
	#TODO: Use find_package for libboost_date_time aswell - Ogre depends on it
	exec_program("dirname" ARGS ${Boost_FILESYSTEM_LIBRARY} OUTPUT_VARIABLE BOOSTDIR)
	
	if(${CMAKE_BUILD_TYPE} MATCHES "Debug")
		### Didn't build boost debug libs yet. No idea if i should
		SET(Boost_DATE_TIME_LIBRARY_DBG ${BOOSTDIR}/libboost_date_time.so)
		#TODO Use find_package for libboost_wave aswell -- Shiny depends on it
		SET(Boost_WAVE_LIBRARY_DBG ${BOOSTDIR}/libboost_wave.so)
		#TODO Use find_package for libboost_chrono aswell -- libboost_wave depends on it
		SET(Boost_CHRONO_LIBRARY_DBG ${BOOSTDIR}/libboost_chrono.so)
	else()
		SET(Boost_DATE_TIME_LIBRARY ${BOOSTDIR}/libboost_date_time.so)
		#TODO Use find_package for libboost_wave aswell -- Shiny depends on it
		SET(Boost_WAVE_LIBRARY ${BOOSTDIR}/libboost_wave.so)
		#TODO Use find_package for libboost_chrono aswell -- libboost_wave depends on it
		SET(Boost_CHRONO_LIBRARY ${BOOSTDIR}/libboost_chrono.so)
	endif()	

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
	#INSTALL(FILES "/lib/${PTHREAD_READLINK}" DESTINATION "./lib" RENAME "libpthread.so.0" PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
	exec_program("readlink" ARGS ${FREEIMAGE_LIBRARY} OUTPUT_VARIABLE FREEIMAGE_READLINK)
	INSTALL(FILES "/usr/lib/${FREEIMAGE_READLINK}" DESTINATION "./lib" RENAME "libfreeimage.so.3" PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")

	#Libs that are linked with major version numbers
	set(LIBITEMS ${BULLET_DYNAMICS_LIBRARY} ${BULLET_COLLISION_LIBRARY} ${BULLET_MATH_LIBRARY} ${BULLET_SOFTBODY_LIBRARY}
	${MPG123_LIBRARY} ${FREETYPE_LIBRARY} ${SNDFILE_LIBRARY} ${PNG_LIBRARY} ${UUID_LIBRARY}	${FLAC_LIBRARY}
	${VORBISENC_LIBRARY} ${VORBIS_LIBRARY} ${OGG_LIBRARY} ${ZZIP_LIBRARY} ${FFMPEG_LIBRARIES} "${OPENAL_DIRNAME}/${REAL_OPENAL_LIBRARY}")
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
		INSTALL(FILES "${CURRENT_ITEM}" DESTINATION "./lib" RENAME ${ITEM_MAJOR_VERSION_NAME} PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
#		message("${CURRENT_ITEM}")
#		message("${ITEM_NAME}")
	else()
		exec_program("dirname" ARGS ${CURRENT_ITEM} OUTPUT_VARIABLE ITEM_DIRNAME)
		exec_program("basename" ARGS ${CURRENT_ITEM} OUTPUT_VARIABLE ITEM_NAME)
		exec_program("basename" ARGS ${ITEM_READLINK} OUTPUT_VARIABLE ITEM_READLINK_NAME)
#		message("BASENAME: ${ITEM_NAME}")
		string(REGEX REPLACE "(.+\\.so\\.[0-9]+)\\.[0-9]+\\.[0-9]+" "\\1" ITEM_MAJOR_VERSION_NAME ${ITEM_READLINK_NAME})
		INSTALL(FILES "${ITEM_DIRNAME}/${ITEM_READLINK}" DESTINATION "./lib" RENAME ${ITEM_MAJOR_VERSION_NAME} PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
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
	endif()
	message("Libraries linked with full version:")
foreach(CURRENT_ITEM ${LIBITEMS})
	message("${CURRENT_ITEM}")
endforeach(CURRENT_ITEM)
foreach(CURRENT_ITEM ${LIBITEMS})
	exec_program("readlink" ARGS ${CURRENT_ITEM} OUTPUT_VARIABLE ITEM_READLINK)
	#message("${ITEM_READLINK}")
	if("${ITEM_READLINK}" STREQUAL "")
		INSTALL(FILES "${CURRENT_ITEM}" DESTINATION "./lib" PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
		#message("${CURRENT_ITEM}")
	else()
		exec_program("dirname" ARGS ${CURRENT_ITEM} OUTPUT_VARIABLE ITEM_DIRNAME)
		exec_program("basename" ARGS ${CURRENT_ITEM} OUTPUT_VARIABLE ITEM_NAME)
		#message("BASENAME: ${ITEM_NAME}")
		INSTALL(FILES "${ITEM_DIRNAME}/${ITEM_READLINK}" DESTINATION "./lib" PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ COMPONENT "openmw")
		#message("${ITEM_DIRNAME}/${ITEM_READLINK}")
	endif("${ITEM_READLINK}" STREQUAL "")
endforeach(CURRENT_ITEM)

endmacro (find_tgz_deps)
