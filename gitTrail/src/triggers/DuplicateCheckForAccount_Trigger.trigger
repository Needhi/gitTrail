trigger DuplicateCheckForAccount_Trigger on Account (before insert, before update) {

    DuplicateCheckForAccount_Handler handler = new DuplicateCheckForAccount_Handler();
    if(trigger.isBefore){
    	if(trigger.isInsert){
    		
    		handler.chkDuplicateAccount(trigger.new);
    		
    	}
    	
    	if(trigger.isUpdate){
    		handler.chkDuplicateAccount(trigger.new);
    	}
    }

}