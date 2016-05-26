#!/usr/bin/sh
cp $1/src/rpz/referat.tex $1/build/referat.tex 

mkdir -p $1/build/orgecon && cd $1/build/orgecon
cp $1/src/Common.hs $1/build/orgecon
cp $1/src/pgf-pie.sty $1/build
$1/$2 $1/src/rpz/orgecon/stages
$1/$2 $1/src/rpz/orgecon/costs
$1/$2 $1/src/rpz/orgecon/workers
$1/$2 $1/src/rpz/orgecon/salary
$1/$2 $1/src/rpz/orgecon/equip
$1/$2 $1/src/rpz/orgecon/workplace
$1/$2 $1/src/rpz/orgecon/overheads
$1/$2 $1/src/rpz/orgecon/others

mkdir -p $1/build/obzeco && cd $1/build/obzeco
cp $1/build/orgecon/*.hs $1/build/obzeco
cp $1/src/rpz/obzeco/*.png $1/build/obzeco
$1/$2 $1/src/rpz/obzeco/analysis
$1/$2 $1/src/rpz/obzeco/normalize
$1/$2 $1/src/rpz/obzeco/expertise
$1/$2 $1/src/rpz/obzeco/results

cd $1/build
$1/$2 $1/src/rpz

cp $1/src/utf8gost705u.bst $1/build
cp $1/src/biblio.bib $1/build

pdflatex -synctex=1 -interaction=nonstopmode rpz.tex
xdg-open rpz.pdf