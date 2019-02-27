<div class="secNavPanel"><a href=".">Contents</a> | <a href="ConfigJobStoreTX">&lsaquo;&nbsp;Prev</a> | <a href="ConfigDataSources">Next&nbsp;&rsaquo;</a></div>





# Quartz Enterprise Job Scheduler 1.x Configuration Reference

## Configure JDBC-JobStoreCMT


JDBCJobStore is used to store scheduling information (job, triggers and calendars) within a relational database.  There are actually two seperate JDBCJobStore classes that you can select between, depending on the transactional behaviour you need.  

JobStoreCMT relies upon transactions being managed by the application which is using Quartz.  A JTA transaction must be in progress before attempt to schedule (or unschedule) jobs/triggers.  This allows the "work" of scheduling to be part of the applications "larger" transaction.  JobStoreCMT actually requires the use of two datasources - one that has it's connection's transactions managed by the application server (via JTA) and one datasource that has connections that do not participate in global (JTA) transactions.   JobStoreCMT is appropriate when applications are using JTA transactions (such as via EJB Session Beans) to perform their work.




**The JobStore is selected by setting the 'org.quartz.jobStore.class' property as such:**

**Setting The Scheduler's JobStore to JobStoreCMT**

<pre>
org.quartz.jobStore.class = org.quartz.impl.jdbcjobstore.JobStoreCMT
</pre>





JobStoreCMT can be tuned with the following properties:


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
<td>org.quartz.jobStore.driverDelegateClass</td>
<td>yes</td>
<td>string</td>
<td>null</td>
</tr>
<tr>
<td>org.quartz.jobStore.dataSource</td>
<td>yes</td>
<td>string</td>

<td>null</td>
</tr>
<tr>
<td>org.quartz.jobStore.nonManagedTXDataSource</td>
<td>yes</td>
<td>string</td>
<td>null</td>
</tr>
<tr>
<td>org.quartz.jobStore.tablePrefix</td>
<td>no</td>

<td>string</td>
<td>"QRTZ_"</td>
</tr>
<tr>
<td>org.quartz.jobStore.useProperties</td>
<td>no</td>
<td>boolean</td>
<td>false</td>
</tr>
<tr>
<td>org.quartz.jobStore.misfireThreshold</td>

<td>no</td>
<td>int</td>
<td>60000</td>
</tr>
<tr>
<td>org.quartz.jobStore.isClustered</td>
<td>no</td>
<td>boolean</td>
<td>false</td>
</tr>

<tr>
<td>org.quartz.jobStore.clusterCheckinInterval</td>
<td>no</td>
<td>long</td>
<td>15000</td>
</tr>
<tr>
<td>org.quartz.jobStore.maxMisfiresToHandleAtATime</td>
<td>no</td>
<td>int</td>

<td>20</td>
</tr>
<tr>
<td>org.quartz.jobStore.dontSetAutoCommitFalse</td>
<td>no</td>
<td>boolean</td>
<td>false</td>
</tr>
<tr>
<td>org.quartz.jobStore.dontSetNonManagedTXConnectionAutoCommitFalse</td>

<td>no</td>
<td>boolean</td>
<td>false</td>
</tr>
<tr>
<td>org.quartz.jobStore.selectWithLockSQL</td>
<td>no</td>
<td>string</td>
<td>"SELECT * FROM {0}LOCKS WHERE LOCK_NAME = ? FOR UPDATE"</td>
</tr>

<tr>
<td>org.quartz.jobStore.txIsolationLevelSerializable</td>
<td>no</td>
<td>boolean</td>
<td>false</td>
</tr>
<tr>
<td>org.quartz.jobStore.txIsolationLevelReadCommitted</td>
<td>no</td>
<td>boolean</td>

<td>false</td>
</tr>
<tr>
<td>org.quartz.jobStore.acquireTriggersWithinLock</td>
<td>no</td>
<td>boolean</td>
<td>false</td>
</tr>
<tr>
<td>org.quartz.jobStore.lockHandler.class</td>
<td>no</td>

<td>string</td>
<td>null</td>
</tr>
</tbody></table>


**org.quartz.jobStore.driverDelegateClass** 

Driver delegates understand the particular 'dialects' of varies database systems.  Possible choices include:

+ org.quartz.impl.jdbcjobstore.StdJDBCDelegate (for fully JDBC-compliant drivers)
+ org.quartz.impl.jdbcjobstore.MSSQLDelegate (for Microsoft SQL Server, and Sybase)
+ org.quartz.impl.jdbcjobstore.PostgreSQLDelegate
+ org.quartz.impl.jdbcjobstore.WebLogicDelegate (for WebLogic drivers)
+ org.quartz.impl.jdbcjobstore.oracle.OracleDelegate
+ org.quartz.impl.jdbcjobstore.oracle.weblogic.WebLogicOracleDelegate (for Oracle drivers used within Weblogic)
+ org.quartz.impl.jdbcjobstore.CloudscapeDelegate
+ org.quartz.impl.jdbcjobstore.DB2v6Delegate
+ org.quartz.impl.jdbcjobstore.DB2v7Delegate
+ org.quartz.impl.jdbcjobstore.HSQLDBDelegate
+ org.quartz.impl.jdbcjobstore.PointbaseDelegate


