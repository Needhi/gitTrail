trigger CheckDuplicates_Trigger on Contact (before insert) {

    public CheckDuplicates_Handler handler = new CheckDuplicates_Handler();
    
    Map<String, Contact> contactMap = new Map<String,Contact>();
    for(Contact contact:Trigger.new)
    {
     if ((contact.Email != null || contact.Phone != null)) {
			
			//Get Emails          
            if (!contactMap.containsKey(contact.Email) ) {
                contactMap.put(contact.Email, contact);
            } 
            //Get Phone
            if(!contactMap.containsKey(contact.Phone)  ) {
                contactMap.put(contact.Phone, contact);
            }
            else{
              contactMap.put(contact.Email, contact);
              contactMap.put(contact.Phone, contact);
            }  
     }//if ends           
    }//for ends
    handler.checkDuplicate(contactMap);
}