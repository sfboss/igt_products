({
    init: function (component, event, helper) {
        // Fetch component records
        var action = component.get("c.getComponents");
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Components: " + JSON.stringify(response.getReturnValue()));
                var components = response.getReturnValue();
                component.set("v.components", components);
            } else {
                console.log("Error fetching components: " + response.getError());
            }
        });
        $A.enqueueAction(action);
        let componentColumns = [
            { label: 'Name', fieldName: 'Name', type: 'text' },
            { label: 'Price', fieldName: 'Price__c', type: 'currency' },
            // add button
            {
                type: 'button',
                typeAttributes: {
                    label: 'Add',
                    name: 'add',
                    title: 'Add',
                    disabled: false,
                    value: 'add',
                    iconPosition: 'left'
                }
            }
        ];
        component.set("v.componentColumns", componentColumns);
    },

    saveProduct: function (component, event, helper) {
        // Save product logic goes here
    },

    addComponent: function (component, event, helper) {
        // Add component logic goes here
    },

    selectComponent: function (component, event, helper) {
        var selectedRow = event.getSource().get("v.data-row");
        var selectedComponent = component.get("v.components")[selectedRow];

        var selectedComponents = component.get("v.selectedComponents");
        selectedComponents.push(selectedComponent);
        component.set("v.selectedComponents", selectedComponents);

        // Update overall price logic goes here

    }
})
