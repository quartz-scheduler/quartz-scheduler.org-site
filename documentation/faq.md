---
title: FAQ
visible_title: "Quartz FAQ"
active_sub_menu_id: site_mnu_docs_faq

---

<!-- NOTE: This document was ported as HTML from the old website. Ideally, it
will be converted to Markdown at some point.  Feel free to convert it if you
wish.  --Orion -->

# Frequently Answered Questions about Quartz

General Questions:

<ul>
  <li><a href="#FAQ-whatQuartz" title="whatQuartz on FAQ">What Is Quartz?</a></li>
  <li><a href="#FAQ-whatNotQuartz" title="whatNotQuartz on FAQ">What Isn't Quartz?</a></li>
  <li><a href="#FAQ-notTimer" title="notTimer on FAQ">Why not just use java.util.Timer?</a></li>
  <li><a href="#FAQ-alternatives" title="alternatives on FAQ">What are the available alternatives to Quartz?</a></li>
  <li><a href="#FAQ-howBuild" title="howBuild on FAQ">How do I build the Quartz source?</a></li>
  <li><a href="#FAQ-noUpdateCheck" title="howBuild on FAQ">How do I disable the update check?</a></li>
</ul>

<p>Miscellaneous Questions:</p>

<ul>
  <li><a href="#FAQ-scale" title="scale on FAQ">How many jobs is Quartz capable of running?</a></li>
  <li><a href="#FAQ-rmi" title="rmi on FAQ">I'm having issues with using Quartz via RMI</a></li>
</ul>

<p>Questions about Jobs:</p>

<ul>
  <li><a href="#FAQ-jobFactory" title="jobFactory on FAQ">How can I control the instantiation of Jobs?</a></li>
  <li><a href="#FAQ-durable" title="durable on FAQ">How do I keep a Job from being removed (deleted) after it completes?</a></li>
  <li><a href="#FAQ-stateful" title="stateful on FAQ">How do I keep a Job from firing concurrently?</a></li>
  <li><a href="#FAQ-interrupt" title="interrupt on FAQ">How do I stop a Job that is currently executing?</a></li>
</ul>

<p>Questions about Triggers:</p>

<ul>
  <li><a href="#FAQ-chain" title="chain on FAQ">How do I chain Job execution? Or, how do I create a workflow?</a></li>
  <li><a href="#FAQ-paused" title="paused on FAQ">Why isn't my trigger firing?</a></li>
  <li><a href="#FAQ-daylightSavings" title="daylightSavings on FAQ">Daylight Saving Time and Triggers</a></li>
</ul>

<p>Questions about JDBCJobStore:</p>

<ul>
  <li><a href="#FAQ-jdbcPerf" title="jdbcPerf on FAQ">How do I improve the performance of JDBC-JobStore?</a></li>
  <li><a href="#FAQ-jdbcValid" title="jdbcValid on FAQ">My DB Connections don't recover properly if the database server is restarted.</a></li>
</ul>

<p>Questions about Transactions:</p>

<ul>
  <li><a href="#FAQ-cmtDead" title="cmtDead on FAQ">I'm using JobStoreCMT and I'm seeing deadlocks, what can I do?</a></li>
  <li><a href="#FAQ-racDead" title="racDead on FAQ">I'm using Oracle RAC and I'm seeing deadlocks, what can I do?</a></li>
</ul>

<p>Questions about Clustering, (Scaling and High-Availability) Features:</p>

<ul>
  <li><a href="#FAQ-clustering" title="clustering on FAQ">What clustering capabilities exist with Quartz?</a></li>
</ul>

<p>Questions about Spring:</p>

<ul>
  <li><a href="#FAQ-springHelp" title="Spring Help on FAQ">I'm using Quartz via Spring's scheduler wrappers, and I need help...</a></li>
  <li><a href="#FAQ-springCommit" title="Spring TX on FAQ">I'm seeing triggers stuck in the ACQUIRED state, or other weird data problems.</a></li>
</ul>

<h2><a name="FAQ-GeneralQuestions"></a>General Questions</h2>

<h3>What is Quartz?  <a name="FAQ-whatQuartz"></a></h3>

