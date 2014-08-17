public with sharing class CloningLead {

    //Constructor
    public CloningLead(){}

    public List<Lead> cloningSameLead(List<Lead> lead){
    
      List<Lead> leadList = new List<Lead>();
     
      	
      for(Lead l : lead){      	
      
      	if((l.Status).equals('Open - Not Contacted')){
      	
      		system.debug('***********************inside if***************'+l.Status);
            
            Lead leadObject = new Lead();     	
      		leadObject = (Lead)leadObject.clone(false, true, false, false);//new Lead();
      		
      		leadObject.FirstName = l.FirstName;
      		leadObject.LastName = l.LastName;
      		leadObject.Status = 'Working - Contacted';
      		leadObject.Company = l.Company;
      		leadObject.City = l.City;
      		      		
      		leadList.add(leadObject);
      		system.debug('****************************************leadList****'+leadList);
      	}
      
      }//for ends
     	
      return leadList;
    }

}