<div class="secNavPanel"><a href="./">Contents</a> | <a href="/documentation/quartz-1.x/tutorials/TutorialLesson02">&lsaquo;&nbsp;Prev</a> | <a href="/documentation/quartz-1.x/tutorials/TutorialLesson04">Next&nbsp;&rsaquo;</a></div>
# Quartz Enterprise Job Scheduler 1.x Tutorial


## Lesson 3: More About Jobs and Job Details

As you've seen, Jobs are rather easy to implement. There are just a few more things that you need to understand
about the nature of jobs, about the execute(..) method of the Job interface, and about JobDetails.

While a class that you implement is the actual "job", Quartz needs to be informed about various attributes that
you may wish the job to have. This is done via the JobDetail class, which was mentioned briefly in the previous section.
Software 'archaeologists' may be interested to know that in an older incarnation of Quartz, the implementation of the
functionality of JobDetail was imposed upon the implementor of each Job class by having all of JobDetail's 'getter'
methods on the Job interface itself. This forced a cumbersome job of re-implementing virtually identical code on every
Job class - which was really dumb... thus we created the JobDetail class.

Let's take a moment now to discuss a bit about the 'nature' of Jobs and the life-cycle of job instances within
Quartz. First lets take a look back at some of that snippet of code we saw in Lesson 1:


<pre>
JobDetail jobDetail = new JobDetail("myJob",               // job name
                                      sched.DEFAULT_GROUP,   // job group (you can also specify 'null' to use the default group)
                                      DumbJob.class);        // the java class to execute

  Trigger trigger = TriggerUtils.makeDailyTrigger(8, 30);
  trigger.setStartTime(new Date());
  trigger.setName("myTrigger");

  sched.scheduleJob(jobDetail, trigger);
</pre>



Now consider the job class "DumbJob" defined as such:


<pre>
public class DumbJob implements Job {

    public DumbJob() {
    }

    public void execute(JobExecutionContext context)
      throws JobExecutionException
    {
      System.err.println("DumbJob is executing.");
    }
  }
</pre>


Notice that we 'feed' the scheduler a JobDetail instance, and that it refers to the job to be executed by simply
providing the job's class. Each (and every) time the scheduler executes the job, it creates a new instance of the class
before calling its execute(..) method. One of the ramifications of this behavior is the fact that jobs must have a
no-argument constructor. Another ramification is that it does not make sense to have data-members defined on the job
class - as their values would be 'cleared' every time the job executes.

You may now be wanting to ask "how can I provide properties/configuration for a Job instance?" and "how can I
keep track of a job's state between executions?" The answer to these questions are the same: the key is the JobDataMap,
which is part of the JobDetail object.

### JobDataMap {#TutorialLesson3-JobDataMap}

The JobDataMap can be used to hold any number of (serializable) objects which you wish to have made available to
the job instance when it executes. JobDataMap is an implementation of the Java Map interface, and has some added
convenience methods for storing and retrieving data of primitive types.

Here's some quick snippets of putting data into the JobDataMap prior to adding the job to the scheduler:


<pre>
jobDetail.getJobDataMap().put("jobSays", "Hello World!");
jobDetail.getJobDataMap().put("myFloatValue", 3.141f);
jobDetail.getJobDataMap().put("myStateData", new ArrayList());
</pre>


Here's a quick example of getting data from the JobDataMap during the job's execution:


<pre>
public class DumbJob implements Job {

    public DumbJob() {
    }

    public void execute(JobExecutionContext context)
      throws JobExecutionException
    {
      String instName = context.getJobDetail().getName();
      String instGroup = context.getJobDetail().getGroup();

      JobDataMap dataMap = context.getJobDetail().getJobDataMap();

      String jobSays = dataMap.getString("jobSays");
      float myFloatValue = dataMap.getFloat("myFloatValue");
      ArrayList state = (ArrayList)dataMap.get("myStateData");
      state.add(new Date());

      System.err.println("Instance " + instName + " of DumbJob says: " + jobSays);
    }
  }
</pre>


If you use a persistent JobStore (discussed in the JobStore section of this tutorial) you should use some care in
deciding what you place in the JobDataMap, because the object in it will be serialized, and they therefore become prone
to class-versioning problems. Obviously standard Java types should be very safe, but beyond that, any time someone
changes the definition of a class for which you have serialized instances, care has to be taken not to break
compatibility. Further information on this topic can be found in this Java Developer Connection Tech
Tip: <a
    href="http://java.sun.com/developer/TechTips/2000/tt0229.html" target="external">Serialization In The Real World</a>. Optionally, you can put JDBC-JobStore and JobDataMap into a mode where only
