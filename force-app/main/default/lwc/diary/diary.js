/**
 * Created by Yulisha on 8/24/2022.
 */

import { LightningElement, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord, deleteRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';

import getRelatedDiaries from '@salesforce/apex/ContactController.getRelatedDiaries';
import {reduceErrors} from 'c/ldsUtils';

import DIARY from '@salesforce/schema/Diary__c';
import CONTACT from '@salesforce/schema/Diary__c.Contact__c';
import NOTE from '@salesforce/schema/Diary__c.Note__c';

export default class Diary extends LightningElement {
  @api recordId;

  isLoading = false;
  @wire(getRelatedDiaries, { contactId: '$recordId' })
  diaries;

  async handleAdd(event) {
    const input = this.template.querySelector('lightning-input');

    this.isLoading = true;
    try {

      await createRecord({
        apiName: DIARY.objectApiName,
        fields: {
          [CONTACT.fieldApiName]: this.recordId,
          [NOTE.fieldApiName]: input.value
        }
      });

      await refreshApex(this.diaries);

      this.dispatchEvent(ShowToastEvent({
        title: 'Success',
        variant: 'success',
        message: 'Diary entry was created'
      }))
    }
    catch(e) {
      console.log(e);
      this.dispatchEvent(ShowToastEvent({
        title: 'Error',
        variant: 'error',
        message: reduceErrors(e)
      }))
    }
    finally {
      this.isLoading = false;
      input.value = "";
    }

  }

  async handleDelete(event) {
    const id = event.detail;
    this.isLoading = true;

    try {
      await deleteRecord(id);

      await refreshApex(this.diaries);

      this.dispatchEvent(ShowToastEvent({
        title: 'Success',
        variant: 'success',
        message: 'Diary entry was deleted'
      }))
    }
    catch(e) {
      this.dispatchEvent(ShowToastEvent({
        title: 'Error',
        variant: 'error',
        message: reduceErrors(e)
      }))
    }
    finally {
      this.isLoading = false;
    }
  }
}