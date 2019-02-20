### Quartz Documentation Has Moved

02/20/1029

https://github.com/quartz-scheduler/quartz/blob/master/docs/index.adoc

The main documentation of Quartz project is now part of the main code repository. This helps
colocate changes per each release better. The GitHub where source is hosted can render `asciidoc`
and `markdown` directly, so it makes the documentation updates much faster.

### Instructions for building/previewing

* Install Jekyll if you have not - follow instructions on the Jekyll home page (after first installing Ruby)
[http://jekyllrb.com/](http://jekyllrb.com/)

* After installing jekyll, install some gems:
  * nokogiri : "gem install nokogiri"
  * asciidoctor: " gem install jasciidoctor"
  * jekyll-asciidoc: " gem install jekyll-asciidoc"

* Clone this repository to your local system (if you're going to contribute content, fork it first, and clone that)
* cd into the "quartz.github.io" directory



* To generate and view the site "jekyll serve -w"   ( then point your browser at http://localhost:4000" )
* To generate the site "jekyll build"  

---
