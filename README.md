# Specialist thesis 2016

You need:
- [stack](https://stackage.org)
- LaTeX distribution (I use [TexLive](https://www.tug.org/texlive/) from Fedora 23 repo)

To edit and/or build the docs you need either:
- [TexMaker](http://www.xm1math.net/texmaker/) - build string is given below.
- [Sublime Text 3](https://www.sublimetext.com/) - build scripts are embedded into `specialist.sublime-project`.

Prerequisites installation:
```
stack setup
stack install haskinst
```

# Texmaker build string

```
stack exec -- haskintex -overwrite %.htex|pdflatex -synctex=1 -interaction=nonstopmode %.tex|bibtex build/%.aux|pdflatex -synctex=1 -interaction=nonstopmode %.tex|xdg-open %.pdf
```