trigger PurchaseLineItemManuallyAddDiscount on Purchase_Line_Item__c (before update) {

    if(trigger.isBefore){
    	if(trigger.isUpdate){
    		//call handler
    		PurchaseLineItemManuallyAddDis_Handler handler = new PurchaseLineItemManuallyAddDis_Handler();
    		handler.addDiscount(trigger.new);    		
    	}
    }

}