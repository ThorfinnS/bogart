# Install script for directory: /opt/minetest/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/minetest" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/minetest")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/minetest"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/opt/minetest/bin/minetest")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/minetest" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/minetest")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/minetest")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/ca/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/ca/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/cs/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/cs/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/da/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/da/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/de/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/de/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/dv/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/dv/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/eo/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/eo/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/es/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/es/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/et/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/et/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/fr/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/fr/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/hu/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/hu/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/id/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/id/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/it/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/it/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/ja/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/ja/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/jbo/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/jbo/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/kn/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/kn/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/lt/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/lt/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/ms/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/ms/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/nb/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/nb/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/nl/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/nl/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/pl/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/pl/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/pt/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/pt/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/pt_BR/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/pt_BR/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/ro/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/ro/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/ru/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/ru/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/sl/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/sl/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/sr_Cyrl/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/sr_Cyrl/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/sv/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/sv/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/sw/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/sw/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/tr/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/tr/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/locale/uk/LC_MESSAGES" TYPE FILE FILES "/opt/minetest/locale/uk/LC_MESSAGES/minetest.mo")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/." TYPE DIRECTORY FILES "/opt/minetest/src/../fonts" FILES_MATCHING REGEX "/[^/]*\\.ttf$" REGEX "/[^/]*\\.txt$")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/opt/minetest/src/threading/cmake_install.cmake")
  include("/opt/minetest/src/content/cmake_install.cmake")
  include("/opt/minetest/src/database/cmake_install.cmake")
  include("/opt/minetest/src/gui/cmake_install.cmake")
  include("/opt/minetest/src/mapgen/cmake_install.cmake")
  include("/opt/minetest/src/network/cmake_install.cmake")
  include("/opt/minetest/src/script/cmake_install.cmake")
  include("/opt/minetest/src/unittest/cmake_install.cmake")
  include("/opt/minetest/src/util/cmake_install.cmake")
  include("/opt/minetest/src/irrlicht_changes/cmake_install.cmake")
  include("/opt/minetest/src/server/cmake_install.cmake")
  include("/opt/minetest/src/client/cmake_install.cmake")

endif()

