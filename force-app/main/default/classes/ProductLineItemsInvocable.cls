public class ProductLineItemsInvocable {
    
    public class Request {
        @InvocableVariable(label='Opportunity Id' required=true)
        public Id opportunityId;
    }
    
    @InvocableMethod(label='Get Products by Opportunity Id')
    public static List<Product2> getProductsByOpportunityId(List<Request> requests) {
        Id opportunityId = requests[0].opportunityId;
        List<Product2> productLineItems = ProductLineItemService.getJurisdictionProductLineItemsByOpportunity(opportunityId);  
        return productLineItems;
    }
}
