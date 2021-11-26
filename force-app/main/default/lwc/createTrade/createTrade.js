import { LightningElement } from "lwc";

// import { ShowToastEvent } from "lightning/platformShowToastEvent";

import TRADE_OBJECT from "@salesforce/schema/Trade__c";
import SELL_CCY from "@salesforce/schema/Trade__c.Sell_Currency__c";
import SELL_AMOUNT from "@salesforce/schema/Trade__c.Sell_Amount__c";
import BUY__CCY from "@salesforce/schema/Trade__c.Buy_Currency__c";
import BUY_AMOUNT from "@salesforce/schema/Trade__c.Buy_Amount__c";
import RATE from "@salesforce/schema/Trade__c.Rate__c";

const FETCH_RATE_URL = "http://data.fixer.io/api/latest";

export default class CreateTrade extends LightningElement {
  tradeObject = TRADE_OBJECT;
  sellCcy = SELL_CCY;
  sellAmount = SELL_AMOUNT;
  buyCcy = BUY__CCY;
  buyAmount = BUY_AMOUNT;
  rate = RATE;

  initCallout = {};

  handleCaseCreated() {
    // Fire event for Toast to appear that Order was created
  }
  handleInputChange(event) {
    console.log(event.target.fieldName);
    console.log(event.target);
    this.initCallout[event.target.fieldName] = event.target.value;
    console.log(this.initCallout);
    this.doCallout();
  }

  doCallout() {
    if (
      this.initCallout.Sell_Currency__c &&
      this.initCallout.Sell_Amount__c &&
      this.initCallout.Buy_Currency__c
    ) {
      let url =
        FETCH_RATE_URL +
        "?access_key=b2dd3bc469487ef1af9ad2aaea908c3b" +
        "&base=" +
        this.initCallout.Sell_Currency__c +
        "&symbols=" +
        this.initCallout.Buy_Currency__c;
      console.log(url);

      fetch(url, {
        method: "GET", // *GET, POST, PUT, DELETE, etc.
        mode: "cors", // no-cors, *cors, same-origin
        cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
        credentials: "include", // include, *same-origin, omit
        headers: {
          "Content-Type": "application/json",
          // 'Content-Type': 'application/x-www-form-urlencoded'
          "Access-Control-Allow-Origin": "http://data.fixer.io/"
        },
        redirect: "follow", // manual, *follow, error
        referrerPolicy: "no-referrer-when-downgrade", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
        body: null // body data type must match "Content-Type" header
      })
        .then((response) => response.json()) // parses JSON response into native JavaScript objects
        .then((data) => console.log(data))
        .catch((error) => {
          console.error(error);
        });
    }
  }
}
