<div class="secNavPanel"><a href="./">Contents</a> | <a href="/documentation/quartz-1.x/tutorials/TutorialLesson02">Next&nbsp;&rsaquo;</a></div>
# Quartz Enterprise Job Scheduler 1.x Tutorial

## Lesson 1: Using Quartz

Before you can use the scheduler, it needs to be instantiated (who'd have guessed?). To do this, you use a
SchedulerFactory. Some users of Quartz may keep an instance of a factory serialized in a JNDI store, others may find it
just as easy (or easier) to instantiate and use a factory instance directly (such as in the example below).

Once a scheduler is instantiated, it can be started, placed in stand-by mode, and shutdown. Note that once a
scheduler is shutdown, it cannot be restarted without being re-instantiated. Triggers do not fire (jobs do not execute)
until the scheduler has been started, nor while it is in the paused state.

Here's a quick snippet of code, that instantiates and starts a scheduler, and schedules a job for execution:


<pre>
SchedulerFactory schedFact = new org.quartz.impl.StdSchedulerFactory();

  Scheduler sched = schedFact.getScheduler();

  sched.start();

  JobDetail jobDetail = new JobDetail("myJob",
                                      null,
                                      DumbJob.class);

  Trigger trigger = TriggerUtils.makeHourlyTrigger(); // fire every hour
  trigger.setStartTime(TriggerUtils.getEvenHourDate(new Date()));  // start on the next even hour
  trigger.setName("myTrigger");

  sched.scheduleJob(jobDetail, trigger);
</pre>


As you can see, working with quartz is rather simple. In <a href="/documentation/quartz-1.x/tutorials/TutorialLesson02"
    title="Tutorial Lesson 2">Lesson 2</a> we'll give a quick overview of Jobs and Triggers, so that you can more fully
understand this example.





