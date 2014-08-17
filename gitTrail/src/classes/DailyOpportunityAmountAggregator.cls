global class DailyOpportunityAmountAggregator implements Database.Batchable<sObject>, Database.Stateful {
	global static double smamt=0;
	global static integer numbatch=0;
    global Double sumAmt;
   	global integer numberOfBatches;
   	//constructor
   	global DailyOpportunityAmountAggregator(){
   		sumAmt=0;
   		numberOfBatches=0;
   	}
    
    //start     
    global Database.Querylocator start(Database.BatchableContext context ){
     	String queryStr='Select Amount, CreatedDate From Opportunity Where StageName = \'Closed Won\' AND CreatedDate = today';
     	system.debug('*****************'+Database.getQueryLocator(queryStr));
        return Database.getQueryLocator(queryStr);
    }

	//execute
	global void execute(Database.BatchableContext context, List<Opportunity> oppList){
	     
	     //sum the amount and set IsAggregated flag to true 
	     List<Opportunity> opporList = new List<Opportunity>();
	     
	     for(Opportunity opportunity : oppList){
	     	
	     	  sumAmt = sumAmt + opportunity.Amount;
	     	  opportunity.IsAggregrated__c = true;
	     	  opporList.add(opportunity);	     	
	     } 
	     numberOfBatches++;
	     system.debug('*************sumAmt**********'+sumAmt);	 
	     
		 update opporList;
	}
	
	//finish
    global void finish(Database.BatchableContext context){
       smamt = sumAmt;
       numbatch = numberOfBatches;
       //mail notification
       AsyncApexJob job = [Select Id, Status, CompletedDate, TotalJobItems
                           From AsyncApexJob Where Id = :context.getJobId()];	
                           
       if(job.Status == 'Completed'){
       	 //email       	 
         Messaging.Singleemailmessage draftMail = new Messaging.Singleemailmessage();
       	 
       	 List<String> emailList = new List<String>{'needhi23@gmail.com'};
       	 draftMail.setToAddresses(emailList);
       	 draftMail.setSubject('Daily Opportunity Amount Aggregator Job Complete');
       	 draftMail.setPlainTextBody('The batch job for Daily Opportunity Amount Aggregation is completed successfully.'+
       	                            'The details associated with the job are as follows:\n\n'+
       	                            'Start DateTime:'+ '' + '\n'+
       	                            'End DateTime: '+ job.CompletedDate +'\n'+
       	                            'Total Duration (in Hours) : '+ '\n'+
       	                            'Number of Opportunities Closed Won Today : '+ job.TotalJobItems+'\n'+
       	                            'Total Opportunity Amount for today :' + sumAmt);
         Messaging.sendEmail(new Messaging.SingleEmailMessage[] { draftMail });
       
       }
    }

}