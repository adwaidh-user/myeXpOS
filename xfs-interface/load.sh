#!/usr/bin/env bash

set -euo pipefail

usage() {
    echo "Usage: $(basename "$0") s --int=val1[,val2,...] --mod=val1[,val2,...]"
    echo ""
    echo "  s          Required integer"
    echo "  --int=     Comma-separated list of int values (each becomes: ./xfs-interface load --int=<val>)"
    echo "  --mod=     Comma-separated list of module values (each becomes: ./xfs-interface load --module <val>)"
    exit 1
}

# ─ Require at least one argument ────────────────────────────────────────────
if [[ $# -lt 1 ]]; then
    echo "Error: missing required argument 's'" >&2
    usage
fi

# ── Parse positional argument s ───────────────────────────────────────────────
s="$1"
shift

if ! [[ "$s" =~ ^[0-9]+$ ]]; then
    echo "Error: 's' must be an integer in range 3-24, got: '$s'" >&2
    usage
fi

# ── Parse optional flags ──────────────────────────────────────────────────────
int_vals=""
mod_vals=""

for arg in "$@"; do
    case "$arg" in
        --int=*)
            int_vals="${arg#--int=}"
            ;;
        --mod=*)
            mod_vals="${arg#--mod=}"
            ;;
        *)
            echo "Error: unknown argument '$arg'" >&2
            usage
            ;;
    esac
done

if [[ -z "$int_vals" && -z "$mod_vals" ]]; then
  ./xfs-interface run "../stages/stage$s/batch.txt"
fi

# ── Dispatch --int values ─────────────────────────────────────────────────────
if [[ -n "$int_vals" ]]; then
    IFS=',' read -ra int_arr <<< "$int_vals"
    for val in "${int_arr[@]}"; do
        val="$(echo "$val" | xargs)"   # trim whitespace
        [[ -z "$val" ]] && continue
        echo "Running: ./xfs-interface load --int=$val"
        ./xfs-interface load "--int=$val"
    done
fi

# ── Dispatch --mod values ─────────────────────────────────────────────────────
if [[ -n "$mod_vals" ]]; then
    IFS=',' read -ra mod_arr <<< "$mod_vals"
    for val in "${mod_arr[@]}"; do
        val="$(echo "$val" | xargs)"   # trim whitespace
        [[ -z "$val" ]] && continue
        echo "Running: ./xfs-interface load --module $val"
        ./xfs-interface load --module "$val"
    done
fi
