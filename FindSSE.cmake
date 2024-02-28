# Taken from https://raw.githubusercontent.com/xbmc/xbmc/master/cmake/modules/FindSSE.cmake,
# who took it from https://github.com/hideo55/CMake-FindSSE/blob/master/FindSSE.cmake
# Modifed by me to add components

# Cmmponents: SSE2 SSE3 SSSE3 SSE41 SSE42 AVX AVX2

# Check if SSE instructions are available on the machine where
# the project is compiled.
include(TestCXXAcceptsFlag)
include(FindPackageHandleStandardArgs)

if(CMAKE_SYSTEM_NAME MATCHES "Linux")
   if(CPU MATCHES "x86_64" OR CPU MATCHES "i.86")
     exec_program(cat ARGS "/proc/cpuinfo" OUTPUT_VARIABLE CPUINFO)

     string(REGEX REPLACE "^.*(sse).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "sse" "${_SSE_THERE}" _SSE_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-msse" _SSE_OK)

     string(REGEX REPLACE "^.*(sse2).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "sse2" "${_SSE_THERE}" _SSE2_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-msse2" _SSE2_OK)

     # SSE3 is also known as the Prescott New Instructions (PNI)
     # it's labeled as pni in /proc/cpuinfo
     string(REGEX REPLACE "^.*(pni).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "pni" "${_SSE_THERE}" _SSE3_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-msse3" _SSE3_OK)

     string(REGEX REPLACE "^.*(ssse3).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "ssse3" "${_SSE_THERE}" _SSSE3_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-mssse3" _SSSE3_OK)

     string(REGEX REPLACE "^.*(sse4_1).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "sse4_1" "${_SSE_THERE}" _SSE41_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-msse4.1" _SSE41_OK)

     string(REGEX REPLACE "^.*(sse4_2).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "sse4_2" "${_SSE_THERE}" _SSE42_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-msse4.2" _SSE42_OK)

     string(REGEX REPLACE "^.*(avx).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "avx" "${_SSE_THERE}" _AVX_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-mavx" _AVX_OK)

     string(REGEX REPLACE "^.*(avx2).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "avx2" "${_SSE_THERE}" _AVX2_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-mavx2" _AVX2_OK)
   endif()
elseif(CMAKE_SYSTEM_NAME MATCHES "FreeBSD")
   if(CPU MATCHES "amd64" OR CPU MATCHES "i.86")
     exec_program(cat ARGS "/var/run/dmesg.boot | grep Features" OUTPUT_VARIABLE CPUINFO)

     string(REGEX REPLACE "^.*(SSE).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "SSE" "${_SSE_THERE}" _SSE_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-msse" _SSE_OK)

     string(REGEX REPLACE "^.*(SSE2).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "SSE2" "${_SSE_THERE}" _SSE2_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-msse2" _SSE2_OK)

     string(REGEX REPLACE "^.*(SSE3).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "SSE3" "${_SSE_THERE}" _SSE3_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-msse3" _SSE3_OK)

     string(REGEX REPLACE "^.*(SSSE3).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "SSSE3" "${_SSE_THERE}" _SSSE3_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-mssse3" _SSSE3_OK)

     string(REGEX REPLACE "^.*(SSE4.1).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "SSE4.1" "${_SSE_THERE}" _SSE41_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-msse4.1" _SSE41_OK)
     string(REGEX REPLACE "^.*(SSE4.2).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "SSE4.2" "${_SSE_THERE}" _SSE42_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-msse4.2" _SSE42_OK)

     string(REGEX REPLACE "^.*(AVX).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "AVX" "${_SSE_THERE}" _AVX_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-mavx" _AVX_OK)

     string(REGEX REPLACE "^.*(AVX2).*$" "\\1" _SSE_THERE ${CPUINFO})
     string(COMPARE EQUAL "AVX2" "${_SSE_THERE}" _AVX2_TRUE)
     CHECK_CXX_ACCEPTS_FLAG("-mavx2" _AVX2_OK)
   endif()
elseif(CMAKE_SYSTEM_NAME MATCHES "Android")
  if(CPU MATCHES "x86_64" OR CPU MATCHES "i.86")
    set(_SSE_TRUE TRUE)
    set(_SSE2_TRUE TRUE)
    set(_SSE3_TRUE TRUE)
    set(_SSSE3_TRUE TRUE)

    CHECK_CXX_ACCEPTS_FLAG("-msse" _SSE_OK)
    CHECK_CXX_ACCEPTS_FLAG("-msse2" _SSE2_OK)
    CHECK_CXX_ACCEPTS_FLAG("-msse3" _SSE3_OK)
    CHECK_CXX_ACCEPTS_FLAG("-mssse3" _SSSE3_OK)
    CHECK_CXX_ACCEPTS_FLAG("-msse4.1" _SSE41_OK)
    CHECK_CXX_ACCEPTS_FLAG("-msse4.2" _SSE42_OK)
    CHECK_CXX_ACCEPTS_FLAG("-mavx" _AVX_OK)
    CHECK_CXX_ACCEPTS_FLAG("-mavx2" _AVX2_OK)
   endif()
