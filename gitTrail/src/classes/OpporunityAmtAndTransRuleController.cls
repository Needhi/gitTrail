public with sharing class OpporunityAmtAndTransRuleController {

    public List<Opportunity> oppList {get; set;}
    public boolean section {get; set;}
     
    //contructor
    public OpporunityAmtAndTransRuleController(){

       oppList = [Select Name, Amount, AccountId, StageName, CloseDate 
                  From Opportunity
                  Where Amount >= 10000];
                  
       section=true;
       
    }
}