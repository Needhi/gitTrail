public with sharing class DuplicateCheckForAccount_Handler {

    //Constructor
    public DuplicateCheckForAccount_Handler(){}
    DuplicateCheckForAccount accountObj = new DuplicateCheckForAccount();
    public void chkDuplicateAccount(List<Account> accountList){
    	
    	accountObj.chkDuplicateAccount(accountList);
    }   
    
}