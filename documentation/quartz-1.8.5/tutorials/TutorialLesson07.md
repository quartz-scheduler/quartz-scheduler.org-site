<div class="secNavPanel"><a href="./">Contents</a> | <a href="/documentation/quartz-1.x/tutorials/TutorialLesson06">&lsaquo;&nbsp;Prev</a> | <a href="/documentation/quartz-1.x/tutorials/TutorialLesson08">Next&nbsp;&rsaquo;</a></div>
# Quartz Enterprise Job Scheduler 1.x Tutorial

## Lesson 7: TriggerListeners and JobListeners


Listeners are objects that you create to perform actions based on events occurring within the scheduler. As you
can probably guess, ***TriggerListeners*** receive events related to triggers, and ***JobListeners***
receive events related to jobs.

Trigger-related events include: trigger firings, trigger mis-firings (discussed in the "Triggers" section of this
document), and trigger completions (the jobs fired off by the trigger is finished).

**The org.quartz.TriggerListener Interface**


<pre>
public interface TriggerListener {

    public String getName();

    public void triggerFired(Trigger trigger, JobExecutionContext context);

    public boolean vetoJobExecution(Trigger trigger, JobExecutionContext context);

    public void triggerMisfired(Trigger trigger);

    public void triggerComplete(Trigger trigger, JobExecutionContext context,
            int triggerInstructionCode);
}
</pre>



Job-related events include: a notification that the job is about to be executed, and a notification when the job
has completed execution.

**The org.quartz.JobListener Interface**


<pre>
public interface JobListener {

    public String getName();

    public void jobToBeExecuted(JobExecutionContext context);

    public void jobExecutionVetoed(JobExecutionContext context);

    public void jobWasExecuted(JobExecutionContext context,
            JobExecutionException jobException);

}
</pre>



### Using Your Own Listeners {#TutorialLesson7-UsingYourOwnListeners}

To create a listener, simply create an object the implements either the org.quartz.TriggerListener and/or
org.quartz.JobListener interface. Listeners are then registered with the scheduler during run time, and must be given a
name (or rather, they must advertise their own name via their getName() method. Listeners can be registered as either
"global" or "non-global". Global listeners receive events for ALL triggers/jobs, and non-global listeners receive events
only for the specific triggers/jobs that explicitly name the listener in their getTriggerListenerNames() or
getJobListenerNames() properties.

<blockquote>
        As described above, listeners are registered with the scheduler during run time, and are NOT stored in
        the JobStore along with the jobs and triggers. The jobs and triggers only have the names of the related
        listeners stored with them. Hence, each time your application runs, the listeners need to be re-registered with
        the scheduler
</blockquote>

**Adding a JobListener to the Scheduler**


<pre>
scheduler.addGlobalJobListener(myJobListener);

</pre>

or

<pre>
scheduler.addJobListener(myJobListener);
</pre>



Listeners are not used by most users of Quartz, but are handy when application requirements create the need for
the notification of events, without the Job itself explicitly notifying the application.





