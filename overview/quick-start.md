---
layout: about_page
title: Quick Start
visible_title: "Quartz Quick Start Guide"
active_sub_menu_id: site_mnu_about_quick_start
---

_(Primarily authored by Dafydd James)_

Welcome to the QuickStart guide for Quartz. As you read this guide, expect to see details of:

* Downloading Quartz
* Installing Quartz
* Configuring Quartz to your own particular needs
* Starting a sample application


## Download and Installation of Quartz

To download Quartz, visit <http://www.quartz-scheduler.org/downloads/> and download the most
recent stable release.

Once you've downloaded and unpacked the zip file, it's time to install it so that your
application can see it.


### The Quartz JAR files

The Quartz package includes a number of jar files, located in "lib" directory of the
distribution. The main Quartz library is named quartz-xxx.jar (where xxx is a version
number). In order to use any of Quartz's features, this jar must be located on your
application's classpath.

Once you've downloaded Quartz, unzip it somewhere, grab the quartz-xxx.jar and put it
where you want it, such that it can be included in your classpath.

_Note: Quartz is also available on Maven Central, and instructions for including Quartz in your Maven
project can be found on the Quartz download page._

I use Quartz primarily within an application server environment, so my preference is to
include the Quartz JAR within my enterprise application (.ear or .war file). However, if you
want to make Quartz available to many applications then simply make sure it's on the
classpath of your appserver. If you are making a stand-alone application, place it on the
application's classpath with all of the other JARs your application depends upon.

Quartz depends on a small number of third-party libraries (in the form of jars) which are included
in the distribution .tar.gz file in the 'lib' directory. To use all the features of Quartz, all
of these jars must also exist on your classpath. If you're building a stand-alone Quartz
application, I suggest you simply add all of them to the classpath. If you're using Quartz
within an app server environment, at least some of the jars will likely already exist on the
classpath, so you can afford (if you want) to be a bit more selective as to which jars you
include.  For minimal usage, Quartz does require the slf4j-api jar.


### The properties file

Quartz uses a properties file called (kudos on the originality) _quartz.properties_. This isn't
necessary at first, but to use anything but the most basic configuration it must be located
on your classpath.

Again, to give an example based on my personal situation, my application was developed using
WebLogic Workshop. I keep all of my configuration files (including quartz.properties) in a
project under the root of my application. When I package everything up into a .ear file, the
config project gets packaged into a .jar which is included within the final .ear. This
automatically puts quartz.properties on the classpath.

If you're building a web application (i.e. in the form of a .war file) that includes Quartz,
you will likely want to place the quartz.properties file in the WEB-INF/classes folder in
order for it to be on the classpath.


## Configuration

This is the big bit! Quartz is a very configurable library. The best way to configure
Quartz is to edit a quartz.properties file, and place it in your application's classpath (see
section immediately above).

There are several example properties files that ship within the Quartz distribution,
particularly under the "examples" directory. I would suggest you create your own
quartz.properties file, rather than making a copy of one of the examples and deleting the
bits you don't need. It's neater that way, and you'll explore more of what Quartz has to
offer.

Full documentation of available properties is available in the [Quartz Configuration
Reference](/documentation/quartz-2.2.x/configuration).

To get up and running quickly, a basic quartz.properties looks something like this:

<pre class="prettyprint highlight"><code class="language-xml" data-lang="xml">  org.quartz.scheduler.instanceName = MyScheduler
  org.quartz.threadPool.threadCount = 3
  org.quartz.jobStore.class = org.quartz.simpl.RAMJobStore
</code></pre>

The scheduler created by this configuration has the following characteristics:

* `org.quartz.scheduler.instanceName` - This scheduler's name will be "MyScheduler".
* `org.quartz.threadPool.threadCount` - There are 3 threads in the thread pool, which means
  that a maximum of 3 jobs can be run simultaneously.
* `org.quartz.jobStore.class` - All of Quartz's data, such as details of jobs and triggers,
  is held in memory (rather than in a database).

