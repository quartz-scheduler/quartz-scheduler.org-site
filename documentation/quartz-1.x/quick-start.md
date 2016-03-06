---
title: Quick Start Guide
visible_title: "Quartz Quick Start Guide"
active_sub_menu_id: site_mnu_docs_quick_start
---
# Quartz 1.x Quick Start Guide

*(Primarily authored by Dafydd James)*

Welcome to the QuickStart guide for Quartz 1.x. As you read this guide, expect to see details of:

+ Downloading Quartz
+ Installing Quartz
+ Configuring Quartz to your own particular needs
+ Starting a sample application

## Download and Installation of Quartz

<a href="/downloads/">Download the most recent stable release</a>. Once you've downloaded and unpacked the zip file, it's time to install it so that your application can see it.

### The Quartz JAR files

The Quartz package includes a number of jar files, located in root directory of the distribution. The main Quartz library is named quartz-all-xxx.jar (where xxx is a version number). In order to use any of Quartz's features, this jar must be located on your application's classpath.

Once you've downloaded Quartz, unzip it somewhere, grab the quartz-all-xxx.jar and put it where you want it. (If you need information on how to unzip files, go away and learn before you go anywhere near a development environment or the Internet in general. Seriously.)

I use Quartz primarily within an application server environment, so my preference is to include the Quartz JAR within my enterprise application (.ear or .war file). However, if you want to make Quartz available to many applications then simply make sure it's on the classpath of your appserver.  If you are making a stand-alone application, place it on the application's classpath with all of the other JARs your application depends upon.

Quartz depends on a number of third-party libraries (in the form of jars) which are included in the distribution .zip file in the 'lib' directory. To use all the features of Quartz, all of these jars must also exist on your classpath. If you're building a stand-alone Quartz application, I suggest you simply add all of them to the classpath. If you're using Quartz within an app server environment, at least some of the jars will likely already exist on the classpath, so you can afford (if you want) to be a bit more selective as to which jars you include.

<blockquote>
	In an appserver environment, beware of strange results when accidentally including two different versions of the same jar. For example, WebLogic includes an implementation of J2EE (inside weblogic.jar) which may differ to the one in servlet.jar. In this case, it's usually better to leave servlet.jar out of your application, so you know which classes are being utilized.
</blockquote>

### The properties file

Quartz uses a properties file called (kudos on the originality) *quartz.properties*. This isn't necessary at first, but to use anything but the most basic configuration it must be located on your classpath.

Again, to give an example based on my personal situation, my application was developed using WebLogic Workshop. I keep all of my configuration files (including quartz.properties) in a project under the root of my application. When I package everything up into a .ear file, the config project gets packaged into a .jar which is included within the final .ear. This automatically puts quartz.properties on the classpath.

If you're building a web application (i.e. in the form of a .war file) that includes Quartz, you will likely want to place the quartz.properties file in the WEB-INF/classes folder in order for it to be on the classpath.

## Configuration

This is the big bit! Quartz is a very configurable application. The best way to configure Quartz is to edit a quartz.properties file, and place it in your application's classpath (see *Installation* section above).

There are several example properties files that ship within the Quartz distribution, particularly under the examples/ directory. I would suggest you create your own quartz.properties file, rather than making a copy of one of the examples and deleting the bits you don't need. It's neater that way, and you'll explore more of what Quartz has to offer.

Full documentation of available properties is available in the <a href="configuration/">Quartz Configuration Reference</a>.

To get up and running quickly, a basic quartz.properties looks something like this:


<pre>
org.quartz.scheduler.instanceName = MyScheduler
org.quartz.scheduler.instanceId = 1
org.quartz.scheduler.rmi.export = false
org.quartz.scheduler.rmi.proxy = false

org.quartz.threadPool.class = org.quartz.simpl.SimpleThreadPool
org.quartz.threadPool.threadCount = 3

org.quartz.jobStore.class = org.quartz.simpl.RAMJobStore

</pre>


The scheduler created by this configuration has the following characteristics:

+ <tt>org.quartz.scheduler.instanceName</tt> - It's called "MyScheduler" (doh)
+ <tt>org.quartz.scheduler.rmi.export</tt> - The scheduler is local, which means it can't be accessed using RMI (<a href="http://java.sun.com/products/jdk/rmi/">Remote Method Invocation</a>).
+ <tt>org.quartz.threadPool.threadCount</tt> - There are 3 threads in the thread pool, which means that a maximum of 3 jobs can be run simultaneously.
+ <tt>org.quartz.jobStore.class</tt> - All of Quartz's data, such as details of jobs and triggers, is held in memory (rather than in a database).

Even if you have a database and want to use it with Quartz, I suggest you get Quartz working with the RamJobStore before you open up a whole new dimension by working with a database.

## Starting a sample application

Now you've downloaded and installed Quartz, it's time to get a sample application up and running. The following code obtains an instance of the scheduler, starts it, then shuts it down:

**QuartzTest.java**

<pre>
import org.quartz.Scheduler;
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
</pre>
<blockquote>
Once you obtain a scheduler using StdSchedulerFactory.getDefaultScheduler(), your application will not terminate until you call scheduler.shutdown(), because there will be active threads.
</blockquote>

If you have not set up logging, all logs will be sent to the console and your output will look something like this:


<pre>

16-Dec-2004 16:15:21 org.quartz.simpl.SimpleThreadPool initialize
INFO: Job execution threads will use class loader of thread: main
16-Dec-2004 16:15:22 org.quartz.simpl.RAMJobStore initialize
INFO: RAMJobStore initialized.
16-Dec-2004 16:15:22 org.quartz.impl.StdSchedulerFactory instantiate
INFO: Quartz scheduler 'DefaultQuartzScheduler' initialized from default resource file in Quartz package: 'quartz.properties'
16-Dec-2004 16:15:22 org.quartz.impl.StdSchedulerFactory instantiate
INFO: Quartz scheduler version: 1.4.2
16-Dec-2004 16:15:22 org.quartz.core.QuartzScheduler start
INFO: Scheduler DefaultQuartzScheduler_$_NON_CLUSTERED started.
16-Dec-2004 16:15:22 org.quartz.core.QuartzScheduler shutdown
INFO: Scheduler DefaultQuartzScheduler_$_NON_CLUSTERED shutting down.
16-Dec-2004 16:15:22 org.quartz.core.QuartzScheduler pause
INFO: Scheduler DefaultQuartzScheduler_$_NON_CLUSTERED paused.
16-Dec-2004 16:15:22 org.quartz.core.QuartzScheduler shutdown
INFO: Scheduler DefaultQuartzScheduler_$_NON_CLUSTERED shutdown complete.

</pre>


To do something interesting, you need code between the *start()* and *shutdown()* calls.


<pre>

// Define job instance
JobDetail job = new JobDetail("job1", "group1", MyJobClass.class);

// Define a Trigger that will fire "now"
Trigger trigger = new SimpleTrigger("trigger1", "group1", new Date());

// Schedule the job with the trigger
scheduler.scheduleJob(job, trigger);

</pre>


Now go have some fun!
