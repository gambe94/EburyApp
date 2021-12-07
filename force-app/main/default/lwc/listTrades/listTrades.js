import { api, LightningElement, wire } from "lwc";
import getAllTrade from "@salesforce/apex/TradesController.getAllTrade";
import { refreshApex } from "@salesforce/apex";

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
  columns = columns;

  @wire(getAllTrade)
  trades;

  @api
  refreshTable() {
    return refreshApex(this.trades)
      .then((result) => console.log(result))
      .catch((error) => console.error(error));
  }
}
