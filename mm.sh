#!/usr/bin/env bash
set -euo pipefail

: "${HF_HOME:?HF_HOME must be set}"

LLAMA_CLI="${LLAMA_CLI:-/opt/llama.cpp/build/bin/llama-cli}"

usage() {
    cat <<EOF
mm - llama.cpp model manager (Native Edition)

Usage:
  mm <command> [arguments]

Commands:
  pull <repo[:quant]>    Download/cache model from Hugging Face using llama-cli
  list                   List available/cached models
  run <repo[:quant]>     Start llama-cli
  rm <repo>                Remove a cached model from HF_HOME
  help                   Show this help

Examples:
  mm pull Qwen/Qwen2.5-7B-Instruct-GGUF:Q4_K_M
  mm pull Qwen/Qwen2.5-Coder-1.5B-Instruct-GGUF:q4_k_m
  mm list
  mm run Qwen/Qwen2.5-7B-Instruct-GGUF:Q4_K_M
  mm rm Qwen/Qwen2.5-7B-Instruct-GGUF

# Pass options to llama-cli:
  mm run Qwen/Qwen2.5-7B-Instruct-GGUF:Q4_K_M -ngl 99 -c 8192

Environment:
  HF_HOME    $HF_HOME
  LLAMA_CLI  $LLAMA_CLI
EOF
}

die() {
    echo "error: $*" >&2
    exit 1
}

require_llama() {
    [[ -x "$LLAMA_CLI" ]] ||
        die "llama-cli not found or not executable: $LLAMA_CLI"
}

cmd_pull() {
    require_llama

    [[ $# -eq 1 ]] ||
        die "usage: mm pull <repo[:quant]>"

    local spec="$1"

    echo "==> Pulling model using llama-cli: $spec"
    echo "==> HF_HOME=$HF_HOME"
    echo

    # Ejecuta llama-cli con -h
    "$LLAMA_CLI" -hf "$spec" -h

    echo
    echo "==> Done"
}

cmd_list() {
    require_llama
    exec "$LLAMA_CLI" -cl
}

cmd_run() {
    require_llama

    [[ $# -ge 1 ]] ||
        die "usage: mm run <repo[:quant]> [llama-cli options...]"

    local model="$1"
    shift

    # Se añade por defecto -cnv para habilitar el modo chat interactivo con el modelo instructivo
    exec "$LLAMA_CLI" \
        -hf "$model" \
        --mmproj-auto \
        "$@"
}

cmd_remove() {
    [[ $# -eq 1 ]] ||
        die "usage: mm rm <repo>"

    local repo="$1"
    # Transforma "Organizacion/Nombre-Modelo" en el formato de carpetas que usa huggingface_hub
    local folder_name="models--${repo/\//--}"
    local target_dir="$HF_HOME/hub/$folder_name"

    echo "==> Removing: $repo"
    echo "==> Target directory: $target_dir"
    echo

    if [[ -d "$target_dir" ]]; then
        rm -rf "$target_dir"
        echo "==> Model cache deleted successfully."
    else
        echo "==> Warning: Directory not found. It might have been removed already."
    fi
}

case "${1:-help}" in
    pull)
        shift
        cmd_pull "$@"
        ;;

    list|ls)
        shift
        cmd_list "$@"
        ;;

    run|start)
        shift
        cmd_run "$@"
        ;;

    rm|remove)
        shift
        cmd_remove "$@"
        ;;

    help|-h|--help)
        usage
        ;;

    *)
        echo "error: unknown command: $1" >&2
        echo
        usage
        exit 1
        ;;
esac
