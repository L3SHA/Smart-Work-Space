public with sharing class SensorPickListController {

    @AuraEnabled(cacheable = true)
    public static List<Sensor__c> getAllSensors() {
        List<Sensor__c> sensors = [SELECT Name FROM Sensor__c];
        return sensors;
    }

    @AuraEnabled(cacheable = true)
    public static List<Sensor_Event__c> getSensorEvents(String sensorId) {
        List<Sensor_Event__c> events = [SELECT Name, X__c, Y__c, Z__c,	Modulus_Difference_Vectors__c 
                                        FROM Sensor_Event__c WHERE Sensor__c =: sensorId];
        return events;
    }
}