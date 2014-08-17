public with sharing class DuplicateCheckForAccount {

    //Constructor
    public DuplicateCheckForAccount(){}

    public void chkDuplicateAccount(List<Account> accountList){
    	
    	//All records
    	List<Account> result = [Select Email__c, Phone, Full_Name__c, ID From Account];
    	
    	//for loop to get email
    	for(Account account : accountList){
    	  for(Account existingAccount : result){	
    		
           if ((account.Email__c == existingAccount.Email__c && account.Phone == existingAccount.Phone) ||
                (account.Email__c == existingAccount.Email__c && account.Full_Name__c == existingAccount.Full_Name__c) ||
                 (account.Phone == existingAccount.Phone && account.Full_Name__c == existingAccount.Full_Name__c) ) {
			
			   account.ParentId = existingAccount.Id; //to make parentof existing 
    	    }
    	    
    	 }//inner for  
       }//outer for
       
    }
    
}