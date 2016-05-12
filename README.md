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
stack install haskintex
```

# Texmaker build string

```
stack exec -- haskintex -overwrite %.htex|pdflatex -synctex=1 -interaction=nonstopmode %.tex|bibtex build/%.aux|pdflatex -synctex=1 -interaction=nonstopmode %.tex|xdg-open %.pdf
```

# Configure Russian dictionaries

Repo contains russian dictionaries for `Sublime Text` in `extra` folder:
- `russian_english.aff` 
- `russian_english.dic`

You need to copy them to sublime packages dir (in root of the dir) and enable it via `View -> Dictionary -> russian_english` and then `F6`. Subsequent press of `F6` will disable spell checking.
