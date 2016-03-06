<div class="secNavPanel"><a href=".">Contents</a> | <a href="ConfigJobStoreCMT">&lsaquo;&nbsp;Prev</a> | <a href="ConfigJDBCJobStoreClustering">Next&nbsp;&rsaquo;</a></div>





# Quartz Enterprise Job Scheduler 1.x Configuration Reference

## Configure DataSources


If you're using JDBC-Jobstore, you'll be needing a DataSource for its use (or two DataSources, if you're using JobStoreCMT). 

DataSources can be configured in three ways:

+ All pool properties specified in the quartz.properties file, so that Quartz can create the DataSource itself.
+ The JNDI location of an application server managed Datasource can be specified, so that Quartz can use it.
+ Custom defined *org.quartz.utils.ConnectionProvider* implementations.

It is recommended that your Datasource max connection size be configured to be at least the number of worker threads in the thread pool plus three.
You may need additional connections if your application is also making frequent calls to the scheduler API.  If you are using JobStoreCMT,
the "non managed" datasource should have a max connection size of at least four.

Each DataSource you define (typically one or two) must be given a name, and the properties you define for each must contain that name, as shown below.  The DataSource's "NAME" can be anything you want, and has no meaning other  than being able to identify it when it is assigned to the JDBCJobStore.





### Quartz-created DataSources are defined with the following properties:


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
<td>org.quartz.dataSource.NAME.driver</td>
<td>yes</td>
<td>String</td>
<td>null</td>
</tr>

<tr>
<td>org.quartz.dataSource.NAME.URL</td>
<td>yes</td>
<td>String</td>
<td>null</td>
</tr>
<tr>
<td>org.quartz.dataSource.NAME.user</td>
<td>no</td>
<td>String</td>

<td>""</td>
</tr>
<tr>
<td>org.quartz.dataSource.NAME.password</td>
<td>no</td>
<td>String</td>
<td>""</td>
</tr>
<tr>
<td>org.quartz.dataSource.NAME.maxConnections</td>

<td>no</td>
<td>int</td>
<td>10</td>
</tr>
<tr>
<td>org.quartz.dataSource.NAME.validationQuery</td>
<td>no</td>
<td>String</td>
<td>null</td>
</tr>

</tbody></table>


**org.quartz.dataSource.NAME.driver** 

Must be the java class name of the JDBC driver for your database.

**org.quartz.dataSource.NAME.URL**

The connection URL (host, port, etc.) for connection to your database.

**org.quartz.dataSource.NAME.user**

The user name to use when connecting to your database.

**org.quartz.dataSource.NAME.password**

The password to use when connecting to your database.

**org.quartz.dataSource.NAME.maxConnections**

The maximum number of connections that the DataSource can create in it's pool of connections.

**org.quartz.dataSource.NAME.validationQuery**

Is an optional SQL query string that the DataSource can use to detect and replace failed/corrupt connections.  For example an oracle user might choose "select table_name from user_tables" - which is a  query that should never fail - unless the connection is actually bad. 

**Example of a Quartz-defined DataSource**

<pre>
org.quartz.dataSource.myDS.driver = oracle.jdbc.driver.OracleDriver
org.quartz.dataSource.myDS.URL = jdbc:oracle:thin:@10.0.1.23:1521:demodb
org.quartz.dataSource.myDS.user = myUser
org.quartz.dataSource.myDS.password = myPassword
org.quartz.dataSource.myDS.maxConnections = 30
</pre>


### References to Application Server DataSources are defined with the following properties:


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
<td>org.quartz.dataSource.NAME.jndiURL</td>
<td>yes</td>
<td>String</td>
<td>null</td>
</tr>
<tr>
<td>org.quartz.dataSource.NAME.java.naming.factory.initial</td>
<td>no</td>

<td>String</td>
<td>null</td>
</tr>
<tr>
<td>org.quartz.dataSource.NAME.java.naming.provider.url</td>
<td>no</td>
<td>String</td>
<td>null</td>
</tr>
<tr>
<td>org.quartz.dataSource.NAME.java.naming.security.principal</td>

<td>no</td>
<td>String</td>
<td>null</td>
</tr>
<tr>
<td>org.quartz.dataSource.NAME.java.naming.security.credentials</td>
<td>no</td>
<td>String</td>
<td>null</td>
</tr>

</tbody></table>


**org.quartz.dataSource.NAME.jndiURL** 

The JNDI URL for a DataSource that is managed by your application server. 

**org.quartz.dataSource.NAME.java.naming.factory.initial** 

The (optional) class name of the  JNDI InitialContextFactory that you wish to use.

**org.quartz.dataSource.NAME.java.naming.provider.url** 


The (optional) URL for connecting to the JNDI context.

**org.quartz.dataSource.NAME.java.naming.security.principal** 

The (optional) user principal for connecting to the JNDI context.

**org.quartz.dataSource.NAME.java.naming.security.credentials** 

The (optional) user credentials for connecting to the JNDI context.

**Example of a Datasource referenced from an Application Server**

<pre>
org.quartz.dataSource.myOtherDS.jndiURL=jdbc/myDataSource
org.quartz.dataSource.myOtherDS.java.naming.factory.initial=com.evermind.server.rmi.RMIInitialContextFactory
org.quartz.dataSource.myOtherDS.java.naming.provider.url=ormi:<span class="code-comment">//localhost
</span>org.quartz.dataSource.myOtherDS.java.naming.security.principal=admin
org.quartz.dataSource.myOtherDS.java.naming.security.credentials=123
</pre>





### Custom ConnectionProvider Implementations {#ConfigDataSources-CustomConnectionProviderImplementations}


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
<td>org.quartz.dataSource.NAME.connectionProvider.class</td>
<td>yes</td>
<td>String (class name)</td>
<td>null</td>
</tr>
</tbody></table>

**org.quartz.dataSource.NAME.connectionProvider.class** 

The class name of the ConnectionProvider to use.  After instantiating the class, Quartz can automatically set configuration properties on the instance, bean-style.

**Example of Using a Custom ConnectionProvider Implementation**

<pre>
org.quartz.dataSource.myCustomDS.connectionProvider.class = com.foo.FooConnectionProvider
org.quartz.dataSource.myCustomDS.someStringProperty = someValue
org.quartz.dataSource.myCustomDS.someIntProperty = 5
</pre>





