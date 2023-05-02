@isTest
public with sharing class ProductLineItemControllerTest {
    @TestSetup
    static void makeData(){
        // Create test data
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Product2 prod = new Product2(Name = 'Test Product', IsActive = true);
        insert prod;
        Product2 prod2 = new Product2(Name = 'Test Product 2 No Jurisdiction', IsActive = true);
        insert prod2;
        String pbId = Test.getStandardPricebookId();
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = pbId, Product2Id = prod.Id, UnitPrice = 100, IsActive = true);
        insert pbe;
        Opportunity opp = new Opportunity(Name = 'Test Opp', StageName = 'Closed Won', CloseDate = Date.today(), AccountId = acc.Id,Pricebook2Id = pbId);
        insert opp;
        Jurisdiction__c jurisdiction = new Jurisdiction__c();
        insert jurisdiction;
        JurisdictionProduct__c jp = new JurisdictionProduct__c(Product__c = prod.Id, Jurisdiction__c = jurisdiction.Id);
        insert jp;
        JurisdictionAccount__c ja = new JurisdictionAccount__c(Jurisdiction__c = jurisdiction.Id, Account__c = acc.Id);
        insert ja;

    }

     
    @isTest
    static void testGetProductsData(){
        // Call the method to be tested
        String oppId = [SELECT Id FROM Opportunity LIMIT 1].Id;
        String prodId = [SELECT Id FROM Product2 WHERE Name = 'Test Product'].Id;
        String pbeId = [SELECT Id FROM PricebookEntry WHERE Product2Id = :prodId].Id;
        Test.startTest();
        Map<String,Object> result = ProductLineItemController.getProductsData(oppId);
        Test.stopTest();

        // Verify the results return the product not matched on a Jurisdiction
        System.assertEquals(prodId, ((List<Product2>)result.get('products'))[0].Id);
        System.assertEquals(pbeId, ((List<PricebookEntry>)result.get('pricebooks'))[0].Id);
    }

    private static String getTestJSONForSave(){
        return '[{"Id":"01t8K000003It4yQAC","Name":"Test Product1","ProductCode":"Code","IsActive":true,"listPrice":100,"isSelected":true,"quantity":"12","salesprice":100,"date":"2023-05-26","description":"test1"},{"Id":"01t8K000003It5XQAS","Name":"Test Product2","ProductCode":"123","Description":"Test Product","Family":"None","IsActive":true,"listPrice":100,"isSelected":true,"quantity":"13","date":"2023-05-27","description":"test2","salesprice":200}]';
    }
}
