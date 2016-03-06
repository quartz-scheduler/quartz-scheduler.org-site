<div class="secNavPanel"><a href=".">Contents</a> | <a href="ListJobs">&lsaquo;&nbsp;Prev</a> | <a href="JobTriggers">Next&nbsp;&rsaquo;</a></div>





# How-To: Listing Triggers In Scheduler

### Listing all Triggers in the scheduler

<pre>

String[] triggerGroups;
String[] triggersInGroup;
int i;
int j;

triggerGroups = sched.getTriggerGroupNames();
for (i = 0; i < triggerGroups.length; i++) {
   System.out.println("Group: " + triggerGroups[i] + " contains the following triggers");
   triggersInGroup = sched.getTriggerNames(triggerGroups[i]);

   for (j = 0; j < triggersInGroup.length; j++) {
      System.out.println("- " + triggersInGroup[j]);
   }
}

</pre>




