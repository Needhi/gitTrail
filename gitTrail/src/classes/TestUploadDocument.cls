/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestUploadDocument {

    static testMethod void myUnitTest() {
        Test.StartTest();
		Account acc=new Account(Name='Acme Inc');
        insert acc;
        system.debug('*******acc*******'+acc);
        ApexPages.currentPage().getParameters().put('EntityId', acc.id);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(acc);
        UploadDocumentController controller1=new UploadDocumentController(sc);
         
        UploadDocumentController controller=new UploadDocumentController();
 		controller.objAccount = acc;
 		
        Attachment attch = new Attachment();        
        attch.Name = 'TestClassAttachment';
        attch.Body = Blob.valueOf('TestClassAttachment body');
        controller.attachment = attch;
        controller.upload();
        
        List<Attachment> attachments=[select id, name from Attachment where parent.id=:acc.id];
        System.assertEquals(1, attachments.size());
		
		Attachment attch1 = new Attachment();
		controller.attachment = attch1;
        controller.upload();
        
        List<Attachment> attachments1=[select id, name from Attachment where parent.id=:acc.id];
        System.assertEquals(1, attachments1.size());
        
		controller.cancel();
		Test.StopTest();
    }
}