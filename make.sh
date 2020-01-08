#!/bin/bash
CONFIG=${1:-debug}
FILENAME=$(basename -- "$0")
case $FILENAME in
    "run.sh")
	MODE="run";;
    "make.sh")
	MODE="build";;
    *)
	# Terminate on error after message
	echo "Expected filename to be either 'make.sh' or 'run.sh'"
	exit 1;;
esac


if [[ "$CONFIG" =~ ^(debug|release)$ ]]; then
    if [[ -z "$LD_LIBRARY_PATH" ]]; then
	echo "Must provide LD_LIBRARY_PATH in environment" 1>&2
	exit 1
    fi

    if [ "$CONFIG" == "debug" ]; then
       if [[ -z "$IGIS_LIBRARY_DEBUG_PATH" ]]; then
	   echo "Must provide IGIS_LIBRARY_DEBUG_PATH in environment" 1>&2
	   exit 1
       fi

       echo "LD_LIBRARY_PATH at $LD_LIBRARY_PATH"
       echo "IGIS_LIBRARY_DEBUG_PATH at $IGIS_LIBRARY_DEBUG_PATH"
       echo "Building debug configuration..."
       LD_LIBRARY_PATH="$IGIS_LIBRARY_DEBUG_PATH:$CURSES_LIBRARY_DEBUG_PATH:$NCURSES_LIBRARY_DEBUG_PATH:$LOGICAL_OPERATORS_LIBRARY_DEBUG_PATH" 
       swift $MODE -c debug -Xswiftc -I -Xswiftc $IGIS_LIBRARY_DEBUG_PATH -Xswiftc -L -Xswiftc $IGIS_LIBRARY_DEBUG_PATH -Xswiftc -lIgis
    else
       if [[ -z "$IGIS_LIBRARY_RELEASE_PATH" ]]; then
	   echo "Must provide IGIS_LIBRARY_RELEASE_PATH in environment" 1>&2
	   exit 1
       fi

       echo "LD_LIBRARY_PATH at $LD_LIBRARY_PATH"
       echo "IGIS_LIBRARY_RELEASE_PATH at $IGIS_LIBRARY_RELEASE_PATH"
       echo "Building release configuration..."
       LD_LIBRARY_PATH="$IGIS_LIBRARY_RELEASE_PATH:$CURSES_LIBRARY_RELEASE_PATH:$NCURSES_LIBRARY_RELEASE_PATH:$LOGICAL_OPERATORS_LIBRARY_RELEASE_PATH" 
       swift $MODE -c release -Xswiftc -I -Xswiftc $IGIS_LIBRARY_DEBUG_PATH -Xswiftc -L -Xswiftc $IGIS_LIBRARY_DEBUG_PATH -Xswiftc -lIgis
    fi    
else
    # Terminate on error after message
    echo "Argument specified must be either 'debug' or 'release'"
    exit 1;
fi
