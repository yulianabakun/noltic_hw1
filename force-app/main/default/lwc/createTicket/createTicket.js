import { LightningElement, api, wire } from 'lwc';
import createTicket from '@salesforce/apex/TicketController.createTicket';

export default class CreateTicket extends LightningElement {
    @api recordId;

    params = {};
    options = [
      { label: 'Economy', value: 'Economy'},
      { label: 'Business', value: 'Business'},
    ];

    handleChange(event) {
      this.params[event.target.name] = event.target.value;
    }
    async handleSubmit(event) {
       try {
         await createTicket({
           recordId: this.recordId,
           ...this.params
         })
       }
       catch(e) {
         console.error(e);
       }
    }
}