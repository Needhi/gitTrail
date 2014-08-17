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
private class CampaignControllerTestCase {

    static testMethod void myUnitTest() {
        
        Campaign camp = new Campaign(Name='TEst Campaign', IsActive=true);
        insert camp;
        
        Campaign campObj = [Select Id, Name From Campaign Where IsActive=true];
       
        CampaignController controller = new CampaignController();
        CampaignController controller1 = new CampaignController();
        CampaignController controller2 = new CampaignController();
        CampaignController controller3 = new CampaignController();
        CampaignController controller4 = new CampaignController();
        
        controller.setCampaignOption('Recently Modified');

        system.test.startTest();
        
          controller.SelectCampAction();        
          system.assertEquals(controller.Section, true);
        
        
          controller1.setCampaignOption('All Campaigns');
          String option = controller1.getCampaignOption();
          system.assert(option == 'All Campaigns');        
          controller1.SelectCampAction();        
          system.assertEquals(controller1.Section, true);
        
          controller2.setCampaignOption('All Active Campaigns');        
          controller2.SelectCampAction();        
          system.assertEquals(controller2.Section, true);
        
          controller3.setCampaignOption('InActive Campaigns');        
          controller3.SelectCampAction();        
          system.assertEquals(controller3.Section, true);
          
          controller4.setCampaignOption('My Active Campaigns');        
          controller4.SelectCampAction();        
          system.assertEquals(controller4.Section, true);
       
         PageReference pg = Page.CampaignManagementViewPage;   
         system.test.setCurrentPage(pg);
         String id = camp.Id;
         pg.getParameters().put('Parameter',id);
         Map<String, String> getParam =Apexpages.currentPage().getParameters();
         //system.debug('***********************getParam*****'+getParam.get('Parameter'));
         
         Map<String,String> mapParam = pg.getParameters();
         system.debug('************************mapParam******'+mapParam);
         pg.setRedirect(true);
         
         CommandLinkParamController linkClick = new CommandLinkParamController();
         for(Id gtId : mapParam.values()){
           linkClick.Id = gtId;
         }
          
         system.debug('********************linkClick.Id******'+linkClick.Id); 
         
         String gtUrl=controller.linkIsClickedAction().getUrl();
         system.assertEquals('/apex/CM_Campaign_Detail_page',gtUrl);
         system.assert(linkClick.getCampaign()!=null);
         system.assert(controller.campaignRecords.size()>0);
          
        
   /* }
    
    static void neagativeTest(){*/
    	
    	Campaign camp1 = new Campaign(Name='Test1 Campaign', IsActive=true);
        insert camp1;
        
    	CampaignController cont = new CampaignController();
    	cont.setCampaignOption('');
    	
    	system.assert(cont.campaignRecords.size()==0);
    	system.test.stopTest();
    }
}