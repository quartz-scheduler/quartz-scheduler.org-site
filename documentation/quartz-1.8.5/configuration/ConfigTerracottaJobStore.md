<div class="secNavPanel"><a href=".">Contents</a> | <a href="ConfigJDBCJobStoreClustering">&lsaquo;&nbsp;Prev</a> </div>





# Quartz Enterprise Job Scheduler 1.x Configuration Reference

## Configure TerracottaJobStore


TerracottaJobStore is used to store scheduling information (job, triggers and calendars) within a Terracotta server.  
TerracottaJobStore is much more performant than utilizing a database for storing scheduling data (via JDBC-JobStore), 
and yet offers clustering features such as load-balancing and fail-over.

You may want to consider implications of how you setup your Terracotta server, particularly configuration 
options that turn on features such as storing data on disk, utilization of fsync, and running an array of Terracotta
servers for HA.

The clustering feature works best for scaling out long-running and/or cpu-intensive jobs (distributing the work-load 
over multiple nodes).  If you need to scale out to support thousands of short-running (e.g 1 second) jobs, consider 
partitioning the set of jobs by using multiple distinct schedulers. Using one scheduler currently forces the use of a 
cluster-wide lock, a pattern that degrades performance as you add more clients.

More information about this JobStore and Terracotta can be found at 
<a href="http://www.terracotta.org/quartz">http://www.terracotta.org/quartz</a>




TerracottaJobStore is selected by setting the 'org.quartz.jobStore.class' property as such:

**Setting The Scheduler's JobStore to TerracottaJobStore**

<pre>
org.quartz.jobStore.class = org.terracotta.quartz.TerracottaJobStore
</pre>





TerracottaJobStore can be tuned with the following properties:


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
<td>org.quartz.jobStore.tcConfigUrl</td>

<td>yes</td>
<td>string</td>
<td></td>
</tr>
<tr>
<td>org.quartz.jobStore.misfireThreshold</td>

<td>no</td>
<td>int</td>
<td>60000</td>
</tr>
</tbody></table>



**org.quartz.jobStore.tcConfigUrl**

The host and port identifying the location of the Terracotta server to connect to, such as "localhost:9510".

**org.quartz.jobStore.misfireThreshold**

The the number of milliseconds the scheduler will 'tolerate' a trigger to pass its next-fire-time by, before being considered "misfired".  The default value (if you don't make an entry of this property in your configuration) is 60000 (60 seconds).




