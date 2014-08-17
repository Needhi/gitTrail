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
global class LeadManipulatorServiceTestCase implements HttpCalloutMock{

    global HttpResponse respond(HttpRequest request) {
      
       HttpResponse res = new HttpResponse();
       
       //res.setHeader('Content-Type', 'application/json');
       
       //we can set here parameters for delete and put
        
       //res.setBody('{"FirstName":"test", "LastName" : "case", "Email" : "test@d.com","Phone" : "1234567890" ,"Company" : "test company", "Status" : "Closed - Converted" }');
      // res.setStatusCode(200);
       return res;
         
    }
 
    static testMethod void positiveTest(){
    	system.test.setMock(HttpCalloutMock.class, new LeadManipulatorServiceTestCase());
    	
    	if(System.Test.isRunningTest()){
    		system.debug('****************************inside test.isrunningtest');
    	    //insert Lead
    	    Map<String, String> createLead = LeadManipulatorService.createNewLead('Test', 'case', 'test@e.com', '1234567890', 'test company', 'Closed - Converted');
    	    for(Integer i=1; i<createLead.size();i++){
    	      system.assertEquals('true',createLead.get('isSuccess'));
    	      system.assert(createLead.get('Lead ID')!=null);
    	      system.assertEquals('Success',createLead.get('Status'));    	  
    	    }
    	} else {
    		system.debug('**************************************Wrong code');
    	}
    	
    	//update Lead
    	Map<String, String> updateLead = LeadManipulatorService.updateMatchedRecord('Test', 'case', 'testcase@e.com', '2134567890');
    	for(Integer i=1; i<updateLead.size();i++){
    	  system.assertEquals('true',updateLead.get('isSuccess'));
    	  system.assert(updateLead.get('Lead ID')!=null);
    	  system.assertEquals('Success',updateLead.get('Status'));    	  
    	} 
    	
    	//Delete Lead
    	RestRequest request = new RestRequest();
    	request.httpMethod = 'Delete';
    	request.addParameter('FirstName', 'Test');
    	request.addParameter('LastName', 'case');
    	request.addParameter('Email', 'testcase@e.com');
    	request.addParameter('Phone', '2134567890');
    	    	
    	RestContext.request = request; 
    	system.debug('***********request*************'+request);
    	
    	Map<String, String> deleteLead = LeadManipulatorService.deletematchedRecord();
    	for(Integer i=1; i<deleteLead.size();i++){
    	  system.assertEquals('true',deleteLead.get('isSuccess'));
    	  system.assert(deleteLead.get('Lead Name')!=null);
    	  system.assertEquals('Success',deleteLead.get('Status'));    	  
    	} 	
    }
    
    static testMethod void negativeTest(){
    	system.test.setMock(HttpCalloutMock.class, new LeadManipulatorServiceTestCase());
    	
    	//inserting Lead fails
    	Map<String, String> createLead = LeadManipulatorService.createNewLead('Test', 'case', 'test@e.com', '1234567890', '', 'Closed - Converted');
    	for(Integer i=1; i<createLead.size();i++){
    	  system.assertEquals('false',createLead.get('isSuccess'));
    	  system.assert(createLead.get('Lead ID')=='');
    	  system.assert(createLead.get('Status').contains('Insert failed.'));    	  
    	}
    	
    	//updation of record will fail    	
    	Map<String, String> updateLead = LeadManipulatorService.updateMatchedRecord('Test', 'case', 'testcase@e.com', '2134567890');
    	for(Integer i=1; i<updateLead.size();i++){
    	  system.assertEquals('false',updateLead.get('isSuccess'));
    	  system.assert(updateLead.get('Lead ID')=='');
    	  system.assertEquals('No Records Found',updateLead.get('Status'));    	  
    	} 
    	
    	//delete will fail
    	RestRequest request = new RestRequest();
    	request.httpMethod = 'Delete';
    	request.addParameter('FirstName', 'Test');
    	request.addParameter('LastName', 'case');
    	request.addParameter('Email', 'testcase@e.com');
    	request.addParameter('Phone', '2134567890');
    	    	
    	RestContext.request = request; 
    	system.debug('***********request*************'+request);
    	
    	Map<String, String> deleteLead = LeadManipulatorService.deletematchedRecord();
    	for(Integer i=1; i<deleteLead.size();i++){    		
    	  system.assertEquals('false',deleteLead.get('isSuccess'));
    	  system.assert(deleteLead.get('Lead Name')=='');
    	  system.assertEquals('No Records Found',deleteLead.get('Status'));    	  
    	}
    	
    	//updation of record will fail    	
    	Map<String, String> updateLead1 = LeadManipulatorService.updateMatchedRecord('', '', '', '');
    	for(Integer i=1; i<updateLead1.size();i++){
    	  system.assertEquals('false',updateLead1.get('isSuccess'));
    	  system.assert(updateLead1.get('Lead ID')=='');
    	  system.assertEquals('No Records Found',updateLead1.get('Status'));    	  
    	}     	
    }
}