primitives and strings can be stored in the map, thus eliminating any possibility of later serialization problems.


Triggers can also have JobDataMaps associated with them. This can be useful in the case where you have a Job that
is stored in the scheduler for regular/repeated use by multiple Triggers, yet with each independent triggering, you want
to supply the Job with different data inputs.

The JobDataMap that is found on the JobExecutionContext during Job execution serves as a convenience. It is a
merge of the JobDataMap found on the JobDetail and the one found on the Trigger, with the value in the latter overriding
any same-named values in the former.

Here's a quick example of getting data from the JobExecutionContext's merged JobDataMap during the job's
execution:


<pre>
public class DumbJob implements Job {

    public DumbJob() {
    }

    public void execute(JobExecutionContext context)
      throws JobExecutionException
    {
      String instName = context.getJobDetail().getName();
      String instGroup = context.getJobDetail().getGroup();

      JobDataMap dataMap = context.getMergedJobDataMap();  // Note the difference from the previous example

      String jobSays = dataMap.getString("jobSays");
      float myFloatValue = dataMap.getFloat("myFloatValue");
      ArrayList state = (ArrayList)dataMap.get("myStateData");
      state.add(new Date());

      System.err.println("Instance " + instName + " of DumbJob says: " + jobSays);
    }
  }
</pre>


### StatefulJob {#TutorialLesson3-StatefulJob}

Now, some additional notes about a job's state data (aka JobDataMap): A Job instance can be defined as "stateful"
or "non-stateful". Non-stateful jobs only have their JobDataMap stored at the time they are added to the scheduler. This
means that any changes made to the contents of the job data map during execution of the job will be lost, and will not
seen by the job the next time it executes. You have probably guessed, a stateful job is just the opposite - its
JobDataMap is re-stored after every execution of the job. One side-effect of making a job stateful is that it cannot be
executed concurrently. Or in other words: if a job is stateful, and a trigger attempts to 'fire' the job while it is
already executing, the trigger will block (wait) until the previous execution completes.

You 'mark' a Job as stateful by having it implement the ***StatefulJob*** interface, rather than the
Job interface.

### Job 'Instances'

One final point on this topic that may or may not be obvious by now: You can create a single job class, and store
many 'instance definitions' of it within the scheduler by creating multiple instances of JobDetails - each with its own
set of properties and JobDataMap - and adding them all to the scheduler.

When a trigger fires, the Job it is associated to is instantiated via the JobFactory configured on the Scheduler.
The default JobFactory simply calls newInstance() on the job class. You may want to create your own implementation of
JobFactory to accomplish things such as having your application's IoC or DI container produce/initialize the job
instance.

### Other Attributes Of Jobs {#TutorialLesson3-OtherAttributesOfJobs}

Here's a quick summary of the other properties which can be defined for a job instance via the JobDetail object:

* Durability - if a job is non-durable, it is automatically deleted from the scheduler once there are no longer any active triggers associated with it.
* Volatility - if a job is volatile, it is not persisted between re-starts of the Quartz scheduler.
* RequestsRecovery - if a job "requests recovery", and it is executing during the time of a 'hard shutdown'
    of the scheduler (i.e. the process it is running within crashes, or the machine is shut off), then it is re-executed
    when the scheduler is started again. In this case, the JobExecutionContext.isRecovering() method will return true.
* JobListeners - a job can have a set of zero or more JobListeners associated with it. When the job executes,
    the listeners are notified. More discussion on JobListeners can be found in the section of this document that is
    dedicated to the topic of TriggerListeners &amp; JobListeners.


### JobExecutionException {#TutorialLesson3-JobExecutionException}

Finally, we need to inform you of a few details of the Job.execute(..) method. The only type of exception
(including RuntimeExceptions) that you are allowed to throw from the execute method is the JobExecutionException.
Because of this, you should generally wrap the entire contents of the execute method with a 'try-catch' block. You
should also spend some time looking at the documentation for the JobExecutionException, as your job can use it to
provide the scheduler various directives as to how you want the exception to be handled.





