import { api, LightningElement } from "lwc";
import getAllTrade from "@salesforce/apex/TradesController.getAllTrade";

const columns = [
  { label: "Id", fieldName: "Name" },
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

  connectedCallback() {
    this.fetchRecords();
  }

  @api
  fetchRecords() {
    getAllTrade()
      .then((data) => {
        this.data = data;
        console.log("Gabor fecthing the records", data);
      })
      .catch((error) => {
        this.error = error;
        console.error(error);
      });
  }
}
