import { LightningElement } from "lwc";

export default class ModalView extends LightningElement {
  closeModal() {
    this.dispatchEvent(new CustomEvent("closemodal"));
  }
}
