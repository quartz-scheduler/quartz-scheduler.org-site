---
title: Configuration Reference
visible_title: "Quartz Configuration Reference"
active_sub_menu_id: site_mnu_docs_configuration
---
<div class="secNavPanel">
          <a href="index.html">Contents.html</a> |
          <a href="ConfigThreadPool.html">ConfigThreadPool&nbsp;&rsaquo;</a>
</div>

# Configuration Reference

## Configure Main Scheduler Settings

These properties configure the identification of the scheduler, and various other 'top level' settings.

<table>
  <thead>
        <tr>
            <th>Property Name</th>
            <th>Req'd</th>
            <th>Type</th>
            <th>Default Value</th>
        </tr>
  </thead>
  <tbody>
        <tr>
            <td>org.quartz.scheduler.instanceName</td>

            <td>no</td>
            <td>string</td>
            <td>'QuartzScheduler'</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler.instanceId</td>
            <td>no</td>
            <td>string</td>
            <td>'NON_CLUSTERED'</td>
        </tr>

        <tr>
            <td>org.quartz.scheduler.instanceIdGenerator.class</td>
            <td>no</td>
            <td>string (class name)</td>
            <td>org.quartz.simpl<br>.SimpleInstanceIdGenerator</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler.threadName</td>
            <td>no</td>
            <td>string</td>

            <td>instanceName<br> + '_QuartzSchedulerThread'</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler<br>.makeSchedulerThreadDaemon</td>
            <td>no</td>
            <td>boolean</td>
            <td>false</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler<br>
	    .threadsInheritContextClassLoaderOfInitializer</td>
            <td>no</td>

            <td>boolean</td>
            <td>false</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler.idleWaitTime</td>
            <td>no</td>
            <td>long</td>
            <td>30000</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler.dbFailureRetryInterval</td>

            <td>no</td>
            <td>long</td>
            <td>15000</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler.classLoadHelper.class</td>
            <td>no</td>
            <td>string (class name)</td>
            <td>org.quartz.simpl<br>.CascadingClassLoadHelper</td>
        </tr>

        <tr>
            <td>org.quartz.scheduler.jobFactory.class</td>
            <td>no</td>

            <td>string (class name)</td>
            <td>org.quartz.simpl.PropertySettingJobFactory</td>
        </tr>
        <tr>
            <td>org.quartz.context.key.SOME_KEY</td>
            <td>no</td>
            <td>string</td>
            <td>none</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler.userTransactionURL</td>
            <td>no</td>
            <td>string (url)</td>

            <td>'java:comp/UserTransaction'</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler<br>.wrapJobExecutionInUserTransaction</td>
            <td>no</td>
            <td>boolean</td>
            <td>false</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler.skipUpdateCheck</td>
            <td>no</td>
            <td>boolean</td>
            <td>false</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler<br>.batchTriggerAcquisitionMaxCount</td>
            <td>no</td>
            <td>int</td>
            <td>1</td>
        </tr>
        <tr>
            <td>org.quartz.scheduler<br>.batchTriggerAcquisitionFireAheadTimeWindow</td>
            <td>no</td>
            <td>long</td>
            <td>0</td>
        </tr>
    </tbody>
</table>

**org.quartz.scheduler.instanceName**

Can be any string, and the value has no meaning to the scheduler itself - but rather serves as a mechanism for client
code to distinguish schedulers when multiple instances are used within the same program. If you are using the clustering
features, you must use the same name for every instance in the cluster that is 'logically' the same Scheduler.

**org.quartz.scheduler.instanceId**

Can be any string, but must be unique for all schedulers working as if they are the same 'logical' Scheduler within a
cluster. You may use the value "AUTO" as the instanceId if you wish the Id to be generated for you.  Or the value
"SYS_PROP" if you want the value to come from the system property "org.quartz.scheduler.instanceId".

**org.quartz.scheduler.instanceIdGenerator.class**

Only used if *org.quartz.scheduler.instanceId* is set to "AUTO". Defaults to
"org.quartz.simpl.SimpleInstanceIdGenerator", which generates an instance id based upon host name and time stamp.
Other IntanceIdGenerator implementations include SystemPropertyInstanceIdGenerator (which gets the instance id
from the system property "org.quartz.scheduler.instanceId", and HostnameInstanceIdGenerator which uses the
local host name (InetAddress.getLocalHost().getHostName()).  You can also implement the InstanceIdGenerator
interface your self.

**org.quartz.scheduler.threadName**

Can be any String that is a valid name for a java thread. If this property is not specified, the thread will receive the
scheduler's name ("org.quartz.scheduler.instanceName") plus an the appended string '_QuartzSchedulerThread'.

**org.quartz.scheduler.makeSchedulerThreadDaemon**


A boolean value ('true' or 'false') that specifies whether the main thread of the scheduler should be a daemon thread or
not. See also the *org.quartz.scheduler.makeSchedulerThreadDaemon* property for tuning the <a
    href="ConfigThreadPool.html" title="ConfigThreadPool">SimpleThreadPool</a> if that is the thread pool implementation
you are using (which is most likely the case).

**org.quartz.scheduler.threadsInheritContextClassLoaderOfInitializer**

A boolean value ('true' or 'false') that specifies whether the threads spawned by Quartz will inherit the context
ClassLoader of the initializing thread (thread that initializes the Quartz instance). This will affect Quartz main
scheduling thread, JDBCJobStore's misfire handling thread (if JDBCJobStore is used), cluster recovery thread (if
clustering is used), and threads in SimpleThreadPool (if SimpleThreadPool is used). Setting this value to 'true' may
help with class loading, JNDI look-ups, and other issues related to using Quartz within an application server.

