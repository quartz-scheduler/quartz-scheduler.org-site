# Quartz Job Scheduler 1.x Configuration Reference

Configuration of Quartz is typically done through the use of a properties file, in conjunction with the use of
StdSchedulerFactory (which consumes the configuration file and instantiates a scheduler).


By default, StdSchedulerFactory load a properties file named "quartz.properties" from the 'current working directory'. 
If that fails, then the "quartz.properties" file located (as a resource) in the org/quartz package is loaded. If you 
wish to use a file other than these defaults, you must define the system property 'org.quartz.properties' to point to 
the file you want.

Alternatively, you can explicitly initialize the factory by calling one of the initialize(xx) methods before 
calling getScheduler() on the StdSchedulerFactory.

Instances of the specified JobStore, ThreadPool, and other SPI classes will be created by name, and then any 
additional properties specified for them in the config file will be set on the instance by calling an equivalent 'set' 
method. For example if the properties file contains the property 'org.quartz.jobStore.myProp = 10' then after the 
JobStore class has been instantiated, the method 'setMyProp()' will be called on it. Type conversion to primitive 
Java types (int, long, float, double, boolean, and String) are performed before calling the property's setter 
method. 

One property can reference another property's value by specifying a value following the convention of 
"$@other.property.name", for example, to reference the scheduler's instance name as the value for some other property, 
you would use "$@org.quartz.scheduler.instanceName".
 
The properties for configuring various aspect of a scheduler are described in these sub-documents:

## Choose a topic:

+ <a href="ConfigMain">Main Configuration</a> (configuration of primary scheduler settings,  transactions)
+ <a href="ConfigThreadPool">Configuration of ThreadPool</a> (tune resources for job execution)
+ <a href="ConfigListeners">Configuration of Listeners</a> (your application can receive notification of scheduled events)
+ <a href="ConfigPlugins">Configuration of Plug-Ins</a> (add functionality to your scheduler)
+ <a href="ConfigRMI">Configuration of RMI Server and Client</a> (use a Quartz instance from a remote process)
+ <a href="ConfigRAMJobStore">Configuration of RAMJobStore</a> (store jobs and triggers in memory)
+ <a href="ConfigJobStoreTX">Configuration of JDBC-JobStoreTX</a> (store jobs and triggers in a database via JDBC)
+ <a href="ConfigJobStoreCMT">Configuration of JDBC-JobStoreCMT</a> (JDBC with JTA container-managed transactions)
+ <a href="ConfigDataSources">Configuration of DataSources</a> (for use by the JDBC-JobStores)
+ <a href="ConfigJDBCJobStoreClustering">Configuration of Database Clustering</a> (achieve fail-over and load-balancing with JDBC-JobStore)
+ <a href="ConfigTerracottaJobStore">Configuration of TerracottaJobStore</a> (Clustering without a database!)
