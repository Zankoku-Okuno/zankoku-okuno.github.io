#! /bin/bash
rm -r *.html favicon.* img css js fonts subject posts stories
(cd src && runghc site.hs clean && runghc site.hs build)
cp -r src/_site/* .
