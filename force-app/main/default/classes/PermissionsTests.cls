@isTest
private with sharing class PermissionsTests {
    @TestSetup
    static void testSetup(){
        PermissionsTestFactory.createTestData();
    }

    @isTest 
    static void PermissionTestPositive() {
        User user = PermissionsTestFactory.generateUser('system administrator');
        List<Sensor__c> sensors = new List<Sensor__c>();
        System.runAs(user){
            Test.startTest();
            sensors = [SELECT Id FROM Sensor__c];
            Test.stopTest();
        }
        System.assertEquals(1, sensors.size(), 'A Standard User without the permission set can not see any records');
    }

    @isTest
    static void PermissionSetTestPositive() {
        User user = PermissionsTestFactory.generateUser('standard user');
        PermissionSet permission = [SELECT Name FROM PermissionSet WHERE Name = 'AllowViewAllSensors'];
        PermissionSetAssignment assignment = new PermissionSetAssignment (PermissionSetId = permission.Id, AssigneeId = user.Id);
        insert(assignment);
        List<Sensor__c> sensors = new List<Sensor__c>();
        System.runAs(user){
            Test.startTest();
            sensors = [SELECT Id FROM Sensor__c];
            Test.stopTest();
        }
        System.assertEquals(1, sensors.size(), 'Pemission set allows Standard User profile to View all records of Sensor Object');
    }

    @isTest 
    static void PermissionTestNegative() {
        User user = PermissionsTestFactory.generateUser('standard user');
        Boolean isNoAccess = false;
        System.runAs(user){
            try{
                List<Sensor__c> sensors = SensorPickListController.getAllSensors();
            }catch(Exception e){
                isNoAccess = true;
            }
        }
        System.assert(isNoAccess, 'Exception happened');
    } 
}