<p>Quartz is a job scheduling library that can be integrated with, or used along
  side virtually any other software system. The term "job scheduler" seems to
  conjure different ideas for different people. As you read the tutorial, you
  should be able to get a firm idea of what we mean when we use this term, but
  in short, a job scheduler is a service component that is responsible for
  executing (or notifying) other software components when a pre-determined
  (scheduled) time arrives.</p>

<p>Quartz is quite flexible, and contains multiple usage paradigms that can be
  used separately or together, in order to achieve your desired behavior, and
  enable you to write your code in the manner that seems most 'natural' to
  your project.</p>

<p>Quartz is very light-weight, and requires very little setup/configuration -
  it can actually be used 'out-of-the-box' if your needs are relatively
  basic.</p>

<p>Quartz is fault-tolerant, and can persist ('remember') your scheduled jobs
  between system restarts.</p>

<p>Although Quartz is extremely useful for simply running certain system
  processes on given schedules, the full potential of Quartz can be realized
  when you learn how to use it to drive the flow of your application's
  business processes.</p>

<h3>What isn't Quartz?  <a name="FAQ-whatQuartz"></a></h3>

<p>Quartz is not a job queue - though it is often used as one, and can do a
reasonable job of such at a small scale.</p>

<p>Quartz is not a grid computation engine - though simple, small scale usage
as such can be achieved with effort.</p>

<p>Quartz is not a job execution service for use by business personnel - it
is a code library that can be easily embeded into applications that need the
capability to schedule application-related tasks to occur in the future or on
a recurring basis.</p>

<h3><a name="FAQ-WhatisQuartzFromaSoftwareComponentView%3F"></a>What is Quartz
  - From a Software Component View? <a name="FAQ-whatComp"></a></h3>

<p>Quartz is distributed as a small java library (.jar file) that contains all
  of the core Quartz functionality. The main interface (API) to this
  functionality is the Scheduler interface. It provides simple operations such
  as scheduling/unscheduling jobs, starting/stopping/pausing the
  scheduler.</p>

<p>If you wish to schedule your own software components for execution they must
  implement the simple Job interface, which contains the method execute(). If
  you wish to have components notified when a scheduled fire-time arrives,
  then the components should implement either the TriggerListener or
  JobListener interface.</p>

<p>The main Quartz 'process' can be started and ran within your own
  application, as a stand-alone application (with an RMI interface), or within
  a J2EE app. server to be used as a resource by your J2EE components.</p>

<h3><a name="FAQ-Whynotjustusejava.util.Timer%3F"></a>Why not just use
  java.util.Timer? <a name="FAQ-notTimer"></a></h3>

<p>Since JDK 1.3, Java has "built-in" timer capabilities, through the
  java.util.Timer and java.util.TimerTask classes - why would someone use
  Quartz rather than these standard features?</p>

<p>There are many reasons! Here are a few:</p>

<ol>
  <li>Timers have no persistence mechanism.</li>
  <li>Timers have inflexible scheduling (only able to set start-time
    &amp; repeat interval, nothing based on dates, time of day,
    etc.)</li>

  <li>Timers don't utilize a thread-pool (one thread per timer)</li>
  <li>Timers have no real management schemes - you'd have to write your
    own mechanism for being able to remember, organize and retrieve
    your tasks by name, etc.</li>
</ol>


<p>...of course to some simple applications these features may not be
  important, in which case it may then be the right decision not to use
  Quartz.</p>

<h3><a name="FAQ-alternatives"></a>What are the available alternatives to
  Quartz?<a name="#FAQ-alternatives"></a></h3>

<p>There are no known competing open source projects (there are a
  few <a href="http://java-source.net/open-source/job-schedulers">other open
    source schedulers</a>, but they are basically just Cron replacements written
  in Java).</p>

<p>Commercially, you will want to look at the
  well-regarded <a href="http://www.fluxcorp.com/">Flux scheduler</a>.</p>

<h3><a name="FAQ-HowdoIbuildtheQuartzsource%3F"></a>How do I build the Quartz
  source? <a name="FAQ-howBuild"></a></h3>

<p>Although Quartz ships "pre-built" many people like to make their own
  alterations and/or build the latest 'non-released' version of Quartz from
  CVS. To do this, follow the instructions in the "README.TXT" file that ships
  with Quartz.</p>


<h3><a name="FAQ-HowToDisableTheUpdateCheck%3F"></a>How do I disable the update
  check?<a name="FAQ-noUpdateCheck"></a></h3>

