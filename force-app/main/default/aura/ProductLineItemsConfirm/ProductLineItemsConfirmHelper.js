({
    handleSubmit: function (component, event, helper) {
        // call apex method saveLineItems and send up the products list
        var action = component.get("c.saveLineItems");
        console.log(JSON.stringify(component.get("v.products")));
        action.setParams({
            "products": JSON.stringify(component.get("v.products")),
            "opportunityId": component.get("v.oppId")
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // close the lightnig overlay
                console.log(response.getReturnValue());
                // force refresh the page
                // close the overlaylib
                component.find("overlayLib").notifyClose();
                $A.get('e.force:refreshView').fire();
            }
        }
        );
        $A.enqueueAction(action);

    }
})
