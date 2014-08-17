trigger RecalculateDiscountOnAccount on Account (before insert, before update) {

    if(trigger.isBefore){
    	if(trigger.isInsert || trigger.isUpdate){
    		
    		RecalculateDiscountOnAccount_Handler handler = new RecalculateDiscountOnAccount_Handler();
    		//handler.recalculateDiscount(trigger.new);
    	}
    }
}