Note that many databases are known to work with the StdJDBCDelegate, while others are known to work with delegates for other databases, for example Derby works well with the Cloudscape delegate (no surprise there).


**org.quartz.jobStore.dataSource**

The value of this property must be the name of one the DataSources defined in the configuration properties file.  For JobStoreCMT, it is required that this DataSource contains connections that are capable of participating in JTA (e.g. container-managed) transactions.  This typically means that the DataSource will be configured and maintained within and by the application server, and Quartz will obtain a handle to it via JNDI.  See the <a href="ConfigDataSources" title="ConfigDataSources">configuration docs for DataSources</a> for more information.

**org.quartz.jobStore.nonManagedTXDataSource**

JobStoreCMT *requires* a (second) datasource that contains connections that will *not* be part of container-managed transactions.  The value of this property must be the name of one the DataSources defined in the configuration properties file.  This datasource must contain non-CMT connections, or in other words, connections for which it is legal for Quartz to directly call commit() and rollback() on.

**org.quartz.jobStore.tablePrefix**

JDBCJobStore's "table prefix" property is a string equal to the prefix given to Quartz's tables that were created in your database.  You can have multiple sets of Quartz's tables within the same database if they use different table prefixes.

**org.quartz.jobStore.useProperties** 

The "use properties" flag instructs JDBCJobStore that all values in JobDataMaps will be Strings, and therefore can be stored as name-value pairs, rather than storing more complex objects in their serialized form in the BLOB column.  This is can be handy, as you avoid the class versioning issues that can arise from serializing your non-String classes into a BLOB.

**org.quartz.jobStore.misfireThreshold** 

The the number of milliseconds the scheduler will 'tolerate' a trigger to pass its next-fire-time by, before being considered "misfired".  The default value (if you don't make an entry of this property in your configuration) is 60000 (60 seconds).

**org.quartz.jobStore.isClustered**

Set to "true" in order to turn on clustering features. This property must be set to "true" if you are having multiple instances of Quartz use the same set of database tables... otherwise you will experience havoc.  See the configuration docs for clustering for more information.

**org.quartz.jobStore.clusterCheckinInterval**

Set the frequency (in milliseconds) at which this instance "checks-in"* with the other instances of the cluster. Affects the quickness of detecting failed instances.

**org.quartz.jobStore.maxMisfiresToHandleAtATime**

The maximum number of misfired triggers the jobstore will handle in a given pass.  Handling many (more than a couple dozen) at once can cause the database tables to be locked long enough that the performance of firing other (not yet misfired) triggers may be hampered.

**org.quartz.jobStore.dontSetAutoCommitFalse**

Setting this parameter to "true" tells Quartz not to call *setAutoCommit(false)* on connections obtained from the DataSource(s).  This can be helpful in a few situations, such as if you have a driver that complains if it is called when it is already off.  This property defaults to false, because most drivers require that *setAutoCommit(false)* is called.

**org.quartz.jobStore.dontSetNonManagedTXConnectionAutoCommitFalse**

The same as the property *org.quartz.jobStore.dontSetAutoCommitFalse*, except that it applies to the nonManagedTXDataSource.

**org.quartz.jobStore.selectWithLockSQL**

Must be a SQL string that selects a row in the "LOCKS" table and places a lock on the row. If not set, the default is *"SELECT * FROM {0}LOCKS WHERE LOCK_NAME = ? FOR UPDATE"*,  which works for most databases.  The "{0}" is replaced during run-time with the TABLE_PREFIX that you configured above.

**org.quartz.jobStore.txIsolationLevelSerializable**

A value of "true" tells Quartz to call *setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE)* on JDBC connections.  This can be helpful to prevent lock timeouts with some databases under high load, and "long-lasting" transactions.

**org.quartz.jobStore.txIsolationLevelReadCommitted**

When set to "true", this property tells Quartz to call *setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED)* on the non-managed JDBC connections.  This can be helpful to prevent lock timeouts with some databases (such as DB2) under high load, and "long-lasting" transactions.

**org.quartz.jobStore.acquireTriggersWithinLock**

Whether or not the acquisition of next triggers to fire should occur within an explicit database lock.  This was once necessary (in previous versions of Quartz) to avoid dead-locks with particular databases, but is no longer considered necessary, hence the default value is "false".

**org.quartz.jobStore.lockHandler.class** 

The class name to be used to produce an instance of a org.quartz.impl.jdbcjobstore.Semaphore to be used for locking control on the job store data.  This is an advanced configuration feature, which should not be used by most users.  By default, Quartz will select the most appropriate (pre-bundled) Semaphore implementation to use.  "org.quartz.impl.jdbcjobstore.UpdateLockRowSemaphore" <a href="http://jira.opensymphony.com/browse/QUARTZ-497" target="external">QUARTZ-497</a> may be of interest to MS SQL Server users.  "JTANonClusteredSemaphore" which is bundled with Quartz may give improved performance when using JobStoreCMT, though it is an experimental implementation.  See <a href="http://jira.opensymphony.com/browse/QUARTZ-441" target="external">QUARTZ-441</a> and <a href="http://jira.opensymphony.com/browse/QUARTZ-442" target="external">QUARTZ-442</a>




