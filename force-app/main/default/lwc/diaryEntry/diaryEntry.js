/**
 * Created by Yulisha on 8/24/2022.
 */

import { LightningElement, api } from 'lwc';

export default class DiaryEntry extends LightningElement {
  @api record;

  handleDelete() {
    this.dispatchEvent(new CustomEvent('delete', {
      detail: this.record.Id
    }));
  }
}