#!/usr/bin/sh
mkdir -p $1/build
cp $1/src/*.tex $1/build
cp $1/src/rpz/*.tex $1/build

mkdir -p $1/build/design && cd $1/build/design
cp $1/src/Common.hs $1/build/design
$1/$2 $1/src/rpz/design/arch

mkdir -p $1/build/technology
mkdir -p $1/build/science
cp -r $1/src/rpz/design/* $1/build/design
cp -r $1/src/rpz/technology/* $1/build/technology
cp -r $1/src/rpz/science/* $1/build/science

cd $1/src/rpz/design 
persist2er --input model.persist --output $1/build/model.er --title "Даталогическая модель" --size 1
erd -i $1/build/model.er -o $1/build/model.eps
erd -i $1/build/model.er -o $1/build/model.png

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
#$1/compile.sh $1/src/rpz

cp $1/src/utf8gost705u.bst $1/build
cp $1/src/biblio.bib $1/build

rm $1/build/rpz.pdf 
pdflatex -synctex=1 -interaction=nonstopmode rpz.tex
xdg-open rpz.pdf