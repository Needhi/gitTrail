public with sharing class PurchaseLineItemDiscountCalc {

    //constructor
    public PurchaseLineItemDiscountCalc(){}
    
    public void calcDiscount(List<Purchase_Line_Item__c> newvalue){ 	
    	
    	for(Purchase_Line_Item__c lineitem : newvalue){    		
    		lineitem.Total_Price__c = lineitem.Quantity__c*lineitem.List_Price__c;
    		lineitem.Total_Price_With_Discount__c = lineitem.Total_Price__c - (lineitem.Total_Price__c *(lineitem.Discount__c/100));    		
    	}    	
    }

}