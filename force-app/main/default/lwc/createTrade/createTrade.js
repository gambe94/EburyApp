import { LightningElement, wire, track } from "lwc";
import { getObjectInfo } from "lightning/uiObjectInfoApi";

import doRateCallout from "@salesforce/apex/RateCalloutService.doCallout";

import TRADE_OBJECT from "@salesforce/schema/Trade__c";
import SELL_CCY from "@salesforce/schema/Trade__c.Sell_Currency__c";
import SELL_AMOUNT from "@salesforce/schema/Trade__c.Sell_Amount__c";
import BUY__CCY from "@salesforce/schema/Trade__c.Buy_Currency__c";
import BUY_AMOUNT from "@salesforce/schema/Trade__c.Buy_Amount__c";
import RATE from "@salesforce/schema/Trade__c.Rate__c";

export default class CreateTrade extends LightningElement {
  tradeObject = TRADE_OBJECT;
  sellCcy = SELL_CCY;
  sellAmount = SELL_AMOUNT;
  buyCcy = BUY__CCY;
  buyAmount = BUY_AMOUNT;
  rate = RATE;
  rateVal;
  sellAmountVal;
  @track currencyList;

  @wire(getObjectInfo, { objectApiName: TRADE_OBJECT })
  objectInfo;

  get defaultRecordTypeId() {
    // Returns a map of record type Ids
    const rtis = this.objectInfo.data.recordTypeInfos;
    return Object.keys(rtis).find((rti) => rtis[rti].name === "Master");
  }

  get calculatedBuyAmount() {
    return this.rateVal * this.sellAmountVal;
  }
  get isCreateTradeDisabled() {
    return !this.rateVal;
  }

  initCallout = {};

  handleInputChange(event) {
    console.log(event.target.fieldName);
    console.log(event.target);
    this.initCallout[event.target.fieldName] = event.target.value;
    if (event.target.fieldName === "Sell_Amount__c") {
      this.sellAmountVal = event.target.value;
    }
    console.log(this.initCallout);
    this.fetchRate();
  }

  fetchRate() {
    if (
      this.initCallout.Sell_Currency__c &&
      this.initCallout.Sell_Amount__c &&
      this.initCallout.Buy_Currency__c
    ) {
      doRateCallout({
        isMock: true,
        baseCurrency: this.initCallout.Sell_Currency__c,
        targetCurrency: this.initCallout.Buy_Currency__c
      })
        .then((response) => {
          let data = JSON.parse(response);
          console.log(data);
          console.log(this.sellAmountVal);
          this.rateVal = data.rates[this.initCallout.Buy_Currency__c]; //data?.rates?.this.initCallout.Buy_Currency__c;
        })
        .catch((error) => console.error(error));
    }
  }

  handleTradeCreated(event) {
    console.log("handleTradeCreated", event.detail.id);
  }

  handleReset() {
    const inputFields = this.template.querySelectorAll("lightning-input-field");
    if (inputFields) {
      inputFields.forEach((field) => {
        field.reset();
      });
    }
    this.rateVal = undefined;
    this.sellAmountVal = undefined;
  }
}
