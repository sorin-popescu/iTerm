#!/usr/bin/env bash

plist="com.googlecode.iterm2.plist"
plistUrl="https://github.com/sorin-popescu/iTerm.git/master/$plist"
work_dir="$HOME/workspace/iterm"
newPlist="${work_dir}/${plist}"
installedPlist="$HOME/Library/Preferences/$plist"

log() {
    printf -- "-----> $*\n" ; return $? ;
}

add() {
    log "Downloading plist from $plistUrl"
    curl -L "$plistUrl" | plutil -convert binary1 -o "$newPlist" -

    cp -f "$newPlist" "$installedPlist"
    defaults read com.googlecode.iterm2
    log "iTerm preferences installed/updated in $installedPlist"
}

if [ -d "$work_dir" ]; then
   log "${work_dir} exist."
   add
else
    log "Create ${work_dir}..."
    mkdir "$work_dir"
    add
fi
