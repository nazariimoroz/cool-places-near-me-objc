set(CMAKE_EXPORT_COMPILE_COMMANDS 1)

cmake_minimum_required(VERSION 3.0.0)
project(L13)

SET(CMAKE_C_COMPILER clang)
SET(CMAKE_CXX_COMPILER clang++)

add_executable(L13 
	main.m
	CoolPlacesNearMe.h
	CoolPlacesNearMe.m
)

target_compile_options(L13 PRIVATE
	-MMD 
	-MP 
	-DGNUSTEP 
	-DGNUSTEP_BASE_LIBRARY=1 
	-DGNU_GUI_LIBRARY=1 
	-DGNU_RUNTIME=1 
	-DGNUSTEP_BASE_LIBRARY=1
	-fno-strict-aliasing 
	-fexceptions 
	-fobjc-exceptions 
	-D_NATIVE_OBJC_EXCEPTIONS 
	-pthread 
	-fPIC 
	-Wall 
	-DGSWARN 
	-DGSDIAGNOSE 
	-Wno-import 
	-g
	-fblocks	
	-O2 
	-fgnu-runtime 
	-fconstant-string-class=NSConstantString 
	-I. 
	# Dirs of GNUstep and libobj
	-I/home/ani/GNUstep/Library/Headers 
	-I/usr/local/include/GNUstep 
	-I/usr/include/GNUstep 
	-I./libobjc2
)

target_link_libraries(L13 gnustep-base objc BlocksRuntime m)

target_include_directories(L13 PRIVATE usr/include/GNUstep/)