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
private class OpportunityTaskCreationAccount {

    static testMethod void myUnitTest() {
        
        Account account = new Account(Name = 'Sample TEst Account');
        insert account;
        test.startTest();
          Task task = [Select Subject From Task Where Subject = 'Meeting with Sample TEst Account' ];
          system.assert( task!=null );
        test.stopTest();
    }
    
     static testMethod void bulkTestCase() {
        
        List<Account> accList = new List<Account>();
        for(Integer i=0; i<=25; i++){
          Account account = new Account(Name = 'Sample TEst Account'+i);
          accList.add(account);
        }
        insert accList;
        List<Task> taskList = new List<Task>();
        test.startTest();
          for(Integer i=0; i<=25; i++){
            taskList = [Select Subject From Task Where Subject = 'Meeting with Sample TEst Account%' ];            
          }
          system.assert(taskList.size()>=25);
        test.stopTest();
    }
}