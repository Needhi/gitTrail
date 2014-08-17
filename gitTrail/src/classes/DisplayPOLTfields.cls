public with sharing class DisplayPOLTfields {

    public List<Purchase_Line_Item__c> getpList{get;set;}
    public DisplayPOLTfields(ApexPages.StandardController controller) {
       system.debug('*****************'+controller.getRecord());
       Purchase_Order__c record = (Purchase_Order__c)controller.getRecord();
       /*List<Purchase_Order__c> getList = [Select (Select Product_Name__c, Quantity__c, Discount__c 
                                                  From Purchase_Line_Items__r) 
                                          From Purchase_Order__c ];*/
      
        getpList =[Select Quantity__c,  Product_Name__r.Name, Discount__c ,List_Price__c, Total_Price_With_Discount__c
                                              From Purchase_Line_Item__c 
                                              Where PurchaseOrder__c = :record.Id];
       system.debug('*********************'+getpList);
         
    }

}