## Linking with quartz 3 repository

To generate the *full* site including Quartz docs, you need to link some Quartz directories in this repository.

You should do it for every version you want to work on.

```bash
cd quartz-worktree
git clone https://github.com/quartz-scheduler/quartz ${quartz-version}

# If you are on Windows, you would want to use "cp -r" instead of "ln -s"
ln -s ${quartz-version}/docs ../documentation/${quartz-version}
```

The `${quartz-version}` is the value set in `_config.yml` and it should be the latest
quartz release version. If you want to build other version of quartz docs, you can
add additional `${quartz-version}` that match to the git branch or tag. For examples: 

|quartz-version |branch_or_tag |
|---------------|--------------|
|2.3.2-SNAPSHOT |quartz-2.3.x  |
|2.3.1          |quartz-2.3.1  |

## Instructions for building/previewing

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

NOTE: On windows, you would need to run `bundle.bat exec jekyll serve -w` instead.

See `get-deps.sh` script on build steps reference.

### For Quartz-2.4.x releases

You need JDK8 to and Maven 3.6.0 to build
```
mvn package -Ddist -DskipTests
# Output is in distribution/target
```

### For Quartz-2.3.x releases

You need JDK7 to and Maven 3.6.0 to build
```
mvn package -DskipTests -Ddist 
# Output is in distribution/target
```

### For Quartz-2.2.x releases

You need JDK6 to and Maven 3.2.5 to build
```
mvn package -DskipTests -Ddist
# Output is in distribution/target
```

### For Quartz-2.1.x releases

You need JDK6 to and Maven 3.2.5 to build
```
mvn package -DskipTests -Dprepare-distribution
# Output is in quartz/target
# NOTE: This version and older does not have the .tar.gz dist package, so we only publish
# the "quartz-all.jar" file as download.
```