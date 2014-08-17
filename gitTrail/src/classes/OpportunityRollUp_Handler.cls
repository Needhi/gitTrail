public with sharing class OpportunityRollUp_Handler {

    //Constructor
    public OpportunityRollUp_Handler(){}
    OpportunityRollUp_Opp oppRollupAmt = new OpportunityRollUp_Opp();
    public List<Opportunity> oppRollUp(List<Opportunity> oppList){
    	
    	List<Opportunity> oppLst = oppRollupAmt.oppRollUpChild(oppList);
    	
    	return oppLst;
    }
    
    public List<Opportunity> oppRollUpDelete(List<Opportunity> oppList){
    	
    	
    	List<Opportunity> oppLst = oppRollupAmt.oppRollUpChildForDelete(oppList);
    	
    	return oppLst;
    }

}