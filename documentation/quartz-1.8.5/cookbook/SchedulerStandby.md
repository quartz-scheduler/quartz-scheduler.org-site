<div class="secNavPanel"><a href=".">Contents</a> | <a href="CreateScheduler">&lsaquo;&nbsp;Prev</a> | <a href="ShutdownScheduler">Next&nbsp;&rsaquo;</a></div>





# How-To: Placing a Scheduler in Stand-by Mode

### Placing a Scheduler in Stand-by Mode

<pre>

// start() was previously invoked on the scheduler

scheduler.standby();

// now the scheduler will not fire triggers / execute jobs

// ...

scheduler.start();

// now the scheduler will fire triggers and execute jobs

</pre>




