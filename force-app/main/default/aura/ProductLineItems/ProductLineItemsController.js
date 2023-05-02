({
    handleToggle: function (component, event, helper) {
        // close quick action panel
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
    },
    handleSearchKeywords: function (component, event, helper) {
        if (event !== undefined && event.currentTarget !== undefined)
            var dataId = event.currentTarget.dataset.id;
        if (dataId === undefined) dataId = component.get("v.appData").seoKeyword;
        console.log(
            "%cBlogAutomator_HeaderMenuButtonsController.js line:26 firing",
            "color: #007acc;",
            "firing" + dataId
        );
        //fire appEvent
        var appEvent = $A.get("e.c:BlogAutomatorEvent");
        // set payload to renderBools
        appEvent.setParams({
            action: "getKeywordData",
            data: dataId
        });
        appEvent.fire();
    },
    doInit: function (component, event, helper) {
        helper.getProducts(component, event, helper);
    },
    handleRowSelection: function (component, event, helper) {
        var dataId = event.currentTarget.dataset.id;
        console.log('%cProductLineItemsController.js line:30 dataId', 'color: #007acc;', dataId);
        helper.updateRowSelected(component, event, helper, dataId);
    },
    handleRemoveProduct: function (component, event, helper) {

    },
    handleNext: function (component, event, helper) {
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
        var modalBody;
        $A.createComponent("c:ProductLineItemsConfirm", { products: component.get('v.products'), oppId: component.get('v.recordId') },
            function (content, status) {
                if (status === "SUCCESS") {
                    modalBody = content;
                    component.find('overlayLib').showCustomModal({
                        header: "Edit Selected Products",
                        body: modalBody,
                        showCloseButton: true,
                        cssClass: "mymodal",
                        closeCallback: function () {

                        }
                    })
                }
            });

    }
});
