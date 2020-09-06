@RestResource(urlMapping = '/Sensors')
global with sharing class SensorEventManager {
	@HttpPut
    global static void createOrUpdateSensorInfo(String sensorId, Integer[] line) {
    	Sensor__c sensor;
            List<Sensor__c> sensors = [SELECT Name FROM Sensor__c WHERE Name =: sensorId];
            
            if(sensors.size() == 1) {
				sensor = sensors.get(0);
            }
            else{
                sensor = new Sensor__c(
                    Name = sensorId
                );
                insert sensor;
        	}
            
            List<Sensor_Event__c> sensorEvents = new List<Sensor_Event__c>();
            for(Integer i = 0; i < line.size(); i+=3) {
                sensorEvents.add(new Sensor_Event__c(
                	X__c = line[i],
                	Y__c = line[i + 1],
                	Z__c = line[i + 2],
                	Sensor__c = sensor.Id));
            }
            
            insert sensorEvents;
            
            //must return only one record, which is related to some sensor or null if there are no events on this sensor 
            Sensor_Event__c lastEvent = [SELECT Name FROM Sensor_Event__c WHERE (Previous_Event__c = null AND Sensor__r.Name =: sensorId)];
            
            if(lastEvent != null) {
                lastEvent.Previous_Event__c = sensorEvents[0].Id;
            }
            
            for(Integer i = 1; i < sensorEvents.size(); i++) {
            	sensorEvents[i - 1].Previous_Event__c = sensorEvents[i].Id;   
            }

            upsert sensorEvents; 
    }
}