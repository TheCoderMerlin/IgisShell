#!/bin/bash
if [[ -z "$LD_LIBRARY_PATH" ]]; then
    echo "Must provide LD_LIBRARY_PATH in environment" 1>&2
    exit 1
fi
if [[ -z "$IGIS_LIBRARY_PATH" ]]; then
    echo "Must provide IGIS_LIBRARY_PATH in environment" 1>&2
    exit 1
fi
swift build -Xswiftc -I -Xswiftc $IGIS_LIBRARY_PATH -Xswiftc -L -Xswiftc $IGIS_LIBRARY_PATH -Xswiftc -lIgis
