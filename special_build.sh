#!/usr/bin/sh
mkdir -p $1/build/design && cd $1/build/design
cp $1/src/Common.hs $1/build/design
$1/$2 $1/src/rpz/design/arch

cd $1/build

rm $1/build/rpz.pdf 
pdflatex -synctex=1 -interaction=nonstopmode rpz.tex
xdg-open rpz.pdf