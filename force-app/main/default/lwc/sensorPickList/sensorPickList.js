import { LightningElement, wire} from 'lwc';
import sensorsList from '@salesforce/apex/SensorPickListController.getAllSensors';
import eventsList from '@salesforce/apex/SensorPickListController.getSensorEvents';

export default class SensorPickList extends LightningElement {

    @wire(sensorsList) sensors;
    events;
  
    onShowSensorInfo(event){
      eventsList({id: event.target.value})
      .then(result => {
          this.events = result;
      });
    }

}