**org.quartz.scheduler.idleWaitTime**


Is the amount of time in milliseconds that the scheduler will wait before re-queries for available triggers when the
scheduler is otherwise idle. Normally you should not have to 'tune' this parameter, unless you're using XA transactions,
and are having problems with delayed firings of triggers that should fire immediately.  Values less than 5000 ms are not
recommended as it will cause excessive database querying. Values less than 1000 are not legal.

**org.quartz.scheduler.dbFailureRetryInterval**

Is the amount of time in milliseconds that the scheduler will wait between re-tries when it has detected a loss of
connectivity within the JobStore (e.g. to the database). This parameter is obviously not very meaningful when using
RamJobStore.

**org.quartz.scheduler.classLoadHelper.class**

Defaults to the most robust approach, which is to use the "org.quartz.simpl.CascadingClassLoadHelper" class - which in
turn uses every other ClassLoadHelper class until one works. You should probably not find the need to specify any other
class for this property, though strange things seem to happen within application servers. All of the current possible
ClassLoadHelper implementation can be found in the *org.quartz.simpl* package.

**org.quartz.scheduler.jobFactory.class**

The class name of the JobFactory to use. A JobFatcory is responsible for producing instances of JobClasses.
The default is 'org.quartz.simpl.PropertySettingJobFactory', which simply calls newInstance() on the class to produce
a new instance each time execution is about to occur. PropertySettingJobFactory also reflectively
sets the job's bean properties using the contents of the SchedulerContext and Job and Trigger JobDataMaps.

**org.quartz.context.key.SOME_KEY**

Represent a name-value pair that will be placed into the "scheduler context" as strings. (see Scheduler.getContext()).
So for example, the setting "org.quartz.context.key.MyKey = MyValue" would perform the equivalent of
scheduler.getContext().put("MyKey", "MyValue").
<blockquote>
The Transaction-Related properties should be left out of the config file unless you are using JTA transactions.
</blockquote>

**org.quartz.scheduler.userTransactionURL**

Should be set to the JNDI URL at which Quartz can locate the Application Server's UserTransaction manager. The default
value (if not specified) is "java:comp/UserTransaction" - which works for almost all Application Servers. Websphere
users may need to set this property to "jta/usertransaction". This is only used if Quartz is configured to use
JobStoreCMT, and *org.quartz.scheduler.wrapJobExecutionInUserTransaction* is set to true.

**org.quartz.scheduler.wrapJobExecutionInUserTransaction**

Should be set to "true" if you want Quartz to start a UserTransaction before calling execute on your job. The Tx will
commit after the job's execute method completes, and after the JobDataMap is updated (if it is a StatefulJob). The
default value is "false".  You may also be interested in using the *@ExecuteInJTATransaction* annotation
on your job class, which lets you control for an individual job whether Quartz should start a JTA transaction -
whereas this property causes it to occur for all jobs.

**org.quartz.scheduler.skipUpdateCheck**

Whether or not to skip running a quick web request to determine if there is an updated version of Quartz available for
download.  If the check runs, and an update is found, it will be reported as available in Quartz's logs.  You
can also disable the update check with the system property "org.terracotta.quartz.skipUpdateCheck=true" (which
you can set in your system environment or as a -D on the java command line).  It is recommended that you disable
the update check for production deployments.

**org.quartz.scheduler.batchTriggerAcquisitionMaxCount**

The maximum number of triggers that a scheduler node is allowed to acquire (for firing) at once.  Default value
is 1.  The larger the number, the more efficient firing is (in situations where there are very many triggers needing to
be fired all at once) - but at the cost of possible imbalanced load between cluster nodes.  If the value of this
property is set to > 1, and JDBC JobStore is used, then the property "org.quartz.jobStore.acquireTriggersWithinLock"
must be set to "true" to avoid data corruption.

**org.quartz.scheduler.batchTriggerAcquisitionFireAheadTimeWindow**

The amount of time in milliseconds that a trigger is allowed to be acquired and fired ahead of its scheduled fire time.   
Defaults to 0.  The larger the number, the more likely batch acquisition of triggers to fire will be able to select
and fire more than 1 trigger at a time - at the cost of trigger schedule not being honored precisely (triggers may
fire this amount early).  This may be useful (for performance's sake) in situations where the scheduler has very large
numbers of triggers that need to be fired at or near the same time.
