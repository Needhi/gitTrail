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
private class RecalculateDiscountOnOpportunityTestCase {

    static testMethod void myUnitTest() {
        Opportunity opp = new Opportunity(Name='Test opportunity', CloseDate=Date.valueOf('2013-12-12'),StageName='Prospecting',
                                           Amount=100);
        List<String> lst = new List<String>();
        lst.add(opp.Id);
        system.test.setFixedSearchResults(lst);
        Profile profile = [Select Id From Profile Where Name='System Administrator'];
        User user = new User(Alias = 'sysadmin', Email='needhi23@gmail.com',
                             EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                             LocaleSidKey='en_US', ProfileId = profile.Id,
                             TimeZoneSidKey='Asia/Kolkata', UserName='testcaseuser@developer.com');
       System.runAs(user){
       	  insert opp;
       	  Opportunity opp1 = [Select Discount_Amount__c from Opportunity Where Name='Test opportunity'];
       	  system.assertEquals(opp1.Discount_Amount__c, 85);
       }
    }
    
    static testMethod void negativeTest(){
    	Opportunity opp = new Opportunity(Name='Test opportunity', CloseDate=Date.valueOf('2013-12-12'),StageName='Prospecting');
        List<String> lst = new List<String>();
        lst.add(opp.Id);
        system.test.setFixedSearchResults(lst);
        Profile profile = [Select Id From Profile Where Name='Technical'];
        User user = new User(Alias = 'otherPle', Email='needhi23@gmail.com',
                             EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                             LocaleSidKey='en_US', ProfileId = profile.Id,
                             TimeZoneSidKey='Asia/Kolkata', UserName='testcaseuser@developer.com');
       System.runAs(user){
       	  insert opp;
       	  Opportunity opp1 = [Select Discount_Amount__c from Opportunity Where Name='Test opportunity'];
       	  system.assertEquals(opp1.Discount_Amount__c, 0);
       }
    }
    
     static testMethod void BulkTest() {
        List<String> lst = new List<String>();
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=0; i<5; i++){
          Opportunity opp = new Opportunity(Name='Test opportunity'+i, CloseDate=Date.valueOf('2013-12-12'),StageName='Prospecting',
                                           Amount=100);
          lst.add(opp.Id);
          oppList.add(opp);
        }  
        
        system.test.setFixedSearchResults(lst);
        Profile profile = [Select Id From Profile Where Name='Technical'];
        User user = new User(Alias = 'sysadmin', Email='needhi23@gmail.com',
                             EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                             LocaleSidKey='en_US', ProfileId = profile.Id,
                             TimeZoneSidKey='Asia/Kolkata', UserName='testcaseuser@developer.com');
       System.runAs(user){
       	  insert oppList;
       	  for(Opportunity opp1 :[Select Discount_Amount__c from Opportunity Where Name LIKE 'Test opportunity%']){
       	    
       	    system.assertEquals(opp1.Discount_Amount__c, 90);
       	  }  
       }
    }
    
}