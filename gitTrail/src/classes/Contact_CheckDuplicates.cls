public with sharing class Contact_CheckDuplicates {

    //Constructor
    public Contact_CheckDuplicates(){}
    
    public void Contact_chkDupEmailPhone(Map<String, Contact> contactMap){
    	
        for (Contact contact : [Select Email From Contact
                                WHERE Email IN  :contactMap.KeySet()]) {
        Contact newcontactEmail = contactMap.get(contact.Email);
        newcontactEmail.Email.addError('A Contact with same email address already exists in system.');
                              
    }// For ends
    
    //For loop For checking Phone Statrts
    for (Contact contact : [Select Phone From Contact
                            WHERE Phone IN :contactMap.KeySet()]) {
        Contact newcontactPhone = contactMap.get(contact.Phone);
        newcontactPhone.Phone.addError('A Contact with same Phone address already exists in system.');
                               
     }// For ends  
     return;   
     
     
     
    }//Contact_chkDupEmailPhone ends
}//Contact_CheckDuplicates ends





















/*
for (Contact contact : [Select Email From Contact
                      WHERE Email IN  :conatctMap.KeySet()]) {
        Contact newcontactEmail = conatctMap.get(contact.Email);
        newcontactEmail.Email.addError('A Contact with this email '
                               + 'address already exists.');
    }// For ends
    //For loop For checking Phone Statrts
    for (Contact contact : [Select Phone From Contact
                      WHERE Phone IN :conatctMap.KeySet()]) {
        Contact newcontactPhone = conatctMap.get(contact.Phone);
        newcontactPhone.Phone.addError('A Contact with this phone '
                               + 'already exists.');
             }// For ends  
     return;

*/