<p>Quartz contains an "update check" feature that connects to a server to check
  if there is a new version of Quartz
  available for download.  This check runs asynchronously and does not affect
  startup/initialization time of Quartz, and it fails gracefully if the
  connection cannot be made.  If the check runs, and an update is found, it will
  be reported as available in Quartz's logs.</p>

<p>You can disable the update check with the Quartz config property
  "org.quartz.scheduler.skipUpdateCheck: true" or
  the system property "org.terracotta.quartz.skipUpdateCheck=true" (which you can
  set in your system environment or as a -D on the java command line).  It is
  recommended that you disable the update check for production deployments.</p>

<h2><a name="FAQ-MiscellaneousQuestions"></a>Miscellaneous Questions</h2>

<h3><a name="FAQ-scale"></a>How many jobs is Quartz capable of running?</h3>

<p>This is a tough question to answer... the answer is basically "it
  depends".</p>

<p>I know you hate that answer, so here's some information about what it
  depends "on".</p>

<p>First off, the JobStore that you use plays a significant factor. The
  RAM-based JobStore is MUCH (1000x) faster than the JDBC-based JobStore. The
  speed of JDBC-JobStore depends almost entirely on the speed of the
  connection to your database, which data base system that you use, and what
  hardware the database is running on. Quartz actually does very little
  processing itself, nearly all of the time is spent in the database. Of
  course RAMJobStore has a more finite limit on how many Jobs and Triggers can
  be stored, as you're sure to have less RAM than hard-drive space for a
  database. You may also look at the FAQ "How do I improve the performance of
  JDBC-JobStore?"</p>

<p>So, the limiting factor of the number of Triggers and Jobs Quartz can
  "store" and monitor is really the amount of storage space available to the
  JobStore (either the amount of RAM or the amount of disk space).</p>

<p>Now, aside from "how many can I store?" is the question of "how many jobs
  can Quartz be running at the same moment in time?"</p>

<p>One thing that CAN slow down quartz itself is using a lot of listeners
  (TriggerListeners, JobListeners, and SchedulerListeners). The time spent in
  each listener obviously adds into the time spent "processing" a job's
  execution, outside of actual execution of the job. This doesn't mean that
  you should be terrified of using listeners, it just means that you should
  use them judiciously - don't create a bunch of "global" listeners if you can
  really make more specialized ones. Also don't do "expensive" things in the
  listeners, unless you really need to. Also be mindful that many plug-ins
  (such as the "history" plugin) are actually listeners.</p>

<p>The actual number of jobs that can be running at any moment in time is
  limited by the size of the thread pool. If there are five threads in the
  pool, no more than five jobs can run at a time. Be careful of making a lot
  of threads though, as the JVM, Operating System, and CPU all have a hard
  time juggling lots of threads, and performance degrades as the system spends
  time managing threads. In most cases performance starts to tank as you get
  into the several hundreds of threads (or fewer if the code being executed on
  the threads is intensive). Be mindful that if you're running within an
  application server, it probably has created at least a few dozen threads of
  its own!</p>

<p>Aside from those factors, it really comes down to what your jobs DO. If your
  jobs take a long time to complete their work, and/or their work is very
  CPU-intensive, then you're obviously not going to be able to run very many
  jobs at once, nor very many in a given span of time.</p>

<p>Finally, if you just can't get enough horse-power out of one Quartz
  instance, you can always load-balance many Quartz instances (on separate
  machines). Each will run the jobs out of the shared database on a first-come
  first-serve basis, as quickly as the triggers need fired.</p>

<p>The clustering feature works best for scaling out long-running and/or
  cpu-intensive jobs (distributing the work-load over multiple nodes).  If you
  need to scale out to support thousands of short-running (e.g 1 second) jobs,
  consider partitioning the set of jobs by using multiple distinct
  schedulers. Using one scheduler forces the use of a cluster-wide lock, a
  pattern that degrades performance as you add more clients.</p>

<p>So here you are this far into the answer of "how many", and I still haven't
  given you an actual number. And I really hate to, because of all of the
  variables mentioned above. So let me just say, there are installments of
  Quartz out there that are managing hundreds-of-thousands of Jobs and
  Triggers, and that are, at any given moment in time executing several dozens
  of jobs &#8211; without even utilizing Quartz's load-balancing
  capabilities. With this in mind, most people should feel confident that they
  can get the performance out of Quartz that they need.</p>


