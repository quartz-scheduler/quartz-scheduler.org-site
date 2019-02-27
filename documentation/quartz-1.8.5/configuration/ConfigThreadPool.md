<div class="secNavPanel"><a href=".">Contents</a> | <a href="ConfigMain">&lsaquo;&nbsp;Prev</a> | <a href="ConfigListeners">Next&nbsp;&rsaquo;</a></div>





# Quartz Enterprise Job Scheduler 1.x Configuration Reference

## Configure ThreadPool Settings


<table><thead>
<tr>
<th>Property Name</th>
<th>Required</th>
<th>Type</th>
<th>Default Value</th>
</tr>
</thead>
<tbody>
<tr>
<td>org.quartz.threadPool.class</td>
<td>yes</td>

<td>string (clas name)</td>
<td>null</td>
</tr>
<tr>
<td>org.quartz.threadPool.threadCount</td>
<td>yes</td>
<td>int</td>
<td>-1</td>
</tr>
<tr>

<td>org.quartz.threadPool.threadPriority</td>
<td>no</td>
<td>int</td>
<td>Thread.NORM_PRIORITY (5)</td>
</tr>
</tbody></table>

**org.quartz.threadPool.class**

Is the name of the ThreadPool implementation you wish to use.  The threadpool that ships with Quartz is "org.quartz.simpl.SimpleThreadPool", and should meet the needs of nearly every user.  It has very simple behavior and is very well tested.  It provides a fixed-size pool of threads that 'live' the lifetime of the Scheduler.

**org.quartz.threadPool.threadCount**

Can be any positive integer, although you should realize that only numbers between 1 and 100 are very practical.  This is the number of threads that are available for concurrent execution of jobs.  If you only have a few jobs that fire a few times a day, then 1 thread is plenty! If you have tens of thousands of jobs, with many firing every minute, then you probably want a thread count more like 50 or 100 (this highly depends on the nature of the work that your jobs perform, and your systems resources!).

**org.quartz.threadPool.threadPriority**

Can be any int between *Thread.MIN_PRIORITY* (which is 1) and *Thread.MAX_PRIORITY* (which is 10).  The default is *Thread.NORM_PRIORITY* (5).




### SimpleThreadPool-Specific Properties {#ConfigThreadPool-SimpleThreadPoolSpecificProperties}


<table><thead>
<tr>
<th>Property Name</th>
<th>Required</th>
<th>Type</th>
<th>Default Value</th>
</tr>
</thead>
<tbody>
<tr>
<td>org.quartz.threadPool.makeThreadsDaemons</td>
<td>no</td>
<td>boolean</td>
<td>false</td>
</tr>
<tr>
<td>org.quartz.threadPool.threadsInheritGroupOfInitializingThread</td>
<td>no</td>
<td>boolean</td>

<td>true</td>
</tr>
<tr>
<td>org.quartz.threadPool.threadsInheritContextClassLoaderOfInitializingThread</td>
<td>no</td>
<td>boolean</td>
<td>false</td>
</tr>
</tbody></table>

**org.quartz.threadPool.makeThreadsDaemons**

Can be set to "true" to have the threads in the pool created as daemon threads.  Default is "false".  See also the *<a href="ConfigMain" title="ConfigMain">org.quartz.scheduler.makeSchedulerThreadDaemon</a>* property.

**org.quartz.threadPool.threadsInheritGroupOfInitializingThread**

Can be "true" or "false", and defaults to true.

**org.quartz.threadPool.threadsInheritContextClassLoaderOfInitializingThread**

Can be "true" or "false", and defaults to false.




### Custom ThreadPools {#ConfigThreadPool-CustomThreadPools}



If you use your own implementation of a thread pool, you can have properties set on it reflectively simply by naming the property as thus:

**Setting Properties on a Custom ThreadPool**

<pre>
org.quartz.threadPool.class = com.mycompany.goo.FooThreadPool
org.quartz.threadPool.somePropOfFooThreadPool = someValue
</pre>






