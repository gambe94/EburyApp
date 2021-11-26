import { LightningElement, wire } from "lwc";

import getAllTrade from "@salesforce/apex/TradesController.getAllTrade";

const columns = [
  { label: "id", fieldName: "Name" },
  { label: "Sell CCY", fieldName: "Sell_Currency__c" },
  { label: "Sell Amount", fieldName: "Sell_Amount__c", type: "number" },
  { label: "Buy CCY", fieldName: "Buy_Currency__c" },
  { label: "Buy Amount", fieldName: "Buy_Amount__c", type: "number" },
  { label: "Rate", fieldName: "Rate__c", type: "number" },
  { label: "Date Booked", fieldName: "CreatedDate", type: "date" }
];

export default class ListTrades extends LightningElement {
  data = [];
  error;
  columns = columns;

  @wire(getAllTrade)
  wiredContacts({ error, data }) {
    if (data) {
      this.data = data;
      this.error = undefined;
    } else if (error) {
      this.error = error;
      this.data = undefined;
    }
  }
}
