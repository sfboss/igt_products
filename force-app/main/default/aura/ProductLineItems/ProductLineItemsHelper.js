({
    getProducts: function (component, event, helper) {
        // use the fetchapi to get keywords from a salesforce org via the rest api
        let action = component.get("c.getProductsData");
        action.setParams({ opportunityId: component.get("v.recordId") });    // set the opportunityId parameter to the recordId of the component
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let productData = response.getReturnValue();
                console.log('%cProductLineItemsHelper.js line:11 products', 'color: #007acc;', productData);

                this.updateProductsAddListPriceFromPricebook(component, event, helper, productData);
            }
        });
        $A.enqueueAction(action);
    },
    updateRowSelected: function (component, event, helper, theId) {
        let theProductData = component.get("v.products");
        let theProduct = theProductData.find((product) => product.Id === theId);
        theProduct.isSelected = !theProduct.isSelected;
        component.set("v.products", theProductData);
        // add theProduct to the selectedProducts attribute
        this.updateSelectedProducts(component, event, helper, theProductData);

    },
    updateSelectedProducts: function (component, event, helper, productData) {
        let theProductData = productData;
        let selectedProducts = [];
        theProductData.forEach((product) => {
            if (product.isSelected) {
                selectedProducts.push(product.Name);
            }
        });
        component.set("v.selectedProducts", selectedProducts);
        let theNumItems = component.get("v.selectedProducts").length;
        component.set("v.numItemsSelected", theNumItems);
    },
    updateProductsAddListPriceFromPricebook: function (component, event, helper, productData) {
        console.log('inside new method');
        // loop through the products and pricebookentries vars and if the Id from product matches product2id from pricebookentries, update listValue on product record
        let theProducts = productData.products;
        let thePricebooks = productData.pricebooks;
        console.log('%cProductLineItemsHelper.js line:44 theProducts', 'color: #007acc;', theProducts);
        console.log('%cProductLineItemsHelper.js line:45 thePricebooks', 'color: #007acc;', thePricebooks);
        theProducts.forEach((product) => {
            thePricebooks.forEach((pricebook) => {
                console.log('%cProductLineItemsHelper.js line:48 product', 'color: #007acc;', product);
                console.log('%cProductLineItemsHelper.js line:48 product', 'color: #007acc;', pricebook);
                if (product.Id === pricebook.Product2Id) {
                    product.listPrice = pricebook.UnitPrice;
                }
            });
        });
        component.set("v.products", theProducts);
    }
});
