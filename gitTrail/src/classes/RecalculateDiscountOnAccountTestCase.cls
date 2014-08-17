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
private class RecalculateDiscountOnAccountTestCase {

    static testMethod void positiveTest() {
        Account account = new Account(Name='TestCase Account', Amount__c=100);
        
        insert account;
        
        Account acc = [Select Amount__c From Account Where Name='TestCase Account'];
        system.assertEquals(acc.Amount__c, 75);
    }
    
    static testMethod void negativeTest(){
    	Account account = new Account(Name='TestCase Account');
    	
    	insert account;
    	
    	Account acc = [Select Amount__c From Account Where Name='TestCase Account'];
        system.assertEquals(acc.Amount__c, 0);
    }
    
    static testMethod void bulkTest(){
    	List<Account> lst = new list<Account>();
    	for(Integer i=0;i<5;i++){
    		Account account = new Account(Name='TestCase Account'+i, Amount__c=200);
    		lst.add(account);
    	}
    	for(Account acc : [Select Amount__c from Account Where name LIKE 'TestCase Account%']){
    	  system.assertEquals(acc.Amount__c, 150);	
    	}
    }
}