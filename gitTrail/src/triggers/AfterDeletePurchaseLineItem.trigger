trigger AfterDeletePurchaseLineItem on Purchase_Line_Item__c (after delete) {

	Set <Id> setId =new Set <Id> () ;
	if(trigger.isAfter){
		Set<Purchase_Line_Item__c> objLineItem = new Set<Purchase_Line_Item__c>();
		
		for(Purchase_Line_Item__c obj :trigger.old){
			objLineItem.add(obj);
			setId.add(obj.Id);
			system.debug('Deleted record parent id : ' + obj.PurchaseOrder__c + ' self id :'+ obj.Id);
		}
		system.debug('****************'+setId);
			
	}

}
/*
public with sharing class oppLineItemTriggerHandler {
    Set <Id> oliIds=new Set <Id>();
    public void isAfterInsert(List<OpportunityLineItem> oliList){

        for (OpportunityLineItem oli:oliList){
            if (oli.OpportunityId!=null){
                oliIds.add(oli.OpportunityId);
            }
        }

        List <Opportunity> oList=[SELECT Id,ChildoliAmtSum__c FROM Opportunity WHERE Id IN :oliIds];
        Map <Id,Opportunity> opMap=new Map <Id,Opportunity>();
        for (Opportunity o:oList){
            opMap.put(o.Id,o);
        }
        List<Opportunity> ol=new List<Opportunity>();
        for (OpportunityLineItem oli:oliList){
            if (oli.OpportunityId!=null){
                Opportunity op=opMap.get(oli.OpportunityId);
                system.debug('**********op '+op);
                if (op!=null){
                    system.debug('**********op.ChildoliAmtSum__c '+op.ChildoliAmtSum__c);
                    system.debug('**********oli.UnitPrice '+oli.UnitPrice);
                    op.ChildoliAmtSum__c+=oli.UnitPrice;
                    ol.add(op);
                }
            }
        }
        update ol;
    }

    Set <Id> setId =new Set <Id> () ;
    public void isAfterDelete( List<OpportunityLineItem> l ) {

        for ( OpportunityLineItem ilo : l) {
             setId.add( ilo.OpportunityId );
        }
        /*List < Opportunity > ol =[SELECT Id, ChildoliAmtSum__c FROM Opportunity WHERE Id IN:old ];
        Map < Id,Opportunity > mol = new Map < Id,Opportunity > ();
        
        for ( Opportunity lo : ol ) {
              mol.put( lo.Id,lo );
        }
        List < Opportunity > l = new List < Opportunity >();*/

    /*}*/