<div class="secNavPanel"><a href="./">Contents</a> | <a href="/documentation/quartz-1.x/tutorials/TutorialLesson01">&lsaquo;&nbsp;Prev</a> | <a href="/documentation/quartz-1.x/tutorials/TutorialLesson03">Next&nbsp;&rsaquo;</a></div>
# Quartz Enterprise Job Scheduler 1.x Tutorial

## Lesson 2: Jobs and Triggers

As mentioned previously, you can make Java component executable by the scheduler simply by making it implement
the Job interface. Here is the interface:

**The Job Interface**

<pre>
package org.quartz;

  public interface Job {

    public void execute(JobExecutionContext context)
      throws JobExecutionException;
  }
</pre>



In case you couldn't guess, when the Job's trigger fires (more on that in a moment), the execute(..) method is
invoked by the scheduler. The ***JobExecutionContext*** object that is passed to this method provides the job
instance with information about its "run-time" environment - a handle to the Scheduler that executed it, a handle to the
Trigger that triggered the execution, the job's JobDetail object, and a few other items.

The ***JobDetail*** object is created by the Quartz client (your program) at the time the Job is added
to the scheduler. It contains various property settings for the Job, as well as a ***JobDataMap***, which can
be used to store state information for a given instance of your job class.

***Trigger*** objects are used to trigger the execution (or 'firing') of jobs. When you wish to
schedule a job, you instantiate a trigger and 'tune' its properties to provide the scheduling you wish to have. Triggers
may also have a JobDataMap associated with them - this is useful to passing parameters to a Job that are specific to the
firings of the trigger. Quartz ships with a handful of different trigger types, but the most commonly used types are
SimpleTrigger and CronTrigger.

SimpleTrigger is handy if you need 'one-shot' execution (just single execution of a job at a given moment in
time), or if you need to fire a job at a given time, and have it repeat N times, with a delay of T between executions.
CronTrigger is useful if you wish to have triggering based on calendar-like schedules - such as "every Friday, at noon"
or "at 10:15 on the 10th day of every month."

Why Jobs AND Triggers? Many job schedulers do not have separate notions of jobs and triggers. Some define a 'job'
as simply an execution time (or schedule) along with some small job identifier. Others are much like the union of
Quartz's job and trigger objects. While developing Quartz, we decided that it made sense to create a separation between
the schedule and the work to be performed on that schedule. This has (in our opinion) many benefits.

For example, Jobs can be created and stored in the job scheduler independent of a trigger, and many triggers can
be associated with the same job. Another benefit of this loose-coupling is the ability to configure jobs that remain in
the scheduler after their associated triggers have expired, so that that it can be rescheduled later, without having to
re-define it. It also allows you to modify or replace a trigger without having to re-define its associated job.

Identifiers

Jobs and Triggers are given identifying names as they are registered with the Quartz scheduler. Jobs and triggers
can also be placed into 'groups' which can be useful for organizing your jobs and triggers into categories for later
maintenance. The name of a job or trigger must be unique within its group - or in other words, the true identifier of a
job or trigger is its name + group. If you leave the group of the Job or Trigger '*null*', it is equivalent to
having specified *Scheduler.DEFAULT_GROUP*.

You now have a general idea about what Jobs and Triggers are, you can learn more about them in <a
    href="/documentation/quartz-1.x/tutorials/TutorialLesson03" title="Tutorial Lesson 3">Lesson 3: More About Jobs &amp; JobDetails</a> and <a
    href="/documentation/quartz-1.x/tutorials/TutorialLesson04" title="Tutorial Lesson 4">Lesson 4: More About Triggers</a>.





