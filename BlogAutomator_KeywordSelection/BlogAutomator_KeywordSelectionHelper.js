({
  getKeyWords: function (component, event, helper) {
    // use the fetchapi to get keywords from a salesforce org via the rest api
    var url =
      "https://seoboss-dev-ed.my.salesforce.com/services/data/v57.0/query/?q=SELECT+name+from+Account";
    var init = {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization:
          "Bearer 00D8Z000001rMLA!AQcAQHpQV0cis35v2HB15xa_3m4hQ0M5.xHI730DvgAG3evVjLnnAlcE6WgXQ8ETYmB_wjteIsmv.pVv7aO3iIDmcoKjz_J."
      },
      mode: "cors",
      cache: "default"
    };
    fetch(url, init)
      .then(function (response) {
        return response.json();
      })
      .then(function (data) {
        console.log(
          "%cBlogAutomator_HeaderMenuButtonsController.js line:26 firing",
          "color: #007acc;",
          "firing" + data
        );
        component.set("v.keywords", data);
      })
      .catch(function (error) {
        console.log(
          "%cBlogAutomator_HeaderMenuButtonsController.js line:26 firing",
          "color: #007acc;",
          "firing" + error
        );
      });
  }
});