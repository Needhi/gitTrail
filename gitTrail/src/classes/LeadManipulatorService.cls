@RestResource(urlMapping = '/leadManipulatorService/*')
global with sharing class LeadManipulatorService {

   //constructor
   global LeadManipulatorService(){}
   
   //HTTP Post method - creating new record
   @HttpPost
   global static Map<String, String> createNewLead(String FirstName, String LastName, String Email, String phoneNum,
                                                   String Company, String Status){
   	
   	   RestRequest request = RestContext.request;
   	   RestResponse response = RestContext.response;
   	   
   	   Map<String , String> responseParam = new Map<String, String>();
   	   
   	   Lead lead = new Lead();
   	   lead.FirstName = FirstName;
   	   lead.LastName = LastName;
   	   lead.Email = Email;
   	   lead.Phone = phoneNum;
   	   lead.Company = Company;
   	   lead.Status = Status;
   	   
   	   try{
   	   	 Database.insert(lead); //Database.Error
   	   	 responseParam.put('isSuccess','true');
   	   	 responseParam.put('Lead ID',lead.Id);
   	   	 responseParam.put('Status','Success');
   	   }catch(DMLException e){
   	   	  system.debug(e.getMessage());
   	   	  responseParam.put('isSuccess','false');
   	   	  responseParam.put('Lead ID','');
   	   	  responseParam.put('Status',e.getMessage());
   	   }   	   
   	   
   	   return responseParam;
   }//end of http post
   
   //Http Delete method - delete a record
   @HttpDelete
   global static Map<String, String> deletematchedRecord(){
       
       RestRequest request = RestContext.request;
       String fname = request.params.get('FirstName');
       system.debug('*******FirstName***********'+fname);
       String lname = request.params.get('LastName');
       system.debug('*******LastName***********'+lname);
       String emailId = request.params.get('Email');
       system.debug('*******Email***********'+emailId);
   	   String phoneNum = request.params.get('Phone');
   	   system.debug('*******Phone***********'+phoneNum);
   	  
   	   Map<String , String> responseParam = new Map<String, String>();
   	    
   	   List<Lead> lead = [Select Name,FirstName,LastName,Email,Phone From Lead Where FirstName = :fname 
   	                      AND LastName = :lname AND Email = :emailId AND Phone = :phoneNum];
   	                      
   	   if(lead.size()== 0){
   	   	  responseParam.put('isSuccess','false');
   	   	  responseParam.put('Lead Name','');
   	   	  responseParam.put('Status','No Records Found'); 
   	   }
   	   
   	   try{
   	                                 
   	     for(Lead leadObj : lead){
   	     	Database.delete(leadObj);
   	        responseParam.put('isSuccess','true');
   	   	    responseParam.put('Lead Name',leadObj.Name);
   	   	    responseParam.put('Status','Success');   	   	   
   	     }
   	   }catch(DMLException e){
   	   	 responseParam.put('isSuccess','false');
   	   	 responseParam.put('Lead Name','');
   	   	 responseParam.put('Status',e.getMessage());
   	   	 
   	   }                                               
       return responseParam;	
   }
   
   
   //Http Delete method - delete a record
   @HttpPatch
   global static Map<String, String> updateMatchedRecord(String FirstName, String LastName, String newEmail, String newphoneNum){
       
       Map<String , String> responseParam = new Map<String, String>();
   	    
   	   List<Lead> lead = [Select Name,FirstName,LastName,Email,Phone From Lead Where FirstName = :FirstName 
   	                      AND LastName = :LastName ];                   
   	  
   	   system.debug('**************lead*****'+lead);
   	   try{
   	   	 if(lead.size()== 0){
   	   	  responseParam.put('isSuccess','false');
   	   	  responseParam.put('Lead ID','');
   	   	  responseParam.put('Status','No Records Found'); 
   	     }
   	   	system.debug('*******************Inside try******');                              
   	     for(Lead leadObj : lead){
   	     	leadObj.Email = newEmail;
   	     	leadObj.Phone = newphoneNum;
   	     	update leadObj;
   	        responseParam.put('isSuccess','true');
   	   	    responseParam.put('Lead ID',leadObj.Id);
   	   	    responseParam.put('Status','Success');   	   	   
   	     }
   	   }catch(DMLException e){
   	   	 responseParam.put('isSuccess','false');
   	   	 responseParam.put('Lead ID','');
   	   	 responseParam.put('Status',e.getMessage());
   	   	 
   	   }                                               
       return responseParam;	
   }
}