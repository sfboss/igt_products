({
  handleToggle: function (component, event, helper) {
    // get the HTML element's data-id attribute
    if (event !== undefined && event.currentTarget !== undefined)
      var dataId = event.currentTarget.dataset.id;
    console.log(
      "%cBlogAutomator_HeaderMenuButtonsController.js line:26 firing",
      "color: #007acc;",
      "firing" + dataId
    );
    //fire appEvent
    var appEvent = $A.get("e.c:BlogAutomatorEvent");
    // set payload to renderBools
    appEvent.setParams({
      action: "renderBools",
      data: dataId
    });
    appEvent.fire();
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
    // helper.getKeyWords(component, event, helper);
  },
  handleRowSelection: function (component, event, helper) {
    var dataId = event.currentTarget.dataset.id;
    console.log(
      "%cBlogAutomator_HeaderMenuButtonsController.js line:26 firing",
      "color: #007acc;",
      "firing" + dataId
    );
    //fire appEvent
    var appEvent = $A.get("e.c:BlogAutomatorEvent");
    // set payload to renderBools
    appEvent.setParams({
      action: "keywordSelection",
      data: dataId
    });
    appEvent.fire();
  }
});