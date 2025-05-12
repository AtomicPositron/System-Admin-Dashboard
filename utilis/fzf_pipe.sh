#!/bin/bash
fzf_pipe() {

    echo "$1" | fzf \
        --color=fg:#787474,fg+:#dcd7d7 \
        --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#d7005f \
        --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf \
        --color=border:#d0d0d0,label:#aeaeae,preview-fg:#ffffff,query:#d9d9d9 \
        --border="rounded" \
        --border-label="Admin Dashboard" \
        --border-label-pos="0" \
        --preview-window="border" \
        --padding="2" \
        --margin="4" \
        --prompt="> " \
        --marker=">" \
        --pointer="◆" \
        --separator="─" \
        --scrollbar="│" \
        --info="right" \
        --preview="glow --style=dark $2"
}
