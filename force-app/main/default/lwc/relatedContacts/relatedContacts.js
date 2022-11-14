import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {reduceErrors} from 'c/ldsUtils';

import getRelatedContacts from '@salesforce/apex/AccountController.getRelatedContacts';
import createContact from '@salesforce/apex/AccountController.createContact';

export default class RelatedContacts extends LightningElement {
  isLoading = false;
  @api recordId;

  @wire(getRelatedContacts, { accountId: '$recordId' })
  contacts;

  showContactForm = false;

  handleAddContact(event){
    this.showContactForm = true;
  }

  handleSaveContact(event) {

    const lastName = this.template.querySelector('.lastName');
    this.isLoading = true;

    createContact({
      lastName: lastName.value,
      accountId: this.recordId
    })
      .then(() => this.dispatchEvent(ShowToastEvent({
        title: 'Success',
        variant: 'success',
        message: 'Contact has been created'
      })))
      .catch(error => this.dispatchEvent(ShowToastEvent({
        title: 'Error',
        variant: 'error',
        message: reduceErrors(error)
      })))
      .finally(() => {
        this.showContactForm = false;
        this.isLoading = false;
      });
  }
}