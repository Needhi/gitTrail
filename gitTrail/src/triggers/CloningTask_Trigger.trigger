trigger CloningTask_Trigger on Lead (after insert) {

    if(Trigger.isAfter){
      if(Trigger.isInsert){	
                    
        CloningLead_Handler handler = new CloningLead_Handler();
        
        List<Lead> leadLst = handler.cloningLead(trigger.new);
        insert leadLst;
            
       /* if(leadLst.size() != 0){
      	  system.debug('************************************************'+leadLst.size());
    	  insert leadLst;
    	  system.debug('***************insert leadLst**********************************');
        }*/
      } 
    }
}