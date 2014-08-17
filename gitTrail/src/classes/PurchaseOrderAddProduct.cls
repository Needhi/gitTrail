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
private class PurchaseOrderAddProduct {

    static testMethod void testPOExtension() {
       PageReference pageRef = Page.PurchaseOrderAddProduct;
       
       system.Test.setCurrentPage(pageRef);       
       
       Opportunity opp = new Opportunity(Name='test opp',StageName='Qualification',CloseDate=Date.valueOf('2014-12-12'),
                                         ChoosePriceBook__c='01s900000021UhWAAU',Amount=100);
       insert opp;
       
       Product2 product = new Product2(Id='01t90000001fhQYAAY',Name='D-Link DIR Router', ProductCode='R-102');       
       Purchase_Order__c testPO = new Purchase_Order__c(Opportunity_Name__c=opp.Id);
       insert testPO; 
       
       ApexPages.currentPage().getParameters().put('id', testPO.Id);
       List<Purchase_Line_Item__c> lineItemList = new List<Purchase_Line_Item__c>();
       ApexPages.Standardsetcontroller con = new ApexPages.Standardsetcontroller(lineItemList);
       POExtension obj = new POExtension(con);
       system.debug('*************con**********'+obj);
       
       List<POExtension.purchaseOrderWrapper> getprod = obj.getProduct();
       system.debug('**************getprod**********'+getprod.size());
       system.assert(getprod.size()!=0) ;
                                     
       List<POExtension.purchaseOrderWrapper> wrapper = new List<POExtension.purchaseOrderWrapper>();
       
       Double unitPrice = 100;
       wrapper.add(new POExtension.purchaseOrderWrapper(product, unitPrice));
       for(POExtension.purchaseOrderWrapper wrap : wrapper){
       	 wrap.selected=true;
       	 wrap.quantityOfProduct='2';       	 
       }
       obj.getSelected();
       obj.setSelectedProduct(wrapper);
       
       List<POExtension.purchaseOrderWrapper> prod = obj.getSelectedProduct();
       system.debug('**************List prod**********'+prod);
       system.assert(prod.size()==1);       
       
       obj.save();
       
       String saveUrl = obj.save().getUrl();
       system.debug('*********saveUrl**********'+saveUrl);
       String id =String.valueOf((testPO.Id)).substring(0,15);
       system.assertEquals('/'+id,saveUrl);
       
       wrapper=null;
       obj.setSelectedProduct(wrapper);
       
       List<POExtension.purchaseOrderWrapper> prod1 = obj.getSelectedProduct();
       try{
         obj.save();
       }catch(Exception e){
       	  system.debug('************************'+e.getMessage());
       	  system.assert((e.getMessage()).contains('Please choose products to order '));
       } 
    }
}