<h3><a name="FAQ-I%27mhavingissueswithusingQuartzviaRMI"></a>I'm having issues
  with using Quartz via RMI <a name="FAQ-rmi"></a></h3>

<p>RMI can be a bit problematic, especially if you don't have an understanding
  of how class loading via RMI works. I highly recommend reading all of the
  JavaDOC available about RMI, and strongly suggest you read the following
  references, dug up by a kind Quartz user (Mike Curwen)</p>

<p>An excellent description of RMI and
  codebase: <a href="http://www.kedwards.com/jini/codebase.html">http://www.kedwards.com/jini/codebase.html</a>. One
  of the important points is to realize that "codebase" is used by the
  client!</p>

<p>Quick info about security
  managers: <a href="http://gethelp.devx.com/techtips/java_pro/10MinuteSolutions/10min0500.asp">http://gethelp.devx.com/techtips/java_pro/10MinuteSolutions/10min0500.asp</a>.</p>


<p>The important 'take away' of the Java API is:</p>

<blockquote><p>RMI's class loader will not download any classes from remote
    locations if no security manager has been set.</p></blockquote>

<h2><a name="FAQ-QuestionsAboutJobs"></a>Questions About Jobs</h2>

<h3><a name="FAQ-HowcanIcontroltheinstantiationofJobs%3F"></a>How can I control
  the instantiation of Jobs? <a name="FAQ-jobFactory"></a></h3>

<p>See org.quartz.spi.JobFactory and the org.quartz.Scheduler.setJobFactory(..)
  method.  </p>


<h3><a name="FAQ-HowdoIkeepaJobfrombeingremovedafteritcompletes%3F"></a>How do
  I keep a Job from being removed after it
  completes? <a name="FAQ-durable"></a></h3>

<p>Set the property <em>JobDetail.setDurability(true)</em> - which instructs
  Quartz not to delete the Job when it becomes an "orphan" (when the Job not
  longer has a Trigger referencing it).</p>

<h3><a name="FAQ-HowdoIkeepaJobfromfiringconcurrently%3F"></a>How do I keep a
  Job from firing concurrently? <a name="FAQ-stateful"></a></h3>

<p>Make the job class implement StatefulJob rather than Job. Read the JavaDOC
  for StatefulJob for more information.</p>

<h3><a name="FAQ-HowdoIstopaJobthatiscurrentlyexecuting%3F"></a>How do I stop a
  Job that is currently executing? <a name="FAQ-interrupt"></a></h3>

<p>See the <em>org.quartz.InterruptableJob</em> interface, and
  the <em>Scheduler.interrupt(String, String)</em> method.</p>

<h2><a name="FAQ-QuestionsAboutTriggers"></a>Questions About Triggers</h2>

<h3><a name="FAQ-HowdoIchainJobexecution%3FOr%2ChowdoIcreateaworkflow%3F"></a>How
  do I chain Job execution? Or, how do I create a
  workflow? <a name="FAQ-chain"></a></h3>

<p>There currently is no "direct" or "free" way to chain triggers with
  Quartz. However there are several ways you can accomplish it without much
  effort. Below is an outline of a couple approaches:</p>

<p>One way is to use a listener (i.e. a TriggerListener, JobListener or
  SchedulerListener) that can notice the completion of a job/trigger and then
  immediately schedule a new trigger to fire. This approach can get a bit
  involved, since you'll have to inform the listener which job follows which -
  and you may need to worry about persistence of this information. See the
  listener <i>org.quartz.listeners.JobChainingJobListener</i> which ships with
  Quartz - as it already has some of this functionality.</p>

