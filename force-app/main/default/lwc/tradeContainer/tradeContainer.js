import { LightningElement } from "lwc";

const ICON_NAME = "custom:custom40";

export default class TradeContainer extends LightningElement {
  iconName = ICON_NAME;
  isModalOpen = false;

  createTrade() {
    this.openModal();
  }

  openModal() {
    this.isModalOpen = true;
  }

  tradeCreated() {
    this.template.querySelector("c-list-trades").refreshTable();
  }

  closeModal() {
    this.isModalOpen = false;
  }
}
