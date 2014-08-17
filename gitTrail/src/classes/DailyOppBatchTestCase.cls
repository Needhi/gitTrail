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
@isTest(seeAllData=true)
private class DailyOppBatchTestCase {

    static testMethod void myUnitTest() {
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=1;i<5;i++){
        	Opportunity opp = new Opportunity(Name='TEstCase'+i, StageName='Closed Won', 
        	                                  CloseDate=Date.valueOf('2013-12-12'), Amount =50);
        	oppList.add(opp);
        }
        insert oppList;
        
        DailyOpportunityAmountAggregator obj = new DailyOpportunityAmountAggregator();
        system.Test.startTest();
                    
          ID batchProcessId = Database.executeBatch(obj); 
          system.debug('******************obj******'+batchProcessId);       
        system.Test.stopTest();
        List<Opportunity> lst = [Select Name,Amount from Opportunity
                                 Where IsAggregrated__c = true AND CloseDate = :Date.valueOf('2013-12-12')];
        
       //System.assertEquals(4,lst.size());
       // System.assertEquals(250, obj.amt);
       System.assertEquals(1,DailyOpportunityAmountAggregator.numbatch);
       System.assertEquals(200,DailyOpportunityAmountAggregator.smamt);
        
    }
}