Even if you have a database and want to use it with Quartz, I suggest you get Quartz working
with the RamJobStore before you open up a whole new dimension by working with a database.


## Starting a sample application

Now you've downloaded and installed Quartz, it's time to get a sample application up and
running. The following code obtains an instance of the scheduler, starts it, then shuts it
down:

**QuartzTest.java**
<pre class="prettyprint highlight"><code class="language-java" data-lang="java">  import org.quartz.Scheduler;
  import org.quartz.SchedulerException;
  import org.quartz.impl.StdSchedulerFactory;

  public class QuartzTest {

      public static void main(String[] args) {

          try {
              // Grab the Scheduler instance from the Factory
              Scheduler scheduler = StdSchedulerFactory.getDefaultScheduler();

              // and start it off
              scheduler.start();

              scheduler.shutdown();

          } catch (SchedulerException se) {
              se.printStackTrace();
          }
      }
  }
</code></pre>

Once you obtain a scheduler using StdSchedulerFactory.getDefaultScheduler(), your application
will not terminate until you call scheduler.shutdown(), because there will be active threads.

If you have not set up logging, all logs will be sent to the console and your output will
look something like this:

~~~
[INFO] 21 Jan 08:46:27.857 AM main [org.quartz.core.QuartzScheduler]
Quartz Scheduler v.2.0.0-SNAPSHOT created.

[INFO] 21 Jan 08:46:27.859 AM main [org.quartz.simpl.RAMJobStore]
RAMJobStore initialized.

[INFO] 21 Jan 08:46:27.865 AM main [org.quartz.core.QuartzScheduler]
Scheduler meta-data: Quartz Scheduler (v2.0.0) 'Scheduler' with instanceId 'NON_CLUSTERED'
  Scheduler class: 'org.quartz.core.QuartzScheduler' - running locally.
  NOT STARTED.
  Currently in standby mode.
  Number of jobs executed: 0
  Using thread pool 'org.quartz.simpl.SimpleThreadPool' - with 50 threads.
  Using job-store 'org.quartz.simpl.RAMJobStore' - which does not support persistence. and is not clustered.

[INFO] 21 Jan 08:46:27.865 AM main [org.quartz.impl.StdSchedulerFactory]
Quartz scheduler 'Scheduler' initialized from default resource file in Quartz package: 'quartz.properties'

[INFO] 21 Jan 08:46:27.866 AM main [org.quartz.impl.StdSchedulerFactory]
Quartz scheduler version: 2.0.0

[INFO] 21 Jan 08:46:27.866 AM main [org.quartz.core.QuartzScheduler]
Scheduler Scheduler_$_NON_CLUSTERED started.

[INFO] 21 Jan 08:46:27.866 AM main [org.quartz.core.QuartzScheduler]
Scheduler Scheduler_$_NON_CLUSTERED shutting down.

[INFO] 21 Jan 08:46:27.866 AM main [org.quartz.core.QuartzScheduler]
Scheduler Scheduler_$_NON_CLUSTERED paused.

[INFO] 21 Jan 08:46:27.867 AM main [org.quartz.core.QuartzScheduler]
Scheduler Scheduler_$_NON_CLUSTERED shutdown complete.
~~~

To do something interesting, you need code between the `start()` and `shutdown()` calls.

<pre class="prettyprint highlight"><code class="language-java" data-lang="java">  // define the job and tie it to our HelloJob class
  JobDetail job = newJob(HelloJob.class)
      .withIdentity("job1", "group1")
      .build();

  // Trigger the job to run now, and then repeat every 40 seconds
  Trigger trigger = newTrigger()
      .withIdentity("trigger1", "group1")
      .startNow()
      .withSchedule(simpleSchedule()
              .withIntervalInSeconds(40)
              .repeatForever())
      .build();

  // Tell quartz to schedule the job using our trigger
  sched.scheduleJob(job, trigger);
</code></pre>

(you will also need to allow some time for the job to be triggered and executed before
calling `shutdown()` - for a simple example such as this, you might just want to add a
`Thread.sleep(60000)` call).

Now go have some fun!
