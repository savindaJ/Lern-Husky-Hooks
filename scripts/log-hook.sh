#!/usr/bin/env sh
# Lightweight helper so each demo hook stays one readable line.
# Usage: scripts/log-hook.sh <hook-name> [detail...]
hook=$1
shift
printf '[husky demo] %-18s%s\n' "${hook}${1:+ }" "$*"
