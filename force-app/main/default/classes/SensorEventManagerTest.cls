@isTest
public class SensorEventManagerTest {
    @isTest
    static void SensorEventManagerTest() {
        
        String sensorid = 'Name';
        List<Integer> line = new List<Integer> {10, 20, 30, 40, 50, 60};

        Test.startTest();
        SensorEventManager.createOrUpdateSensorInfo(sensorId, line);

        System.debug('Two lines inserted');

        System.assertEquals(2, [SELECT count() FROM Sensor_Event__c]);
        Test.stopTest();
    }
}