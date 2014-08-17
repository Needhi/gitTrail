public with sharing class CampaignController {
	
	String campaignOption;
	public Boolean Section {get;set;}
	public Boolean pagination {get; set;}
	public PageReference redirectPage;
	public List<Campaign> campaignRecords = new List<Campaign>();
	//constructor
	public CampaignController(){
		Section=false;
		pagination = false;		
	}
	
	Integer pageSize =2;
	Integer pgNum =0;
	//This is for second commit
	//View Options
	public List<SelectOption> getListViewOptions(){
		List<SelectOption> viewOptions = new List<SelectOption>();
		
		//SelectOption param-> itemValue and itemLabel
		viewOptions.add(new SelectOption('Recently Modified','Recently Modified')); 
		viewOptions.add(new SelectOption('All Campaigns','All Campaigns'));
	    viewOptions.add(new SelectOption('All Active Campaigns','All Active Campaigns'));
	    viewOptions.add(new SelectOption('My Active Campaigns','My Active Campaigns'));
	    viewOptions.add(new SelectOption('InActive Campaigns','InActive Campaigns'));
	    
	    return viewOptions;
	}
	
	public String getCampaignOption(){
		return campaignOption;
	} 
	
	public void setCampaignOption(String campaignOption){
		this.campaignOption = campaignOption;
	}	
	
	//get for fetched records to save for campaign option
	public List<Campaign> getCampaignRecords(){
		return campaignRecords;
	}
	//set method
	public void setCampaignRecords(List<Campaign> campaignRecords){
		this.campaignRecords = campaignRecords;
	}
	
	//Button Action - SelectCampAction
	public void SelectCampAction(){
		
		Integer offSet = pageSize * pgNum;
		String queryStr;
		
		//selected campaign option its respective data
		if(campaignOption == 'Recently Modified'){
			queryStr = 'Select Name, Status, Type, StartDate From Campaign ORDER BY LastModifiedDate DESC';
			                   
			queryStr = queryStr + ' LIMIT '+pageSize +' OFFSET '+ offSet;
			campaignRecords = Database.query(queryStr);			
		
		}else if(campaignOption == 'All Campaigns'){
			queryStr = 'Select Name, Status, Type, StartDate From Campaign ORDER BY StartDate DESC';
			                   
			queryStr = queryStr + ' LIMIT '+pageSize +' OFFSET '+ offSet;
			campaignRecords = Database.query(queryStr);
			
		}else if(campaignOption == 'All Active Campaigns'){
			queryStr = 'Select Name, Status, Type, StartDate From Campaign Where IsActive = true ORDER BY StartDate DESC';
			
			queryStr = queryStr + ' LIMIT '+pageSize +' OFFSET '+ offSet;
			campaignRecords = Database.query(queryStr);
			
		}else if(campaignOption == 'My Active Campaigns'){
			//get logged in user id
            Id loggedInUser = UserInfo.getUserId();
            system.debug('******************loggedinUser****'+loggedInUser);
			queryStr = 'Select Name, Status, Type, StartDate From Campaign Where IsActive = true AND OwnerID = :loggedInUser ORDER BY StartDate DESC';
			
			queryStr = queryStr + ' LIMIT '+pageSize +' OFFSET '+ offSet;
			campaignRecords = Database.query(queryStr);
			system.debug('*************************campaignRecords******'+campaignRecords);
			
		}else if(campaignOption == 'InActive Campaigns'){
			
			queryStr = 'Select Name, Status, Type, StartDate From Campaign Where IsActive = false ORDER BY StartDate DESC';			                   
			queryStr = queryStr + ' LIMIT '+pageSize +' OFFSET '+ offSet;
			campaignRecords = Database.query(queryStr);						
		}		
		Section = true;
		pagination = true;		
	}
	
	public PageReference linkIsClickedAction(){
		//invoke CM_Campaign_Detail_page to show detail view info		
		 redirectPage = new PageReference('/apex/CM_Campaign_Detail_page');		
		
		redirectPage.getParameters().put('Parameter',ApexPages.currentPage().getParameters().get('id'));
		redirectPage.setRedirect(true);
		system.debug('****************************************'+redirectPage);		
		
		return redirectPage;		
	}
	
	//Pagination part
	public PageReference previous(){
		pgNum--;
		
		if(pgNum<0){
			return null;
		}
		SelectCampAction();
		return null;
	}
	
	public PageReference next(){
		
		pgNum++;
		SelectCampAction();
		return null;
	}

}