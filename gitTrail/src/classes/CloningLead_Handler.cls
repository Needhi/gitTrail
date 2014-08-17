public with sharing class CloningLead_Handler {

    //Constructor
    public CloningLead_Handler(){}
    
    public List<Lead> cloningLead(List<Lead> leadlist){
    	
    	CloningLead cloningLead = new CloningLead();
    	
    	List<Lead> leadLst = cloningLead.cloningSameLead(leadlist);
    	    	
    	return leadLst;
    	//return null;
    }

}