#!/usr/bin/sh
mkdir -p $1/build/orgecon && cd $1/build/orgecon
cp $1/src/Common.hs $1/build/orgecon
$1/compile.sh $1/src/rpz/orgecon/salary
$1/compile.sh $1/src/rpz/orgecon/costs
$1/compile.sh $1/src/rpz/orgecon/stages
$1/compile.sh $1/src/rpz/orgecon/workers
$1/compile.sh $1/src/rpz/orgecon/equip
cd $1/build
$1/compile.sh $1/src/rpz

cp $1/src/utf8gost705u.bst $1/build
cp $1/src/biblio.bib $1/build

pdflatex -synctex=1 -interaction=nonstopmode rpz.tex
xdg-open rpz.pdf