## cse-dtyo

This \LaTeX -template has been used by various people at department  since the late 1990's, and has slowly improved over time.  It is still  somewhat rough at the edges, but hopefully will be helpful in reducing  some of the pain involved in writing a diploma thesis. 

Contributors to the template include:

 * Mika Korhonen (original author)
 * Pekka Pietikäinen
 * Christian Wieser
 * Teemu Tokola
 * Juha Kylmänen
 * Joonas Sarajärvi
 * Tuomas Holmberg
 * Tuomas Varanka

We kindly ask for students using this template to improve this template,
and share the improvements, so that others may benefit.

Old \LaTeX template from OUSPG: https://github.com/ouspg/cse-dtyo. Current version modified from the old template.

### FILES AND FOLDERS
 * Figures
  * Place the necessary figures in your thesis here. A path to the figures has already been set when using "\begin{figure}...". Look for an example of how to use figures from Figure 1 and 2.
 * Chapters
  * This folder holds all the chapters that are added to the main file. To create more chapters simply create a .tex file in the chapters folder and input it in the main.tex file.
 * citations.bib
  * This holds all the bibtex citations. When searching for references online, use the "bibtex" form of citation.
 * di.bst
  * This holds the style for the bibliography. No need to go here.
 * di.sty
  * This is a package holds most of the scripts and style.
 * dithesis.cls
  * Similar to di.sty, holds scripts and style.
 * LICENSE
  * The license.
 * main.tex
  * The main file. Input your information and files here.
 * README.md
  * This file!

### LoC
 * 2019-06-06 Tuomas Holmberg and Tuomas Varanka
  * Cleanups 
  * Moved github version to Overleaf
  * Added an example of algorithm and an example equation
  * Added option for multiple authors
  * Hyperref for table of contents
  * Numerous quality of life updates
 * 2014-05-05 Joonas Sarajärvi
  * Cleanups
 * 2014-03-10 Juha Kylmänen
  * New front page 
 * 2013 Juha Kylmänen
  * Changed \chapter's \newpage to \clearpage to prevent floats from wandering to the beginning of the next chapter
  * Added [hyphens] to the url package to prevent margin overflow with long urls
  * Added multirow package to make multirow and multicolumns possible
  * Added some helpful source code comments
  * Makefile for pdflatex and bibtex to automate pdf compilation
  * Abbreviations are autosorted by the Makefile
  * Added a bit of extra padding to the sample table

### TODO    
 * Accessed time in url in citations automatically. (author=..., accessed=...)
 * Automatic sorting in list of abbreviations and symbols
 * Improve TitleCaps
 * Clean up algorithm environment (ifelse finnish)

