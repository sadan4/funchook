#!/usr/bin/env bash
set -e
source ./util.sh
DISASM_CMD="ERROR ERROR ERROR"
if [[ $DISASM == "Zydis" ]]; then
    DISASM_CMD="-D DISASM_ZYDIS"
elif [[ $DISASM == "capstone" ]]; then
    DISASM_CMD="-D DISASM_CAPSTONE"
elif [[ $DISASM == "distorm" ]]; then
    DISASM_CMD="-D DISASM_DISTORM"
fi

echo "-D _GNU_SOURCE=1 ${DISASM_CMD} -D SIZEOF_VOID_P=8"