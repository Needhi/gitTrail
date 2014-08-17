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
private class LeadCloneTestCase {

    //Positive
    static testMethod void LeadCloneTestCase() {
    
        Lead leadObj = new Lead(LastName = 'Shri', Company = 'eternus', Status = 'Open - Not Contacted');
        
        test.startTest();
          insert leadObj;
          
          List<AggregateResult> result = [select Count(Id)cnt from Lead where LastName='Shri' AND Status = 'Working - Contacted'];
          system.debug('*************************result***'+result);
          system.assertEquals(1,Integer.valueOf(String.valueOf(result[0].get('cnt'))));
       test.stopTest();
    }
    
    
    //Negative
    static testMethod void LeadCloneTestCaseNegative(){
    	
        Lead lead = new Lead();
        lead.LastName = 'Amit';
        lead.Company = 'Singh';
        lead.Status = 'Closed - Converted';
         insert lead;
      
       try{
         List<Lead> l = [Select LastName, Status From Lead Where LastName = :lead.LastName AND Status = 'Working - Contacted'];
         system.debug('********l*******'+l.isEmpty());
         System.assert(l.isEmpty());
       }catch(Exception e){
      	   System.assert(e.getMessage().contains('Invalid Text'));
       }    	
    }   
    
    
    //Bulk
    static testMethod void LeadCloneTestCaseBulk(){
    	List<Lead> leadList = new List<Lead>();
    	for(Integer i=0; i <=25; i++){
    		Lead leadObj = new Lead(FirstName = 'Needhi'+i, LastName = 'Shrivastav', Company = 'eternus', Status = 'Open - Not Contacted');
    	    leadList.add(leadObj);
    	}
    	insert leadList;
    	List<Lead> Leadlst = new List<Lead>(); 
    	test.startTest();
    	  for(Integer i=0; i<=25; i++){
    	  	leadlst = [Select ID From Lead Where LastName = 'Shrivastav' AND Status = 'Working - Contacted'];
    	  	//leadlst.add(lead);
    	  }
    	  system.assert(Leadlst.size()>=25);
    } 
    
}