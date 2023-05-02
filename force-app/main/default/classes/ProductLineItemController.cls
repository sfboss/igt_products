public with sharing class ProductLineItemController {
    
    @AuraEnabled
    public static map<String,Object> getProductsData(String opportunityId){
        Map<String,Object> productsData = new Map<String,Object>();
        try {
            List<PricebookEntry> pricebookEntries = new List<PricebookEntry>();
            List<Product2> products =  ProductLineItemService.getJurisdictionProductLineItemsByOpportunity(opportunityId);
            pricebookEntries = [SELECT Id, UnitPrice, Product2Id FROM PricebookEntry WHERE Product2Id IN :products];
            productsData.put('products',products);
            productsData.put('pricebooks', pricebookEntries);
        } catch (Exception e) {
            productsData.put('errors',e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
        return productsData;
    }

    @AuraEnabled
    public static string saveLineItems(String products, String opportunityId){
        List<OpportunityLineItem> lineItems = new List<OpportunityLineItem>();
        try {
            List<Object> newLineItems = (List<Object>)JSON.deserializeUntyped(products);
            system.debug(newLineItems);
            for (Object obj : newLineItems){
                system.debug(obj);
                Map<String,Object> lineItem = ( Map<String,Object> )JSON.deserializeUntyped(JSON.serialize(obj));
                OpportunityLineItem oli = new OpportunityLineItem();
                oli.OpportunityId = opportunityId;
                oli.Product2Id = (String)lineItem.get('Id');
                oli.Quantity = Decimal.valueOf((String)lineItem.get('quantity'));
                oli.UnitPrice =  (Decimal)lineItem.get('salesprice');
                oli.Description = (String)lineItem.get('description');
                oli.ServiceDate = Date.valueOf((String)lineItem.get('date'));
                lineItems.add(oli);
            }
            upsert lineItems;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return JSON.serialize(lineitems);
    }

}
