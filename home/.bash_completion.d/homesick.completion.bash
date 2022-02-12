#!/usr/bin/env bash

# ToDo: Review variables

function _homesick_completion()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Long options
    if [[ ${cur} == -* ]] ; then
        long_opts="--force --pretend --quiet --skip --no-pretend --no-quiet --no-skip"
        COMPREPLY=( $(compgen -W "${long_opts}" -- ${cur}) )
        return 0
    fi

    # Short options
    if [[ ${cur} == - ]] ; then
        short_opts="-f -p -q -s"
        COMPREPLY=( $(compgen -W "${short_opts}" -- ${cur}) )
        return 0
    fi

    # Command parameters
    case "${prev}" in
        cd|commit|destroy|diff|exec|link|open|pull|push|rc|show_path|status|unlink)
            opts=$(homesick list | sed -e 's/^[ \t]*//' -e "s/  .*//g")
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            return 0
            ;;
        clone|exec_all|generate|track)
            COMPREPLY=( $(compgen -f ${cur}) )
            return 0
            ;;
        list|version)
            return 0
            ;;
        *)
            ;;
    esac

    # Complete destination castle name on tracking a file or directory
    if [[ "${COMP_WORDS[1]}" == "track" && "${prev}" ]]; then
        opts=$(homesick list | sed -e 's/^[ \t]*//' -e "s/  .*//g")
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi

    # Commands
    opts="cd clone commit destroy diff exec exec_all generate help link list open pull push rc show_path status track unlink version"
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0

}
complete -F _homesick_completion homesick
