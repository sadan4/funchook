#!/usr/bin/env bash
set -e
source ./util.sh
ASM_ARCH=$(get_asm_arch)
C_ARCH=$(get_c_arch)
OS=$(get_os)
echo "src/Zydis/Zydis.c src/funchook.c src/arch_${C_ARCH}.c src/os_${OS}.c src/disasm_${DISASM}.c src/prehook-${ASM_ARCH}-sysv.S"
exit 0
