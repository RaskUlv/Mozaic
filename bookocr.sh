#!/bin/bash

if [ $# -eq 1 ]; then
	file=$1
	dirpm=$(dirname "$file")
else
	notify-send 'Bookocr' "No input file specified"
	exit
fi

ext=${file##*.}
filename=$(basename "$file")
fname=${filename%.*}

function f2ocr {
	notify-send 'Bookocr' "Starting OCR"
	for nm in $(seq -f %04g $pagenum) ; do
		ocr=$(cuneiform -l ruseng "$workdir/image-$nm.png" -o "$workdir/text-$nm.txt")
	done
	cat "$workdir"/text-*.txt > "$dirpm/$fname.txt"
	rm -rf "$workdir"
	notify-send 'Bookocr' "OCR is done: $fname.txt"
}
### Working with pdf file

if [ "$ext" == "pdf" ]; then
	workdir="$HOME/.tmp_pdf"
	mkdir -p "$workdir"
	pagenum=$(pdfinfo "$file" | awk '/Pages/' | awk '{print $2}' )
	notify-send 'Bookocr' "Converting to png: $filename"
	gs -r150 -q -sDEVICE=pngmono -dDOINTERPOLATE -dNOPAUSE -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sOutputFile="$workdir/image-%04d.png" -- "$file"
	f2ocr

### Working with djvu file

elif [ "$ext" == "djvu" ]; then
	workdir="$HOME/.tmp_djvu"
	mkdir -p "$workdir"
	notify-send 'Bookocr' "Converting to png: $filename"
	ddjvu -format=tiff -mode=black -quality=100 "$file" "$workdir/$fname.tiff"
	tiff2pdf -j -b -o "$workdir/$fname.pdf" "$workdir/$fname.tiff"
	pagenum=$(pdfinfo "$workdir/$fname.pdf" | awk '/Pages/' | awk '{print $2}' )
	echo "$workdir/$fname.pdf"
	gs -r150 -q -sDEVICE=pngmono -dDOINTERPOLATE -dNOPAUSE -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sOutputFile="$workdir/image-%04d.png" -- "$workdir/$fname.pdf"
	f2ocr

### Catching an error

else
	notify-send 'Bookocr' "This file type is not supported: $ext" 
fi
