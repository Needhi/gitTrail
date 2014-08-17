public with sharing class MyCustomLookupController {

    public MyCustomLookupController(ApexPages.StandardController controller) {
          system.debug('****************'+controller.getRecord());
    }


	public Opportunity opportunity {get;set;}

	public MyCustomLookupController() {
		opportunity = new Opportunity();
	}
	
	public PageReference Save(){
		PageReference page = new PageReference('/'+opportunity.Id);
		page.setRedirect(true);
		return page;
	}
}