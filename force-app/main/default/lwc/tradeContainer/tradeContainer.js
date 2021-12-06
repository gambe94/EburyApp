import { LightningElement, wire } from "lwc";
import { getObjectInfo } from "lightning/uiObjectInfoApi";

import TRADE_OBJECT from "@salesforce/schema/Trade__c";

const ICON_NAME = "custom:custom40";

export default class TradeContainer extends LightningElement {
  iconName = ICON_NAME;
  isModalOpen = false;
  @wire(getObjectInfo, { objectApiName: TRADE_OBJECT })
  objectInfo;

  get defaultRecordTypeId() {
    // Returns a map of record type Ids
    const rtis = this.objectInfo.data.recordTypeInfos;
    return Object.keys(rtis).find((rti) => rtis[rti].name === "Master");
  }

  createTrade() {
    this.openModal();
  }

  openModal() {
    // to open modal set isModalOpen tarck value as true
    this.isModalOpen = true;
  }

  handleClick(event) {
    console.log(event.target);
    console.log(this.defaultRecordTypeId);
    console.log(this.objectInfo.recordTypeInfos);
    console.log(this.objectInfo.themeInfo.iconUrl);
  }
  tradeCreated() {
    console.log("Catch the event tradeCreated");
    this.template.querySelector("c-list-trades").fetchRecords();
  }

  closeModal() {
    console.log("Close MOdal subsriber container");
    this.isModalOpen = false;
  }
}
