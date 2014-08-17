public with sharing class PurchaseLineItemManuallyAddDis_Handler {

    //constructor
    public PurchaseLineItemManuallyAddDis_Handler(){}
    
    //method from which call BL method
    public void addDiscount(List<Purchase_Line_Item__c> newvalue){
        PurchaseLineItemDiscountCalc calcDiscount = new PurchaseLineItemDiscountCalc();
        calcDiscount.calcDiscount(newvalue);        	
    }

}