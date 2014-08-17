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
private class PurchaseLineItemDiscountTestCase {

    static testMethod void positiveTest() {
        List<Purchase_Line_Item__c> obj = new List<Purchase_Line_Item__c>();
        Opportunity Opp = new Opportunity(Name='Opportunity1' , CloseDate= date.valueOf('2013-12-12'),
                                                 StageName='Prospecting', Amount=100,ChoosePriceBook__c='01s900000021UhWAAU');    
        insert Opp;
        Purchase_Order__c testPO = new Purchase_Order__c(Opportunity_Name__c=Opp.Id);
        insert testPO;
        Purchase_Line_Item__c lineItem = new Purchase_Line_Item__c(List_Price__c=50,  Quantity__c=2, Discount__c=10, PurchaseOrder__c=testPO.Id);
        insert lineItem;
        system.test.startTest();
        	lineItem.Discount__c=5;
            update lineItem;
        	Double amt = (lineItem.List_Price__c*lineItem.Quantity__c);
        	Double totalAmt = amt - (amt*lineItem.Discount__c/100);
        	system.debug('********totalAmt********'+totalAmt);
        	system.assertEquals(95,totalAmt);        
        system.test.stopTest();               
    }
}