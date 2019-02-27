#!/bin/sh

for file in *.html; do

       echo "Working on $file ..."

       # delete headers in Quartz html files.
       sed -n '1,5d' $file

       # delete the last 2 lines of the file.
       sed -n 'N;$!P;$!D;$d' $file

       # ant runs regex task on all apt files
       ant -Dtarget.file=$file
       
       # all .html are changed to .md
       mv $file `echo $file | sed 's/\(.*\.\)html/\1md/'` ;


# This sed  command removes the last 10 lines of HTML.

#      sed -n -e :a -e '1,10!{P;N;D;};N;ba'

   done

# Need to uniq Frame html files, then add extra line above all md heads.

