/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class CheckDuplicateContact {

    static testMethod void checkDuplicateTest() {
        
        Contact contact = new Contact(LastName = 'Barrl', Email = 'barrl_tim@grandhotels.com', Phone = '(312) 596-1999');
        insert contact;
        
        test.startTest();
         Contact con = [Select Id, Email, Phone From Contact 
                        Where LastName = 'Barrl' AND Email = 'barrl_tim@grandhotels.com' AND Phone = '(312) 596-1999' ];
         system.assertEquals(con.Email, 'barrl_tim@grandhotels.com');
         system.assertEquals(con.Phone, '(312) 596-1999');
        test.stopTest();
                 
    }
    
    
    static testMethod void checkDuplicateTestNegative(){
        
        Contact contact = new Contact(LastName = 'Lol', Email = 'lol_timm@grandhotels.com', Phone = '(312) 596-1011');
        insert contact;
        
        test.startTest();
         
         Contact con = new Contact(LastName = 'Lolly', Email = 'lol_tim@grandhotels.com', Phone = '(312) 596-1111');
                
           Database.SaveResult srList = Database.insert(con, false);
           

                  for(Database.Error err : srList.getErrors()) {
                     System.debug('The following error has occurred.');
                     System.debug(err.getStatusCode() + ': ' + err.getMessage());
                     System.debug('Fields that affected this error: ' + err.getFields());
                  }
           
           
         
        test.stopTest();
    	
    }
    
    //Bulk query
    static testMethod void checkDuplicateTestBulk(){
    	
    	for(Integer i=0; i<25; i++){
    		Contact contact = new Contact(LastName = 'Lirril'+i, Email = 'lirril_timm@grandhotels.com', Phone = '(312) 596-2011');
            
          try{ 
          	insert contact;       
            for(Contact con :[Select Id, Email, Phone From Contact 
                        Where  Email = 'lol_timm@grandhotels.com' AND Phone = '(312) 596-1011' ]){
               
                        
            }
          }catch(Exception e){
          	System.assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION') );
          }  
    	}      
    		
    }
}