<p>Another way is to build a Job that contains within its JobDataMap the name
  of the next job to fire, and as the job completes (the last step in
  its <em>execute()</em> method) have the job schedule the next job. Several
  people are doing this and have had good luck. Most have made a base
  (abstract) class that is a Job that knows how to get the job name and group
  out of the JobDataMap using pre-defined keys (constants) and contains code
  to schedule the identified job. This abstract Job's implementation of
  execute() delegates to an abstract template method such as "doWork()" (where
  the extending Job class's real work goes) and then it contains the code for
  scheduling the follow-up job.  Then they simply make extensions of this
  class that included the work the job should do.  The usage of 'durable' jobs,
  or the overloaded addJob(JobDetail, boolean, boolean) method (added in Quartz 2.2)
  helps the application define all the jobs at once with their proper data,
  without yet creating triggers to fire them (other than one trigger to fire
  the first job in the chain).</p>

<p>In the future, Quartz will provide a much cleaner way to do this, but until
  then, you'll have to use one of the above approaches, or think of yet
  another that works better for you.</p>

<h3><a name="FAQ-Whyisn%27tmytriggerfiring%3F"></a>Why isn't my trigger
  firing? <a name="FAQ-paused"></a></h3>

<p>The most common reason for this is not having
  called <em>Scheduler.start()</em>, which tells the scheduler to start firing
  triggers.</p>

<p>The second most common reason is that the trigger or trigger group has been
  paused.</p>


<h3><a name="FAQ-DaylightSavingTimeandTriggers"></a>Daylight Saving Time and
  Triggers <a name="FAQ-daylightSavings"></a></h3>

<p>CronTrigger and SimpleTrigger each handle daylight savings time in their own
  way - each in the way that is intuitive to the trigger type.</p>

<p>First, as a review of what daylight savings time is, please read this
  resource: <a href="https://secure.wikimedia.org/wikipedia/en/wiki/Daylight_saving_time_around_the_world">https://secure.wikimedia.org/wikipedia/en/wiki/Daylight_saving_time_around_the_world</a>.
  Some readers may be unaware that the rules are different for different
  nations/contents.  For example, the 2005 daylight savings time started in
  the United States on April 3, but in Egypt on April 29.  It is also
  important to know that not only the dates are different for different
  locals, but the time of the shift is different as well.  Many places shift
  at 2:00 am, but others shift time at 1:00 am, others at 3:00 am, and still
  others right at midnight.</p>

<p><b>SimpleTrigger</b> allows you to schedule jobs to fire every N
  milliseconds.  As such, it has to do nothing in particular with respect to
  daylight savings time in order to "stay on schedule" - it simply keeps
  firing every N milliseconds.  Regardless your SimpleTrigger is firing every
  10 seconds, or every 15 minutes, or every hour or every 24 hours it will
  continue to do so.  However the implication of this which confuses some
  users is that if your SimpleTrigger is firing say every 12 hours, before
  daylight savings switches it may be firing at what appears to be 3:00 am and
  3:00 pm, but after daylight savings 4:00 am and 4:00 pm.  This is not a bug
  - the trigger has kept firing exacly every N milliseconds, it just that the
  "name" of that time that humans impose on that moment has changed.</p>

<p><b>CronTrigger</b> allows you to schedule jobs to fire at certain moments
  with respect to a "Gregorian calendar".  Hence, if you create a trigger to
  fire every day at 10:00 am, before and after daylight savings time switches
  it will continue to do so.  However, depending on whether it was the Spring
  or Autumn daylight savings event, for that particular Sunday, the actual
  time interval between the firing of the trigger on Sundary morning at 10:00
  am since its firing on Saturday morning at 10:00 am will not be 24 hours,
  but will instead be 23 or 25 hours respectively.  </p>

<p>There is one additional point users must understand about CronTrigger with
  respect to daylight savings.  This is that you should take careful thought
  about creating schedules that fire between midnight and 3:00 am (the
  critical window of time depends on your trigger's locale, as explained
  above).  The reason is that depending on your trigger's schedule, and the
  particular daylight event, the trigger may be skipped or may appear to not
  fire for an hour or two.  As examples, say you are in the United States,
  where daylight savings events occur at 2:00 am.  If you have a CronTrrigger
  that fires every day at 2:15 am, then on the day of the beginning of
  daylight savings time the trigger will be skipped, since, 2:15 am never
  occurs that day.  If you have a CronTrigger that fires every 15 minutes of
  every hour of every day, then on the day daylight savings time ends you will
  have an hour of time for which no triggerings occur, because when 2:00 am
  arrives, it will become 1:00 am again, however all of the firings during the
  one o'clock hour have already occurred, and the trigger's next fire time was
  set to 2:00 am - hence for the next hour no triggerings will occur.</p>

<div class="info">
  In summary, all of this makes perfect sense, and should be easy to
  remember if you keep these two rules in mind:
  <ul>
    <li>SimpleTrigger ALWAYS fires exactly every N seconds, with no
      relation to the time of day.</li>
    <li>CronTrigger ALWAYS fires at a given time of day and then
      computes its next time to fire. If that time does not occur
      on a given day, the trigger will be skipped.  If the time
      occurs twice in a given day, it only fires once, because
      after firing on that time the first time, it computes the
      next time of day to fire on.</li>
  </ul>
</div>

<p>Other trigger types that are based on sliding along a calendar (rather than
exact amounts of time), such as CalenderIntervalTrigger, will be similarly
affected - but rather than missing a firing, or firing twice, may end up having
it's fire time shifted by an hour.</p>


<h2><a name="FAQ-QuestionsAboutJDBCJobStore"></a>Questions About
  JDBCJobStore</h2>

<h3><a name="FAQ-HowdoIimprovetheperformanceofJDBCJobStore%3F"></a>How do I
  improve the performance of JDBC-JobStore? <a name="FAQ-jdbcPerf"></a></h3>

<p>There are a few known ways to speed up JDBC-JobStore, only one of which is
  very practical.</p>

<p>First, the obvious, but not-so-practical:</p>

<ul>
  <li>Buy a better (faster) network between the machine that runs Quartz,
    and the machine that runs your RDBMS.</li>
  <li>Buy a better (more powerful) machine to run your database on.</li>
  <li>Buy a better RDBMS.</li>
</ul>


<p>Now for something simple, but effective: Build indexes on the Quartz
  tables.</p>

<p>Most database systems will automatically put indexes on the primary-key
  fields, many will also automatically do it for the foreign-key field. Make
  sure yours does this, or make the indexes on all key fields of every table
  manually.</p>

<p>Next, manually add some additional indexes: most important to index are the
  TRIGGER table's "next_fire_time" and "state" fields. Last (but not as
  important), add indexes to every column on the FIRED_TRIGGERS table.</p>

