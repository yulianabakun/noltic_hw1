/**
 * Created by Yulisha on 8/16/2022.
 */

import { LightningElement } from 'lwc';

export default class ContactList extends LightningElement {
   contacts = [
       {
         Id: 1,
         FirstName: 'Ivan',
         LastName: 'Bakun',
         Email: 'ivanbakun.new@gmail.com',
       },
       {
         Id: 2,
         FirstName: 'Kia',
         LastName: 'Sport',
         Email: 'kiasport@gmail.com',
       },
       {
         Id: 3,
         FirstName: 'Opel',
         LastName: 'Red',
         Email: 'kiasport@gmail.com',
       }
     ]
}