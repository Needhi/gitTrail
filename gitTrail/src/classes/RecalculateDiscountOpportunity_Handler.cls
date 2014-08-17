public with sharing class RecalculateDiscountOpportunity_Handler {

  //constructor
  public RecalculateDiscountOpportunity_Handler(){}
  
  RecalculateDiscountOnOpportunity disAmt = new RecalculateDiscountOnOpportunity();
  public void recalculateDiscountHandler(List<Opportunity> oppList){
  	
     disAmt.recalculateDiscountOnOpportunity(oppList);
     
  }
}