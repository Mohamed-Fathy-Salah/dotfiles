#!/bin/sh

SUCKLESS_DIR="$(cd "$(dirname "$0")" && pwd)"
THEME_H="$SUCKLESS_DIR/theme.h"
DUNSTRC="$HOME/.config/dunst/dunstrc"

# Parse colors from theme.h
get_color() { sed -n "s/^#define $1 \"\(.*\)\"/\1/p" "$THEME_H"; }

BG_COLOR_REF=$(sed -n 's/^#define BG_COLOR \(.*\)/\1/p' "$THEME_H")
FG_COLOR_REF=$(sed -n 's/^#define FG_COLOR \(.*\)/\1/p' "$THEME_H")
BG_COLOR=$(get_color "$BG_COLOR_REF")
FG_COLOR=$(get_color "$FG_COLOR_REF")

# Update dunstrc colors
sed -i "
    /^\[urgency_low\]/,/^\[/ {
        s/^\\(    background = \\).*/\\1\"$BG_COLOR\"/
        s/^\\(    frame_color = \\).*/\\1\"$BG_COLOR\"/
    }
    /^\[urgency_normal\]/,/^\[/ {
        s/^\\(    background = \\).*/\\1\"$BG_COLOR\"/
        s/^\\(    frame_color = \\).*/\\1\"$FG_COLOR\"/
    }
    /^\[urgency_critical\]/,/^\[/ {
        s/^\\(    background = \\).*/\\1\"$BG_COLOR\"/
    }
" "$DUNSTRC"

# Build suckless tools
cd "$SUCKLESS_DIR/dwm"          && sudo make clean install
cd "$SUCKLESS_DIR/st-flexipatch" && sudo make clean install
cd "$SUCKLESS_DIR/dmenu"        && sudo make clean install

# Reload dunst to pick up dunstrc changes
killall dunst 2>/dev/null

# Restart dwm
killall dwm