<pre>
create index idx_qrtz_t_next_fire_time on qrtz_triggers(NEXT_FIRE_TIME);
create index idx_qrtz_t_state on qrtz_triggers(TRIGGER_STATE);
create index idx_qrtz_t_nf_st on qrtz_triggers(TRIGGER_STATE,NEXT_FIRE_TIME);
create index idx_qrtz_ft_trig_name on qrtz_fired_triggers(TRIGGER_NAME);
create index idx_qrtz_ft_trig_group on qrtz_fired_triggers(TRIGGER_GROUP);
create index idx_qrtz_ft_trig_name on qrtz_fired_triggers(TRIGGER_NAME);
create index idx_qrtz_ft_trig_n_g on \
    qrtz_fired_triggers(TRIGGER_NAME,TRIGGER_GROUP);
create index idx_qrtz_ft_trig_inst_name on qrtz_fired_triggers(INSTANCE_NAME);
create index idx_qrtz_ft_job_name on qrtz_fired_triggers(JOB_NAME);
create index idx_qrtz_ft_job_group on qrtz_fired_triggers(JOB_GROUP);
create index idx_qrtz_t_next_fire_time_misfire on \
    qrtz_triggers(MISFIRE_INSTR,NEXT_FIRE_TIME);
create index idx_qrtz_t_nf_st_misfire on \
    qrtz_triggers(MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
create index idx_qrtz_t_nf_st_misfire_grp on \
    qrtz_triggers(MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);
</pre>


<p>The clustering feature works best for scaling out long-running and/or
  cpu-intensive jobs (distributing the work-load over multiple nodes).  If you
  need to scale out to support thousands of short-running (e.g 1 second) jobs,
  consider partitioning the set of jobs by using multiple distinct schedulers
  (and hence multiple sets of tables (with distinct prefixes)). Using one
  scheduler forces the use of a cluster-wide lock, a pattern that degrades
  performance as you add more clients.</p>


<h3><a name="FAQ-MyDBConnectionsdon%27trecoverproperlyifthedatabaseserverisrestarted."></a>My
  DB Connections don't recover properly if the database server is
  restarted. <a name="FAQ-jdbcValid"></a></h3>

<p>If you're having Quartz create the connection data source (by specifying the
  connection parameters in the quartz properties file) make sure you have a
  connection validation query specified, such as:</p>

