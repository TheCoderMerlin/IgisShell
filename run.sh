#!/bin/bash
if [[ -z "$LD_LIBRARY_PATH" ]]; then
    echo "Must provide LD_LIBRARY_PATH in environment" 1>&2
    exit 1
fi
echo "LD_LIBRARY_PATH at $LD_LIBRARY_PATH"
swift run -Xswiftc -I -Xswiftc $LD_LIBRARY_PATH -Xswiftc -L -Xswiftc $LD_LIBRARY_PATH -Xswiftc -lIgis
