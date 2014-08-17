public with sharing class testSalesforce1Controller {
	
	public String[] EducationList = new String[]{};	
	public string Name {get; set;}
	public List<SelectOption> getItems(){
		List<SelectOption> listOptions = new List<SelectOption>();
		listOptions.add(new SelectOption('bcs','BCS'));
		listOptions.add(new SelectOption('bca','BCA'));
		listOptions.add(new SelectOption('mcs','MCS'));
		listOptions.add(new SelectOption('mca','MCA'));
		return listOptions;
	}
	
	public string[] getEducationList(){
		return EducationList;		
	}
	
	public void setEducationList(String[] EducationList){
		this.EducationList = EducationList;
	}
	
	public PageReference check(){
		system.debug('*****************'+EducationList);	
		return null;
	}	
}