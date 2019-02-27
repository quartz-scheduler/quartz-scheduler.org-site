<div class="secNavPanel"><a href="./">Contents</a> | <a href="/documentation/quartz-1.x/tutorials/TutorialLesson10">&lsaquo;&nbsp;Prev</a> | <a href="/documentation/quartz-1.x/tutorials/TutorialLesson12">Next&nbsp;&rsaquo;</a></div>
# Quartz Enterprise Job Scheduler 1.x Tutorial

## Lesson 11: Advanced (Enterprise) Features

### Clustering {#TutorialLesson11-Clustering}

Clustering currently works with the JDBC-Jobstore (JobStoreTX or JobStoreCMT) and the TerracottaJobStore.
Features include load-balancing and job fail-over (if the JobDetail's "request recovery" flag is set to true).

**Clustering With JobStoreTX or JobStoreCMT**

Enable clustering by setting the "org.quartz.jobStore.isClustered" property to "true". Each instance in the
cluster should use the same copy of the quartz.properties file. Exceptions of this would be to use properties files that
are identical, with the following allowable exceptions: Different thread pool size, and different value for the
"org.quartz.scheduler.instanceId" property. Each node in the cluster MUST have a unique instanceId, which is easily done
(without needing different properties files) by placing "AUTO" as the value of this property.

<blockquote>
        Never run clustering on separate machines, unless their clocks are synchronized using some form of
        time-sync service (daemon) that runs very regularly (the clocks must be within a second of each other). See <a
            href="http://www.boulder.nist.gov/timefreq/service/its.htm" target="external">http://www.boulder.nist.gov/timefreq/service/its.htm</a>
        if you are unfamiliar with how to do this.
</blockquote>
<blockquote>
        Never fire-up a non-clustered instance against the same set of tables that any other instance is running
        against. You may get serious data corruption, and will definitely experience erratic behavior.
</blockquote>

Only one node will fire the job for each firing.   What I mean by that is, if the job has a repeating trigger that 
tells it to fire every 10 seconds, then at 12:00:00 exactly one node will run the job, and at 12:00:10 exactly one 
node will run the job, etc.    It won't necessarily be the same node each time - it will more or less be random which 
node runs it.  The load balancing mechanism is near-random for busy schedulers (lots of triggers) but favors the
same node that just was just active for non-busy (e.g. one or two triggers) schedulers.

**Clustering With TerracottaJobStore**

Simply configure the scheduler to use TerracottaJobStore (covered in 
<a href="/documentation/quartz-1.x/tutorials/TutorialLesson09" title="Tutorial Lesson 9">Lesson 9: JobStores</a>), and your scheduler will be all
set for clustering.

You may also want to consider implications of how you setup your Terracotta server, particularly configuration 
options that turn on features such as storing data on disk, utilization of fsync, and running an array of Terracotta
servers for HA.

More information about this JobStore and Terracotta can be found at 
<a href="http://www.terracotta.org/quartz">http://www.terracotta.org/quartz</a>


### JTA Transactions {#TutorialLesson11-JTATransactions}

As explained in <a href="/documentation/quartz-1.x/tutorials/TutorialLesson09" title="Tutorial Lesson 9">Lesson 9: JobStores</a>, JobStoreCMT
allows Quartz scheduling operations to be performed within larger JTA transactions.

Jobs can also execute within a JTA transaction (UserTransaction) by setting the
"org.quartz.scheduler.wrapJobExecutionInUserTransaction" property to "true". With this option set, a a JTA transaction
will begin() just before the Job's execute method is called, and commit() just after the call to execute terminates.

Aside from Quartz automatically wrapping Job executions in JTA transactions, calls you make on the Scheduler
interface also participate in transactions when using JobStoreCMT. Just make sure you've started a transaction before
calling a method on the scheduler. You can do this either directly, through the use of UserTransaction, or by putting
your code that uses the scheduler within a SessionBean that uses container managed transactions.




