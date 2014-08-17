public with sharing class TestFieldSetExt {

    public TestFieldSetExt(ApexPages.StandardController controller) {
        this.aObj = getDetails();
    }
    
    public List<a__c> aObj { get; set; }
        
    //getfields dynamicly
    public List<Schema.FieldSetMember> getFields() {        
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe();
        system.debug('*********'+GlobalDescribeMap );
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get('a__c');
        system.debug('*********'+SObjectTypeObj );
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        system.debug('*********'+DescribeSObjectResultObj );
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get('TestFieldSet');
        system.debug('*********'+fieldSetObj.getFields() );
        return fieldSetObj.getFields();    
    }   
    //query from fields
    public List<a__c> getDetails(){
        String query = 'SELECT ';
        for(Schema.FieldSetMember f : this.getFields()) {
            query += f.getFieldPath() + ', ';
        }
        query += 'Id FROM a__c ';
        return Database.query(query);
    }
}