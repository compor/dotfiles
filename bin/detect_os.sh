#!/bin/bash

TR=$(which tr)
AWK=$(which awk)

# determine OS type

declare -gx OPSYS_TYPE="unknown"

declare -l UNAME_OUTPUT=$(uname)

case "$UNAME_OUTPUT" in
    linux*)
        OPSYS_TYPE="linux"
        ;;
    darwin*)
        OPSYS_TYPE="darwin"
        ;;
    win*)
        OPSYS_TYPE="windows"
        ;;
    *)
        ;;
esac


# determine OS distributor and codename

declare -gxl OPSYS_DISTRO="unknown"
declare -gxl OPSYS_CODENAME="unknown"
declare -gxl OPSYS_VERSION="unknown"

case "$OPSYS_TYPE" in
    linux)
        declare INTROSPECT_TOOL=$(which lsb_release)

        if [[ -n $INTROSPECT_TOOL ]]; then
            # distro
            declare -a OUTPUT_STR=( $($INTROSPECT_TOOL -i) )
            declare -i last_idx=${#OUTPUT_STR[@]}-1
            OPSYS_DISTRO=${OUTPUT_STR[last_idx]}

            # codename
            OUTPUT_STR=( $($INTROSPECT_TOOL -c) )
            last_idx=${#OUTPUT_STR[@]}-1
            OPSYS_CODENAME=${OUTPUT_STR[last_idx]}

            # version
            OUTPUT_STR=( $($INTROSPECT_TOOL -r) )
            last_idx=${#OUTPUT_STR[@]}-1
            OPSYS_VERSION=${OUTPUT_STR[last_idx]}
        fi
        ;;
    darwin)
        declare INTROSPECT_TOOL=$(which sw_vers)

        if [[ -n $INTROSPECT_TOOL ]]; then
            # distro
            declare OUTPUT_STR
            OUTPUT_STR=$($INTROSPECT_TOOL -productName | $TR -d [:blank:])

            case "$OUTPUT_STR" in
                macos*)
                    OPSYS_DISTRO="apple"
                    ;;
                *)
                    ;;
            esac

            # version
            OUTPUT_STR=$($INTROSPECT_TOOL -productVersion)
            OPSYS_VERSION=$(echo "$OUTPUT_STR" | $AWK 'BEGIN{FS="."}{print $1"."$2}')
        fi
        ;;
    *)
        ;;
esac


