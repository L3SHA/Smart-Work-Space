public with sharing class SensorPickListController {

    @AuraEnabled(cacheable = true)
    public static List<Sensor__c> getAllSensors() {

        if(!Schema.sObjectType.Sensor__c.isAccessible()) {
            throw new System.NoAccessException();
        }

        String [] expenseAccessFields = new String [] {'Id','Name'};

        Map<String,Schema.SObjectField> m = Schema.SObjectType.Sensor__c.fields.getMap();
 
        for (String fieldToCheck : expenseAccessFields) {
            if (!m.get(fieldToCheck).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }

        List<Sensor__c> sensors = [SELECT Name FROM Sensor__c];
        return sensors;
    }

    @AuraEnabled(cacheable = true)
    public static List<Sensor_Event__c> getSensorEvents(String sensorId) {

        if(!Schema.SObjectType.Sensor_Event__c.isAccessible()) {
            throw new System.NoAccessException();
        }

        String [] expenseAccessFields = new String [] {'Id','Name', 'X__c', 'Y__c', 'Z__c', 'Modulus_Difference_Vectors__c'};

        Map<String,Schema.SObjectField> m = Schema.SObjectType.Sensor_Event__c.fields.getMap();
 
        for (String fieldToCheck : expenseAccessFields) {
            if (!m.get(fieldToCheck).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }

        List<Sensor_Event__c> events = [SELECT Name, X__c, Y__c, Z__c,	Modulus_Difference_Vectors__c 
                                        FROM Sensor_Event__c WHERE Sensor__c =: sensorId];
        return events;
    }

}