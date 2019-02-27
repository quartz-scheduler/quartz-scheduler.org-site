<div class="secNavPanel"><a href=".">Contents</a> | <a href="MultipleSchedulers">&lsaquo;&nbsp;Prev</a> | <a href="ScheduleJob">Next&nbsp;&rsaquo;</a></div>





# How-To: Defining a Job (with input data)


### A Job Class

<pre>

public class PrintPropsJob implements Job {

	public PrintPropsJob() {
		// Instances of Job must have a public no-argument constructor.
	}

	public void execute(JobExecutionContext context)
			throws JobExecutionException {

		JobDataMap data = context.getJobDetail().getJobDataMap();
		System.out.println("someProp = " + data.getString("someProp"));
	}

}

</pre>

### Defining a Job Instance

<pre>

// Define job instance
JobDetail job = new JobDetail("job1", "group1", MyJobClass.class);
job.getDataMap().put("someProp", "someValue");

</pre>





