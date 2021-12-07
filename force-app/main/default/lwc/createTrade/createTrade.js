import { LightningElement } from "lwc";

import doRateCallout from "@salesforce/apex/TradesController.getRate";

import TRADE_OBJECT from "@salesforce/schema/Trade__c";
import SELL_CCY from "@salesforce/schema/Trade__c.Sell_Currency__c";
import SELL_AMOUNT from "@salesforce/schema/Trade__c.Sell_Amount__c";
import BUY__CCY from "@salesforce/schema/Trade__c.Buy_Currency__c";
import BUY_AMOUNT from "@salesforce/schema/Trade__c.Buy_Amount__c";
import RATE from "@salesforce/schema/Trade__c.Rate__c";

import { ShowToastEvent } from "lightning/platformShowToastEvent";

// The delay used when debouncing event handlers before doing callout
const DELAY = 700;

export default class CreateTrade extends LightningElement {
  tradeObject = TRADE_OBJECT;
  sellCcy = SELL_CCY;
  sellAmount = SELL_AMOUNT;
  buyCcy = BUY__CCY;
  buyAmount = BUY_AMOUNT;
  rate = RATE;
  rateVal;
  sellAmountVal;
  isIntegrationError = false;

  get calculatedBuyAmount() {
    return this.rateVal * this.sellAmountVal;
  }
  get isCreateTradeDisabled() {
    return !this.rateVal && !this.isIntegrationError;
  }

  initCallout = {};

  handleInputChange(event) {
    console.log(event.target.fieldName);

    this.initCallout[event.target.fieldName] = event.target.value;
    if (event.target.fieldName === "Sell_Amount__c") {
      this.sellAmountVal = event.target.value;
    }

    // Debouncing this method: Do not actually fire the event as long as this function is
    // being called within a delay of DELAY. This is to avoid a very large number of Apex
    // method calls in components listening to this event.
    window.clearTimeout(this.delayTimeout);
    // eslint-disable-next-line @lwc/lwc/no-async-operation
    this.delayTimeout = setTimeout(() => {
      this.fetchRate();
    }, DELAY);
  }

  fetchRate() {
    if (
      this.initCallout.Sell_Currency__c &&
      this.initCallout.Sell_Amount__c &&
      this.initCallout.Buy_Currency__c
    ) {
      console.log("FIRE CALLOUT");
      doRateCallout({
        baseCurrency: this.initCallout.Sell_Currency__c,
        targetCurrency: this.initCallout.Buy_Currency__c
      })
        .then((rates) => {
          this.isIntegrationError = false;
          this.rateVal = rates[this.initCallout.Buy_Currency__c]; //data?.rates?.this.initCallout.Buy_Currency__c;
        })
        .catch((e) => {
          console.error(e);
          console.error("e.body.message => " + e.body.message);
          this.isIntegrationError = true;

          const event = new ShowToastEvent({
            title: "Integration error",
            message: e.body.message,
            variant: "error",
            mode: "sticky"
          });
          this.dispatchEvent(event);
        });
    }
  }

  handleTradeCreated(event) {
    let tradeId = event.detail.id;
    this.generateSuccessToast(tradeId);
    this.dispatchEvent(new CustomEvent("tradecreated"));
    this.closeModal();
  }

  handleCancel() {
    this.resetFields();
    this.closeModal();
  }

  generateSuccessToast(tradeId) {
    const event = new ShowToastEvent({
      title: "Success!",
      variant: "success",
      message: "Trade record created! See it {0}!",
      messageData: [
        {
          url: "/" + tradeId,
          label: "here"
        }
      ]
    });

    this.dispatchEvent(event);
  }

  resetFields() {
    const inputFields = this.template.querySelectorAll("lightning-input-field");
    if (inputFields) {
      inputFields.forEach((field) => {
        field.reset();
      });
    }
    this.rateVal = undefined;
    this.sellAmountVal = undefined;
    this.initCallout = undefined;
  }
  closeModal() {
    this.dispatchEvent(new CustomEvent("closemodal"));
  }
}
