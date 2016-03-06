<div class="secNavPanel"><a href="./">Contents</a> | <a href="/documentation/quartz-1.x/tutorials/TutorialLesson07">&lsaquo;&nbsp;Prev</a> | <a href="/documentation/quartz-1.x/tutorials/TutorialLesson09">Next&nbsp;&rsaquo;</a></div>
# Quartz Enterprise Job Scheduler 1.x Tutorial

## Lesson 8: SchedulerListeners

***SchedulerListeners*** are much like TriggerListeners and JobListeners, except they receive
notification of events within the Scheduler itself - not necessarily events related to a specific trigger or job.

Scheduler-related events include: the addition of a job/trigger, the removal of a job/trigger, a serious error
within the scheduler, notification of the scheduler being shutdown, and others.

**The org.quartz.SchedulerListener Interface**

<pre>
public interface SchedulerListener {

    public void jobScheduled(Trigger trigger);

    public void jobUnscheduled(String triggerName, String triggerGroup);

    public void triggerFinalized(Trigger trigger);

    public void triggersPaused(String triggerName, String triggerGroup);

    public void triggersResumed(String triggerName, String triggerGroup);

    public void jobsPaused(String jobName, String jobGroup);

    public void jobsResumed(String jobName, String jobGroup);

    public void schedulerError(String msg, SchedulerException cause);

    public void schedulerShutdown();

}
</pre>


SchedulerListeners are created and registered in much the same way as the other listener types, except there is
no distinction between global and non-global listeners. SchedulerListeners can be virtually any object that implements
the org.quartz.SchedulerListener interface.