<pre class="code-java">org.quartz.dataSource.myDS.validationQuery=select 0 from dual</pre>

<p>This particular query is extremely efficient for Oracle. For other
  databases, you'll need to think of an efficient query that always works as
  long as the connection is good.</p>

<p>If you're datasource is managed by your application server, make sure the
  datasource is configured in such a way that it can detect failed
  connections.</p>

<h2><a name="FAQ-QuestionsAboutTransactions"></a>Questions About
  Transactions</h2>

<h3><a name="FAQ-I%27musingJobStoreCMTandI%27mseeingdeadlocks%2CwhatcanIdo%3F"></a>I'm
  using JobStoreCMT and I'm seeing deadlocks, what can I
  do? <a name="FAQ-cmtDead"></a></h3>

<p>JobStoreCMT is in heavy use, under heavy load by many people. It is believed
  to be free of bugs that can cause deadlock. However, every now and then we
  get complaints about deadlocks. In all cases thus far, the problem has
  turned out to be "user error", thus the list below is some things for you to
  check if you are experiencing deadlocks.</p>

<ul>
  <li>Some databases falsely detect deadlocks when a tx takes a long
    time. Make sure you have put indexes on your tables (see improving
    performance of JDBCJobStore).</li>
  <li>Make sure you have at least number-of-threads-in-thread-pool + 2
    connections in your datasources.</li>
  <li>Make sure you have both a managed and non-managed datasource
    configured for Quartz to use.</li>
  <li>Make sure that all work you do with the Scheduler interface is done
    from within a transaction. Accomplish this by using the Scheduler
    within a SessionBean that has its tx settings "Required" and
    "Container". Or within a MessageDrivenBean with similar
    settings. Finally, start a UserTransaction yourself, and commit the
    work when done.</li>
  <li>If your Jobs' execute() methods use the Scheduler, make sure a
    transaction is in progress by using a UserTransaction or by setting
    the Quartz config property
    "org.quartz.scheduler.wrapJobExecutionInUserTransaction=true".</li>
</ul>

<h3><a name="FAQ-I%27musingOracleRACandI%27mseeingdeadlocks%2CwhatcanIdo%3F"></a>I'm
  using Oracle RAC and I'm seeing deadlocks, what can I
  do? <a name="FAQ-racDead"></a></h3>

<p>Oracle RAC has many limitations relating to transactions and locking.  Quartz is
known to work fine with Oracle RAC if you're careful about the setup.  The
<a href="http://jira.terracotta.org/jira/browse/QTZ-149">QTZ-149</a> issue
contains some discussion and links that may help you if you're having issues.</p>

<h2><a name="FAQ-QuestionsAboutClustering"></a>Questions about Clustering,
  (Scaling and High-Availability) Features</h2>

<h3><a name="FAQ-clustering"></a>What clustering capabilities exist with
  Quartz?<a name="#FAQ-clustering"></a></h3>

<p>Quartz ships with well-proven clustering capabilities that offer scaling and
  high availability features. You can read about these features in the
  Quartz <a href="/documentation/quartz-2.2.x/configuration">Configuration Reference</a>.</p>

<p>Additional clustering features that do not rely upon a backing database are
  available (free of cost)
  from <a href="http://www.terracotta.org">Terracotta</a>.</p>


<h2><a name="FAQ-QuestionsAboutSpring"></a>Questions About Spring</h2>

<h3><a name="FAQ-springHelp"></a>I'm using Quartz via Spring's scheduler
  wrappers, and I need help...<a name="#FAQ-springHelp"></a></h3>

<p>Check with the Spring community...</p>

<h3><a name="FAQ-springCommit"></a>I'm seeing triggers stuck in the ACQUIRED
  state, or other weird data problems.<a name="#FAQ-springCommit"></a></h3>

<p>Spring defaults the Quartz property
  "org.quartz.jobStore.dontSetAutoCommitFalse" to "true" - which means Quartz
  will not turn off auto-commit mode on the database connections that it uses.
  This is the opposite of Quartz's own default for this setting.  If your
  connection is defaulting to have auto-commit on, then you'll run into all sorts
  of strange problems relating to data inconsistencies -- the most common symptom
  being triggers that are "stuck" in the "ACQUIRED" state.  Fix this by
  explicitly setting the property to "false".</p>
