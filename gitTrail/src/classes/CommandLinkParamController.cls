public with sharing class CommandLinkParamController{
	
	public String Id  {get; set;}
	public Campaign campaign ;	
	
	//constructor
	public CommandLinkParamController(){} 
	
	public CommandLinkParamController(ApexPages.StandardController controller){
		
		Map<String, String> param = ApexPages.currentPage().getParameters();
		system.debug('****************detail************'+param);
		for(String value : param.values()){
			Id = value;
		}
		system.debug('*************id*************'+Id);
		
		
	}//constructor
	
	public Campaign getCampaign() {
		campaign = [Select Name, StartDate, EndDate, Description, Status, Type,
		            ParentId, OwnerId, CreatedById , LastModifiedById, NumberSent
		            From Campaign Where Id = :Id];
		system.debug('***************************campaign****' + campaign);            
	    return campaign;        
		    		
	}
	
	public void setCampaign(Campaign campaign){
		this.campaign = campaign;
	} 
	
}