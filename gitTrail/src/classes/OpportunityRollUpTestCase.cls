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
private class OpportunityRollUpTestCase {

    //Positive 
    static testMethod void opportunityRollUpTestCase() {
        
        Opportunity parentOpp = new Opportunity(Name='Opportunity1' , CloseDate= date.valueOf('2013-12-12'),
                                                 StageName='Prospecting', Amount=100);    
        insert parentOpp;
        
        Opportunity childOpp = new Opportunity(Name='Opportunity2', CloseDate= date.valueOf('2013-12-12'), StageName='Qualification', 
                                               OppSelf__c = parentOpp.Id, Amount=50);
                
        system.test.startTest();
           insert childOpp;
           Opportunity opp =  [Select Expected_Revenue__c From Opportunity Where Id = :parentOpp.Id];
           system.assertEquals(opp.Expected_Revenue__c, 150);
        system.test.stopTest();   
        
    }
    
    //Negative    
    static testMethod void opportunityRollUpNegativeTest(){
    	
    	Opportunity parentOpp = new Opportunity(Name='Opp1' , CloseDate=system.today(),
                                                 StageName='Prospecting', Amount=100);    
        insert parentOpp;
        system.test.startTest();
        try{
          Opportunity childOpp = new Opportunity(Name='Opp2', CloseDate=system.today(), StageName='Qualification');
          insert childOpp;
    	    
        }catch(Exception e){
 
        	System.assert(e.getMessage().contains('Invalid entry')); 
        }
    	system.test.stopTest();    	
    	
    }   
    
    //bulk
    static testMethod void opportunityRollUpBulkTest(){
    
        Opportunity parentOpp = new Opportunity(Name='Opportunity' , CloseDate= date.valueOf('2013-12-12'),
                                                 StageName='Prospecting', Amount=100);    
          insert parentOpp;
          List<Opportunity> childOpp = new List<Opportunity>();
       for(Integer i=0; i<25; i++){
       	 
          childOpp.add( new Opportunity(Name='Opportunity'+i, CloseDate= date.valueOf('2013-12-12'), StageName='Qualification', 
                                               OppSelf__c = parentOpp.Id, Amount=50));
          
       }
       insert childOpp;
       for(Opportunity opp : [Select Expected_Revenue__c from Opportunity Where Id = :parentOpp.Id]){
       	   system.assertEquals(opp.Expected_Revenue__c, 1350);   
       }
       	
    	
    }
}