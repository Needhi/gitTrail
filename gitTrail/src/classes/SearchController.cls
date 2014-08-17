public with sharing class SearchController {

   public String searchStr {get; set;}
	public string cnt=null;
   public List<Account> accountSearch{get; set;}
   public List<Contact> contactSearch{get; set;}
   public List<Opportunity> oppSearch{get; set;}
   public List<Lead> leadSearch{get; set;}
   
   public boolean leadRen{get; set;}
   public boolean accRen{get; set;}	
   public boolean conRen{get; set;}
   public boolean oppRen{get; set;}
   
   //Constructor
   public SearchController(){
      leadRen=false;
      accRen=false;
      conRen=false;
      oppRen=false;
      accountSearch = new List<Account>();
  	  contactSearch = new List<Contact>();
  	  oppSearch = new List<Opportunity>();
  	  leadSearch = new List<Lead>();
   }
  
   
   //Button Action
   public PageReference searchAction(){
   	 accRen = false;	conRen=false; oppRen=false; leadRen=false;
     if(String.isBlank(searchStr) || searchStr==null || searchStr.isNumeric() || searchStr.containsAny('!@#$%^&*')){
     	accRen = false;	conRen=false; oppRen=false; leadRen=false;
     	//errorMsg code
  	 	ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.Info ,system.Label.ErrorMsgEnterStr);         
        ApexPages.addMessage(errorMsg);
     } else {
     	
  	 String searchTxt='*'+ searchStr+'*';
     
     String queryStr='FIND ' + '\'' + searchTxt+ '\''+' IN ALL FIELDS RETURNING Account(Name),Contact(FirstName, LastName, Name),Opportunity(Name), Lead(FirstName, LastName, Name)';
  	                                             
  	 
  	  List<List<sObject>> getFieldsFrmsOBjt = search.query(queryStr);
  	 
  	/* List<List<sObject>> getFieldsFrmsOBjt = [Find :searchStr IN ALL FIELDS RETURNING Account(Name),
  	                                             Contact(FirstName, LastName, Name), 
  	                                             Opportunity(Name), Lead(FirstName, LastName, Name)];
  	 */
  	 //cnt = searchTxt;
  	 Integer count=0;
     system.debug('***************************getFieldsFrmsOBjt.isEmpty()*' +getFieldsFrmsOBjt[0].isEmpty());  	
  	 if(!getFieldsFrmsOBjt[0].isEmpty()){
  	 	accountSearch = (List<Account>) getFieldsFrmsOBjt[0];
  	 	
  	 	accRen=true;
  	 }else{
  	    count++;
  	 }	
  	 
  	 if(!getFieldsFrmsOBjt[1].isEmpty()){
  	 	contactSearch = (List<Contact>) getFieldsFrmsOBjt[1];
  	 	conRen=true;
  	 }else{
  	    count++;
  	 }
  	 	
  	 if(!getFieldsFrmsOBjt[2].isEmpty()){
  	 	oppSearch = (List<Opportunity>) getFieldsFrmsOBjt[2];
  	 	 oppRen=true;
  	 }else{
  	    count++;
  	 }
  	 
  	 if(!getFieldsFrmsOBjt[3].isEmpty()){
  	 	leadSearch = (List<Lead>) getFieldsFrmsOBjt[3];  	 	
  	 	leadRen=true;
  	 }else{
  	    count++;
  	 }	
  	 	
  	 if(count == 4){
  	 	accRen = false;	conRen=false; oppRen=false; leadRen=false;
  	 	system.debug('**********************');
  	 	//errorMsg code
  	 	ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.Info ,system.Label.ErrorMsgNoResult);//'No matching results found!!!'
        ApexPages.addMessage(errorMsg);
  	 }
     }//else
     return null;
   }
     
}