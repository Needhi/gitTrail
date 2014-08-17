public with sharing class POExtension {
    
    public Purchase_Line_Item__c record{get; set;} 
    public ApexPages.StandardSetController controller;
    public POExtension(ApexPages.StandardSetController controller){
    	this.controller = controller;    	    	
    }
    
    public POExtension(){}  
    
    public List<purchaseOrderWrapper> wrapperList = new List<purchaseOrderWrapper>();
    public List<purchaseOrderWrapper> selectedProduct = new List<purchaseOrderWrapper>();
    
    public class purchaseOrderWrapper{
        public Product2 procObj{get; set;}
        public boolean selected{get; set;}
        public String quantityOfProduct{get;set;}
        public Double unitPrice{get;set;}       
        public purchaseOrderWrapper(Product2 product , Double price){
            procObj = product;
            selected = false;
            unitPrice = price;
            //quantityOfProduct='1';
        }
    }
    
    public List<purchaseOrderWrapper> getProduct(){
    	                      
    	Purchase_Order__c oppId = [Select Opportunity_Name__c From Purchase_Order__c 
    	                           Where Id = :ApexPages.currentPage().getParameters().get('id')];  
    	system.debug('********************oppId*****'+oppId);
    	Opportunity pricebkId = [Select ChoosePriceBook__c From Opportunity Where Id = :oppId.Opportunity_Name__c];
    	system.debug('**************pricebkId************'+pricebkId); 
    	List<PricebookEntry> productObj = [Select UnitPrice, ProductCode, Product2Id From PricebookEntry 
    	                                   Where Pricebook2Id = :pricebkId.ChoosePriceBook__c];
    	system.debug('*******************productObj*****'+productObj);
    	for(PricebookEntry prodObj : productObj){                                                             
          for(Product2 prod : [Select Name, ProductCode, Description from Product2 Where ProductCode = :prodObj.ProductCode]){             
             wrapperList.add(new purchaseOrderWrapper(prod, Double.valueOf(prodObj.UnitPrice)));
          }
    	}
        return wrapperList;
    }

    public PageReference getSelected(){
        selectedProduct.clear();
        for(purchaseOrderWrapper obj : wrapperList){
            system.debug('****************************obj'+obj);
           if(obj.selected == true){           	  
              selectedProduct.add(obj);                
           }
        }       
        return null;
    }
    
    public List<purchaseOrderWrapper> getSelectedProduct(){
        if(selectedProduct==null||selectedProduct.size()>0){            
            return selectedProduct;
        }
        return null;
    }
    
    public void setSelectedProduct(List<purchaseOrderWrapper> selectedProduct){
        this.selectedProduct = selectedProduct;
    }
    
    public PageReference save(){
        system.debug('***********selectedProduct*********'+ selectedProduct);
        if(selectedProduct==null||selectedProduct.size()==0){
        	
            ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.Info ,'Please choose products to order!!');
            ApexPages.addMessage(errorMsg);
            return null;
        }               
        List<Purchase_Line_Item__c> lineItemList = new List<Purchase_Line_Item__c>();
        
        
        for(purchaseOrderWrapper pObbj : selectedProduct){
        	system.debug('***********pObbj.procObj.ProductCode**********'+pObbj.procObj.ProductCode);          
          List<PricebookEntry> price = [Select UnitPrice from PricebookEntry 
                                        Where ProductCode = :pObbj.procObj.ProductCode];
          system.debug('***********price******************'+price);          
            Purchase_Line_Item__c lineItemObj = new Purchase_Line_Item__c();
            
            lineItemObj.PurchaseOrder__c = ApexPages.currentPage().getParameters().get('id');
            lineItemObj.Product_Name__c = pObbj.procObj.Id;
            lineItemObj.Discount__c = 10;
            if(pObbj.quantityOfProduct==null || String.isBlank(pObbj.quantityOfProduct)){
              lineItemObj.Quantity__c = 1;
            }else{
              lineItemObj.Quantity__c = Integer.valueOf(pObbj.quantityOfProduct);
            }
            for(PricebookEntry p : price){
              lineItemObj.List_Price__c = p.UnitPrice;
            }
            lineItemObj.Total_Price__c = lineItemObj.Quantity__c*lineItemObj.List_Price__c ;
            lineItemObj.Total_Price_With_Discount__c = lineItemObj.Total_Price__c - (lineItemObj.Total_Price__c*(lineItemObj.Discount__c/100));
            lineItemList.add(lineItemObj);                   
        }
        //try{ 
            insert(lineItemList);            
        //}catch(DMLException e){
        /*    system.debug('************************'+e.getMessage());
            ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.Info ,e.getMessage());
            ApexPages.addMessage(errorMsg);
        }*/
        system.debug('************controller***************'+controller);  
        return controller.save();     
    }
}