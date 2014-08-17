public with sharing class CheckDuplicates_Handler {

    //Constructor
    public CheckDuplicates_Handler(){}

    Contact_CheckDuplicates chkDup = new Contact_CheckDuplicates();

    public void checkDuplicate(Map<String,Contact> contactMap){
       Contact_CheckDuplicates chkDup = new Contact_CheckDuplicates();
       chkDup.Contact_chkDupEmailPhone(contactMap);
    }    
}