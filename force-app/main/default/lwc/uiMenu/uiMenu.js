import { LightningElement, api } from 'lwc';


export default class UiMenu extends LightningElement {
  @api options = [];
  @api iconName;
  isDetailsVisible = false;



  handleClick(){
    if(this.isDetailsVisible){
      this.isDetailsVisible = false;
    }else{
      this.isDetailsVisible = true;
    }
  }
}