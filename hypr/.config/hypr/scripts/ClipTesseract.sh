#!/bin/bash

dir="$(xdg-user-dir)/Notes/Tesseract"
file='tess.png'

shotarea() {
    tmpfile=~/test.png
    grim -g "$(slurp)" - >"$tmpfile"
    if [[ -s "$tmpfile" ]]; then
        wl-copy <"$tmpfile"
        mv "$tmpfile" "$dir/$file"
        echo "$dir/$file"
    fi
}

tesseractarea() {
    photoarea=$(shotarea) # Correcting the assignment of shotarea's output
    tesseract -l eng "$photoarea" "$dir/output" # Correcting the tesseract command
    cat "$dir/output.txt" | wl-copy # Correcting the piping syntax
}

echo $dir
tesseractarea

exit 0
