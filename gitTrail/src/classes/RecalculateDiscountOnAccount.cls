public with sharing class RecalculateDiscountOnAccount {

    //constructor
    public RecalculateDiscountOnAccount(){}
    
    public void recalculateDiscountOnAcc(List<Account> accountList){
    
        Double discount=0;
        Account__c getDiscount = Account__c.getValues('AllUser');
        system.debug('**********getDiscount*********'+getDiscount.Discount__c);
        List<Account> accList = new List<Account>();
        
        for(Account account :accountList){
            if(account.Amount__c != null){           
        	 discount = account.Amount__c - (account.Amount__c * (getDiscount.Discount__c)/100);
        	 system.debug('******************discount**************'+discount);
        	 account.Amount__c = discount;
        	 accList.add(account);
            }else{
            	account.Amount__c=0;
            }
        }        
    }
}