elseif(CMAKE_SYSTEM_NAME MATCHES "Darwin")
   if(NOT CPU MATCHES "arm")
      exec_program("/usr/sbin/sysctl -n machdep.cpu.features machdep.cpu.leaf7_features" OUTPUT_VARIABLE CPUINFO)

      string(REGEX REPLACE "^.*[^S](SSE).*$" "\\1" _SSE_THERE ${CPUINFO})
      string(COMPARE EQUAL "SSE" "${_SSE_THERE}" _SSE_TRUE)
      CHECK_CXX_ACCEPTS_FLAG("-msse" _SSE_OK)

      string(REGEX REPLACE "^.*[^S](SSE2).*$" "\\1" _SSE_THERE ${CPUINFO})
      string(COMPARE EQUAL "SSE2" "${_SSE_THERE}" _SSE2_TRUE)
      CHECK_CXX_ACCEPTS_FLAG("-msse2" _SSE2_OK)

      string(REGEX REPLACE "^.*[^S](SSE3).*$" "\\1" _SSE_THERE ${CPUINFO})
      string(COMPARE EQUAL "SSE3" "${_SSE_THERE}" _SSE3_TRUE)
      CHECK_CXX_ACCEPTS_FLAG("-msse3" _SSE3_OK)

      string(REGEX REPLACE "^.*(SSSE3).*$" "\\1" _SSE_THERE ${CPUINFO})
      string(COMPARE EQUAL "SSSE3" "${_SSE_THERE}" _SSSE3_TRUE)
      CHECK_CXX_ACCEPTS_FLAG("-mssse3" _SSSE3_OK)

      string(REGEX REPLACE "^.*(SSE4.1).*$" "\\1" _SSE_THERE ${CPUINFO})
      string(COMPARE EQUAL "SSE4.1" "${_SSE_THERE}" _SSE41_TRUE)
      CHECK_CXX_ACCEPTS_FLAG("-msse4.1" _SSE41_OK)

      string(REGEX REPLACE "^.*(SSE4.2).*$" "\\1" _SSE_THERE ${CPUINFO})
      string(COMPARE EQUAL "SSE4.2" "${_SSE_THERE}" _SSE42_TRUE)
      CHECK_CXX_ACCEPTS_FLAG("-msse4.2" _SSE42_OK)

      string(REGEX REPLACE "^.*(AVX).*$" "\\1" _SSE_THERE ${CPUINFO})
      string(COMPARE EQUAL "AVX" "${_SSE_THERE}" _AVX_TRUE)
      CHECK_CXX_ACCEPTS_FLAG("-mavx" _AVX_OK)

      string(REGEX REPLACE "^.*(AVX2).*$" "\\1" _SSE_THERE ${CPUINFO})
      string(COMPARE EQUAL "AVX2" "${_SSE_THERE}" _AVX2_TRUE)
      CHECK_CXX_ACCEPTS_FLAG("-mavx2" _AVX2_OK)
   endif()
 elseif(CMAKE_SYSTEM_NAME MATCHES "Windows")
   # Don't know how to check in Windows
   foreach(c SSE SSE2 SSE3 SSE41 SSE42 AVX AVX2)
      set(_${c}_TRUE true)
      set(_${c}_OK   true)
   endforeach()
endif()

# Added by Saman
# set components
# A components, say SSE41, is found if both _SSE41_TRUE and _SSE41_OK are set
foreach(comp ${SSE_FIND_COMPONENTS})
  if(_${comp}_TRUE AND _${comp}_OK)
    set(SSE_${comp}_FOUND TRUE)
  endif()
endforeach()

## Find package
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SSE
  REQUIRED_VARS _SSE_TRUE _SSE_OK
  HANDLE_COMPONENTS)

if(SSE_SSE41_FOUND)
  add_library(SSE41 INTERFACE)
  target_compile_options(SSE41
    INTERFACE
      $<$<OR:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>,$<CXX_COMPILER_ID:GNU>>:-mcrc32 -msse4.1 -mpclmul>)
  target_compile_definitions(SSE41 INTERFACE WITH_SSE41)

  add_library(SSE::SSE41 ALIAS SSE41)
endif()

mark_as_advanced(SSE_FOUND)

unset(_SSE_THERE)
unset(_SSE_TRUE)
unset(_SSE_OK)
unset(_SSE_OK CACHE)
unset(_SSE2_TRUE)
unset(_SSE2_OK)
unset(_SSE2_OK CACHE)
unset(_SSE3_TRUE)
unset(_SSE3_OK)
unset(_SSE3_OK CACHE)
unset(_SSSE3_TRUE)
unset(_SSSE3_OK)
unset(_SSSE3_OK CACHE)
unset(_SSE4_1_TRUE)
unset(_SSE41_OK)
unset(_SSE41_OK CACHE)
unset(_SSE4_2_TRUE)
unset(_SSE42_OK)
unset(_SSE42_OK CACHE)
unset(_AVX_TRUE)
unset(_AVX_OK)
unset(_AVX_OK CACHE)
unset(_AVX2_TRUE)
unset(_AVX2_OK)
unset(_AVX2_OK CACHE)

