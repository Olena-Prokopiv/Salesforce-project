@isTest
public with sharing class JobPositionTriggerTest {
    @TestSetup
    static void makeData(){
        List<JobPosition__c> JobPositions = DataFactory.generatePositionRecords(250);
        insert JobPositions;
    }
    
    @isTest
    static void testUpdateTitleForPracticeUnitSalesforce()
    {
        List<JobPosition__c> JobPositions = [SELECT Id,Name,Practice_Unit__c FROM JobPosition__c];
        
        for(JobPosition__c position:JobPositions) {                 
            if(position.Practice_Unit__c=='Salesforce'){
                System.assert(position.Name.startsWith('SF-'));
            }
            else if(position.Practice_Unit__c=='Java'){
                System.assert(position.Name.startsWith('J-'));
            }
            else if(position.Practice_Unit__c=='Python'){
                System.assert(position.Name.startsWith('PY-'));
            }
            else if(position.Practice_Unit__c=='PHP'){
                System.assert(position.Name.startsWith('PHP-'));
            }
            else if(position.Practice_Unit__c=='.Net'){
                System.assert(position.Name.startsWith('C#-'));
            }
        }
    }
    
    @isTest
    static void testCreatedTask()
    {
        List<JobPosition__c> JobPositions = [SELECT Id,Name,CandidateLevel__c,Position_Budget__c FROM JobPosition__c];
        
        
        for(JobPosition__c position:JobPositions) {
            if(position.CandidateLevel__c=='Middle Software Engineer')
            {
                position.Position_Budget__c=5200;
            }
        }      
        
        Test.startTest();
        update JobPositions;
        Test.stopTest();
        
        
        List <Task> createdTask = [SELECT Id FROM Task WHERE Subject LIKE 'Review high budget position %'];
        
        integer count=0,count2;
        for(JobPosition__c updatedposition:JobPositions)
        {
            if(updatedposition.Position_Budget__c>5000)
            {
                count++;      
            }
        }
        System.assertEquals(count,createdTask.size());
        
    }
    @isTest
    static void testNotCreatedTask()
    {
        List<JobPosition__c> JobPositions = [SELECT Id,Name,CandidateLevel__c,Position_Budget__c FROM JobPosition__c];
        
        
        for(JobPosition__c position:JobPositions) {
            if(position.CandidateLevel__c=='Middle Software Engineer')
            {
                position.Position_Budget__c=4800;
            }
        }      
        
        Test.startTest();
        update JobPositions;
        Test.stopTest();
        
        List <Task> createdTask = [SELECT Id FROM Task WHERE Subject LIKE 'Review high budget position %'];
        System.assertEquals(0,createdTask.size());
    }
}