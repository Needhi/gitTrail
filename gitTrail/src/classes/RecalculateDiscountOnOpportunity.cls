public with sharing class RecalculateDiscountOnOpportunity {
  
    //constructor
    public RecalculateDiscountOnOpportunity(){}
    Double discountAmount;
    Opportunity__c discountPer;
    
    public void recalculateDiscountOnOpportunity(List<Opportunity> oppList){
  	
  	   Id profileId = UserInfo.getProfileId();
  	   List<Profile> profileObj = [Select Name From Profile Where Id= :profileId];
  	   String fullName = UserInfo.getFirstName()+' '+UserInfo.getLastName();
  	   
  	   for(Profile p :profileObj){
  	   	  system.debug('****************'+p.Name+ '****************UserInfo.getUserName()*******'+UserInfo.getFirstName() ); 
  	   	  
  	   	  if((p.Name).equals('System Administrator')){
  	   	  	
               if(fullName.equals('Needhi Shrivastav')){
                  discountPer = Opportunity__c.getValues(UserInfo.getUserId());	
               }else{
  	   	  	      discountPer = Opportunity__c.getValues(profileId);
               }
                    	  
  	           system.debug('******************discountPer************'+discountPer.Discount_Amount__c);
  	             	   
  	           for(Opportunity o :oppList){	   
  	             if(o.Amount==null || o.Amount<=0){
  	             	o.Discount_Amount__c =0;
  	             }else{
  	              discountAmount = o.Amount - ((o.Amount * discountPer.Discount_Amount__c)/100 );  	      
  	              system.debug('**********discountAmount************'+discountAmount);
  	              o.Discount_Amount__c = discountAmount;
  	             }
  	           }//for ends  	   	  	
  	   	  }else {
  	   	  	//If any other profile
  	   	  	  if(fullName.equals('Needhi Shrivastav')){
                  discountPer = Opportunity__c.getValues(UserInfo.getUserId());	
                  
                  for(Opportunity o :oppList){	   
  	                if(o.Amount==null  || o.Amount<=0){
  	             	  o.Discount_Amount__c =0;
  	                }else{
  	                  discountAmount = o.Amount - ((o.Amount * discountPer.Discount_Amount__c)/100 );  	      
  	                  system.debug('**********discountAmount************'+discountAmount);
  	                  o.Discount_Amount__c = discountAmount;
  	                }
  	             }//for ends
              }else{
  	   	  	      for(Opportunity o :oppList){	   
  	                if(o.Amount==null  || o.Amount<=0){
  	             	  o.Discount_Amount__c =0;
  	                }else{
  	                  discountAmount = o.Amount - ((o.Amount * 10)/100 );  	      
  	                  system.debug('**********discountAmount************'+discountAmount);
  	                  o.Discount_Amount__c = discountAmount;
  	                }
  	             }//for ends
              } 	   	  	
  	   	  }//else
  	   }//outer for  	     
    }//method
}//class