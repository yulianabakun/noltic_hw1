
import { LightningElement } from 'lwc';
import SVG_STAR from '@salesforce/resourceUrl/star1';


export default class MenuDemo extends LightningElement {
  svgURL = SVG_STAR + '#star'
  sampleOptions = [
    {
      label: 'something',
      value: 'something1',
      iconName: SVG_STAR + '#star'
    },
    {
      label: 'something 2',
      value: 'something2',
      iconName: SVG_STAR + '#star'
    },
    {
      label: 'something 3',
      value: 'something3',
      iconName: SVG_STAR + '#star'
    }
  ];


}