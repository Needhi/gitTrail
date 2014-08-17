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
@isTest(SeeAllData=true)
private class CreateTaskAccountTestCase {

   static testMethod void UnitTest(){
        
     Account account=new Account(Name='Account1', Email__c='abhisheksri@gmail.com');
     string account1= 'Meeting with '+account.Name;
     system.test.startTest();
     insert account;
     for(Task task :[select task.WhatId ,task.Subject from Task Where WhatId = :account.Id]){
        system.assertEquals(account1, task.Subject);
     }
     system.test.stopTest();
    }   
     
    //negative test case for inserting data
    static testMethod void NegativeTest()
    {
    	Account account=new Account(Name= 'Account 2',Email__c='ritesh@gmail.com');
    	
    	try
    	{
    		insert account;
    	}
    	catch(Exception e)
    	{
    	  System.assert(e.getMessage().contains('Insert failed'));
    	}
    
    } 
    
    static testMethod void bulkTest(){
       
        for(Integer i=1; i<=25; i++){
          Account account=new Account(Name='Account'+i, Email__c='abhisheksri@gmail.com');
          string accStr= 'Meeting with '+account.Name;        
          insert account;
            
        
          for(Task task :[select WhatId ,task.Subject from Task where whatID = :account.Id ]){
             system.assertEquals(accStr , task.Subject);
          }
        }        
       
    }   
}