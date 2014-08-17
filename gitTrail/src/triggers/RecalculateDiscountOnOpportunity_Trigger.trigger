trigger RecalculateDiscountOnOpportunity_Trigger on Opportunity (before insert, before update) {

    RecalculateDiscountOpportunity_Handler handler = new RecalculateDiscountOpportunity_Handler();

	if(trigger.isBefore){
	  if(trigger.isInsert || trigger.isUpdate){
	  	// handler.recalculateDiscountHandler(trigger.new);
	  }			
	}
}