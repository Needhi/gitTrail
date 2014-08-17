global class DailyOppBatchScheduler implements Schedulable{

    public String cronStr = '0 45 6 ? * 2-6';
    //execute
    global void execute(SchedulableContext context){
    	
    	DailyOpportunityAmountAggregator batch = new DailyOpportunityAmountAggregator();
    	Database.executeBatch(batch); 	
    	
    } 

}