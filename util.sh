#!/usr/bin/env bash
set -e
get_os() {
    if [[ $(uname) == "Linux" ]]; then
        echo "unix"
        return 0
    fi
}
get_c_arch() {
    _ARCH=$(uname -m)
    if [[ $_ARCH == "x86_64" ]]; then
        echo "x86"
        return 0
    elif [[ $_ARCH == "i686" ]]; then
        :
    elif [[ $_ARCH == "aarch64" ]]; then
        echo "arm64"
        return 0
    else
        echo "unknown"
        return 1
    fi
    echo $_ARCH
    return 0
}
get_asm_arch() {
    _ARCH=$(uname -m)
    if [[ $_ARCH == "x86_64" ]]; then
        :
    elif [[ $_ARCH == "i686" ]]; then
        :
    elif [[ $_ARCH == "aarch64" ]]; then
        echo "arm64"
        return 0
    else
        echo "unknown"
        return 1
    fi
    echo $_ARCH
    return 0
}