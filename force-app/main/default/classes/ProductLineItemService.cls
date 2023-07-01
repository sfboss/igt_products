public with sharing class ProductLineItemService {
    public static List<Product2> getJurisdictionProductLineItemsByOpportunity(String opportunityId){
        List<Product2> products  = new List<Product2>();
        try {
            String pricebookIdForOpportunity = [SELECT Pricebook2Id FROM Opportunity WHERE Id = :opportunityId].Pricebook2Id;
            List<String> jurisdictionIds = new List<String>();
            String jurisdictionIdsStr = [SELECT Jurisdictions__c FROM Account WHERE Id IN (SELECT AccountId FROM Opportunity WHERE Id = :opportunityId)].Jurisdictions__c;
            if(jurisdictionIdsStr != null && jurisdictionIdsStr != ''){
                jurisdictionIds = jurisdictionIdsStr.split(',');
            } 
            products = [SELECT Id, Name, ProductCode, Description, Family, IsActive FROM Product2 WHERE Id IN (SELECT Product2Id FROM PricebookEntry WHERE Pricebook2Id = :pricebookIdForOpportunity) AND Id IN (SELECT Product__c FROM JurisdictionProduct__c WHERE Jurisdiction__c IN :jurisdictionIds)];
        } catch (Exception e) {
            system.debug(e.getMessage() + ' - ' + e.getStackTraceString());
        }
        return products;
    }

    @AuraEnabled
    public static Component__c[] getComponents(){
        try {
           return [SELECT Name,Price__c FROM Component__c];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
