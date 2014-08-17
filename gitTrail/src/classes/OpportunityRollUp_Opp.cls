public with sharing class OpportunityRollUp_Opp {

 //Constructor
    public OpportunityRollUp_Opp(){}
    
    public List<Opportunity> oppRollUpChild(List<Opportunity> oppList){
    	
    	List<Opportunity> opptoUpdatelist = new List<Opportunity>{};
    	
    	Set<ID> parentID = new Set<ID>{};
    	Set<ID> childID = new Set<ID>{};
    	Double sumAmount=0;
    	
        for(Opportunity oppObject : oppList){
        	if(oppObject.OppSelf__c != null){
        		childID.add(oppObject.Id);
        	}
        }
        system.debug('********************************childID******'+childID);
        for(Opportunity oppObject : [select OppSelf__c from Opportunity where Id IN:childID]){
            parentID.add(oppObject.OppSelf__c);
        }
        
        system.debug('********************************parentID******'+parentID);   
        for(Opportunity oppParentObj : [Select Id ,Expected_Revenue__c, Amount from Opportunity where Id IN : parentID]){
      
          for(Opportunity oppChildObj : [Select Id, Amount from Opportunity where OppSelf__c IN : parentID]){
   
                    sumAmount = sumAmount + oppChildObj.Amount;       
          }
          oppParentObj.Expected_Revenue__c = sumAmount + oppParentObj.Amount;
          system.debug('********************************oppParentObj.Expected_Revenue__c******'+oppParentObj.Expected_Revenue__c);   
          opptoUpdatelist.add(oppParentObj);
        }
    	
    	return opptoUpdatelist;
    }
    
    public List<Opportunity> oppRollUpChildForDelete(List<Opportunity> oppList){
    	
    	Set<Id> childId=new Set<Id> ();
    	Set<Id> parentId=new Set<id>();
    	List<Opportunity> opportunityList = new List<Opportunity>();
    	Double sumAmount=0;
    	
    	for(Opportunity opportunity : oppList){   
          if(opportunity.OppSelf__c != null){
             childId.add(opportunity.Id);
           }
    	} 
    	  
    	system.debug('********************************childID******'+childID);
    	
    	for(Opportunity opportunityPId : [select OppSelf__c from Opportunity where Id IN :childId]){
    	   system.debug('**********************opportunityPId******'+opportunityPId);
           parentId.add(opportunityPId.OppSelf__c);
        }
        
        system.debug('********************************parentID******'+parentID);  
        for(Opportunity opportunityparent : [Select Id,Expected_Revenue__c from Opportunity 
                                              where Id IN:parentId]){
   
           for(Opportunity opportunitychild : [Select Id,Amount from Opportunity where Id IN:childId]){
             if(opportunitychild.Amount!=null){
             	
                sumAmount += opportunitychild.Amount;          
             }   
           }//end of inner for loop
           system.debug('*********************sumAmount*****'+ sumAmount);
           opportunityparent.Expected_Revenue__c = opportunityparent.Expected_Revenue__c - sumAmount;
           opportunityList.add(opportunityparent);
        }//End of outer for loop
 
        return opportunityList;    	
    	
    }
}