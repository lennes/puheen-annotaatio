# Build html and pdf documents from tex in this directory
cd /home/lennes/annotaatio-opas
perl -i -p -e 's {\\renewcommand\\ttdefault\{pcr\}} {\%\\renewcommand\\ttdefault\{pcr\}};' annotation_guide.tex
perl -i -p -e 's {\\begin\{landscape\}} {\%\\begin\{landscape\}};' annotation_guide.tex
perl -i -p -e 's {\\end\{landscape\}} {\%\\end\{landscape\}};' annotation_guide.tex
#perl -i -p -e 's {\/home\/lennes\/annotation_guide\/jpgfigs\/} {jpgfigs\/};' annotation_guide.tex

pdflatex annotation_guide
bibtex annotation_guide
makeindex annotation_guide
pdflatex annotation_guide
pdflatex annotation_guide

latex2html -split 4 -title "Annotaatio-opas" -iso_language FI -link 5 -toc_depth 3 -mkdir -discard -no_footnode -noinfo -image_type gif -white -antialias -local_icons -images -nosubdir -short_index -show_section_numbers annotation_guide

perl -i -p -e 's {\/home\/lennes\/annotaatio-opas\/jpgfigs\/} {jpgfigs\/};' *.html
perl -i -p -e 's {SRC\=\".\/} {SRC\=\"jpgfigs\/};' *.html

perl -i -p -e 's {\~{}} {~};' annotation_guide.tex
perl -i -p -e 's {\%\\renewcommand\\ttdefault\{pcr\}} {\\renewcommand\\ttdefault\{pcr\}};' annotation_guide.tex
perl -i -p -e 's {\%\\begin\{landscape\}} {\\begin\{landscape\}};' annotation_guide.tex
perl -i -p -e 's {\%\\end\{landscape\}} {\\end\{landscape\}};' annotation_guide.tex

pdflatex annotation_guide
pdflatex annotation_guide

perl -i -p -e 's {~} {\~{}};' annotation_guide.tex

acroread annotation_guide.pdf &
