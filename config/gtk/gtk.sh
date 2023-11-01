#!/bin/sh

gnome_schema="org.gnome.desktop.interface"
gsettings set "$gnome_schema" icon-theme "Dracula"
gsettings set "$gnome_schema" cursor-theme "Bibata-Modern-Ice"
gsettings set "$gnome_schema" font-name "JetBrains 11"
gsettings set "$gnome_schema" color-scheme "Dracula"
