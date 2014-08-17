trigger OpportunityRollUp_Trigger on Opportunity (after insert, after update, before delete) {

    OpportunityRollUp_Handler handler = new OpportunityRollUp_Handler();
    if(trigger.isAfter){
    	if(trigger.isInsert || trigger.isUpdate){
    	
    	      	    
    	  /*  List<Opportunity> opptoUpdatelist = handler.oppRollUp(trigger.new);//opportunityList
    	    
    	    system.debug('*************************************'+opptoUpdatelist);
    	    if(opptoUpdatelist.size()>0){
    	    	update opptoUpdatelist;
    	    }*/
    	}//is insert ends    	
    }//is after ends
    if(trigger.isBefore){
        if(trigger.isDelete){
            
           /* List<Opportunity> opptoUpdatelist = handler.oppRollUpDelete(trigger.old);
    	    
    	    system.debug('*************************************'+opptoUpdatelist);
    	    if(opptoUpdatelist.size()>0){
    	    	update opptoUpdatelist;
    	    }	*/
        }
        
    }//is before end    
    
}