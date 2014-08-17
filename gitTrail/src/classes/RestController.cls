@RestResource(urlMapping='/showAccounts/*')

global class RestController 
{
    //Http Delete method - delete a record
   @HttpDelete
   global static Map<String, String> deletematchedRecord(){
       
       RestRequest request = RestContext.request;
       String fname = request.params.get('FirstName');
       system.debug('*******FirstName***********'+fname);
       String lname = request.params.get('LastName');
      
       Map<String , String> responseParam = new Map<String, String>();
        
       List<Lead> lead = [Select Name,FirstName,LastName From Lead Where FirstName = :fname 
                          AND LastName = :lname];
                          
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
}