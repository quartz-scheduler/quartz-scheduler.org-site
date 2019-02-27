<div class="secNavPanel"><a href=".">Contents</a> | <a href="JobInitPlugin">&lsaquo;&nbsp;Prev</a> | <a href="ListTriggers">Next&nbsp;&rsaquo;</a></div>





# How-To: Listing Jobs in the Scheduler

### Listing all Jobs in the scheduler

<pre>

String[] jobGroups;
String[] jobsInGroup;
int i;
int j;

jobGroups = scheduler.getJobGroupNames();
for (i = 0; i < jobGroups.length; i++) {
   System.out.println("Group: " + jobGroups[i] + " contains the following jobs");
   jobsInGroup = scheduler.getJobNames(jobGroups[i]);

   for (j = 0; j < jobsInGroup.length; j++) {
      System.out.println("- " + jobsInGroup[j]);
   }
}

</pre>




