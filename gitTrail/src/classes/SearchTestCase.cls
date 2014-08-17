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
private class SearchTestCase {

    static testMethod void searchStrTest() {
    
      
      Lead leadRecord = new Lead(FirstName='ABC', LastName='Willam', Company='XYZ', Status='Closed - Converted');
      Account accRecord = new Account(Name='ABC', Amount__c=100);
      Contact conRecord = new Contact(FirstName='ABC', LastName='Willam');
      Opportunity oppRecord = new Opportunity(Name='XYZ', CloseDate=Date.valueOf('2013-12-12'),StageName='Prospecting');
      List<String> lst = new List<String>();
      
      insert leadRecord;
      insert accRecord;
      insert conRecord;
      insert oppRecord;
      lst.add(leadRecord.Id);
      lst.add(accRecord.Id);
      lst.add(conRecord.Id);
      lst.add(oppRecord.Id);
      system.test.setFixedSearchResults(lst);
      
      SearchController controller = new SearchController();
      controller.searchStr = 'Will';
      
       system.test.startTest();
        PageReference pg = controller.searchAction();
      
       //system.test.stopTest();
      
      system.assertEquals(1,(controller.leadSearch).size());   
      system.assertEquals(1,(controller.accountSearch).size());
      system.assertEquals(1,(controller.contactSearch).size());
      system.assertEquals(1,(controller.oppSearch).size());   
     
             
   
      
      Lead leadRecord1 = new Lead(FirstName='ABC', LastName='Willam', Company='XYZ', Status='Closed - Converted');
      Account accRecord1 = new Account(Name='ABC', Amount__c=100);
      Contact conRecord1 = new Contact(FirstName='ABC', LastName='Willam');
      Opportunity oppRecord1 = new Opportunity(Name='XYZ', CloseDate=Date.valueOf('2013-12-12'),StageName='Prospecting');
      List<String> lst1 = new List<String>();
      
      insert leadRecord1;
      insert accRecord1;
      insert conRecord1;
      insert oppRecord1;
      lst1.add(leadRecord1.Id);
      lst1.add(accRecord1.Id);
      lst1.add(conRecord1.Id);
      lst1.add(oppRecord1.Id);
      system.test.setFixedSearchResults(lst1);
      system.debug('*************lst***********'+lst1);
      SearchController controler = new SearchController();
      controler.searchStr = 'Testcheck';
      
      // system.test.startTest();
        try{
          PageReference pg1 = controler.searchAction();
        }catch(Exception e){ 
          system.assert(e.getMessage().contains('No matching result found'));
        } 
       //system.test.stopTest();       
       
   
       
      Lead leadRecord2 = new Lead(FirstName='ABC', LastName='Willam', Company='XYZ', Status='Closed - Converted');
      Account accRecord2 = new Account(Name='ABC', Amount__c=100);
      Contact conRecord2 = new Contact(FirstName='ABC', LastName='Willam');
      Opportunity oppRecord2 = new Opportunity(Name='XYZ', CloseDate=Date.valueOf('2013-12-12'),StageName='Prospecting');
      List<String> lst2 = new List<String>();
      
      insert leadRecord2;
      insert accRecord2;
      insert conRecord2;
      insert oppRecord2;
      lst2.add(leadRecord2.Id);
      lst2.add(accRecord2.Id);
      lst2.add(conRecord2.Id);
      lst2.add(oppRecord2.Id);
      system.test.setFixedSearchResults(lst2);
       
       SearchController controller1 = new SearchController();
       controller1.searchStr = null;
      
       //system.test.startTest();
        try{
          PageReference pg2 = controller1.searchAction();
        }catch(Exception e){ 
          system.assert(e.getMessage().contains('Enter String to search'));
        } 
       //system.test.stopTest(); 
       
       SearchController controller11 = new SearchController();
       controller11.searchStr = '@#';
      
      // system.test.startTest();
        try{
          PageReference pg3 = controller11.searchAction();
        }catch(Exception e){ 
          system.assert(e.getMessage().contains('Enter String to search'));
        } 
       system.test.stopTest(); 
    }
}