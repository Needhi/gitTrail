public with sharing class testing {

   public testing(){
     DailyOpportunityAmountAggregator o = new DailyOpportunityAmountAggregator();
     ID id = Database.executeBatch(o);
     system.debug('***************id************'+id);      
   }

}