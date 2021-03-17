@isTest
public with sharing class JobPositionTriggerTest {
    @isTest
    static void testUpdateTitleForPracticeUnitSalesforce()
    {
        List<JobPosition__c> JobPositions = new List<JobPosition__c>();
        Contact contact=new Contact(LastName ='Klery');
        insert contact;
        
        for (Integer i = 0; i < 250; ++i) {
            if(math.mod(i,2)==1)
            {
                JobPositions.add(new JobPosition__c(Name = 'position'+i,CandidateLevel__c='Junior Software Engineer',Location__c='Ukraine',Practice_Unit__c='Salesforce',Priority__c='Low',Position_Budget__c=400+i, HR_Manager__c =contact.Id));
            }
            else
            {
                JobPositions.add(new JobPosition__c(Name = 'position'+i,CandidateLevel__c='Middle Software Engineer',Location__c='Poland',Practice_Unit__c='.Net',Priority__c='Low',Position_Budget__c=400+i, HR_Manager__c =contact.Id));
            }
        }
        insert JobPositions;
        
        List<JobPosition__c> UpdatedJobPositions = [SELECT Id,Name,Practice_Unit__c FROM JobPosition__c];
        
        for(JobPosition__c position:UpdatedJobPositions) {                 
            if(position.Practice_Unit__c=='Salesforce'){
                System.assert(position.Name.startsWith('SF-'));
            }
        }
    }
    
    @isTest
    static void testCreatedTask()
    {
        List<JobPosition__c> JobPositions = new List<JobPosition__c>();
        Contact contact=new Contact(LastName ='Klery',Email='kleryk@gmail.com');
        insert contact;
        
        for (Integer i = 0; i < 250; ++i) {
            JobPositions.add(new JobPosition__c(Name = 'position'+i,CandidateLevel__c='Junior Software Engineer',Location__c='Ukraine',Practice_Unit__c='Salesforce',Priority__c='Low',Position_Budget__c=400+i, HR_Manager__c =contact.Id));
        }
        insert JobPositions;
        
        for(JobPosition__c position:JobPositions) {                 
            position.Position_Budget__c=5200;
        }      
        
        Test.startTest();
        update JobPositions;
        Test.stopTest();
        
        
        List <Task> createdTask = [SELECT Subject, WhoId, OwnerId FROM Task];
        
        integer k=0;
        for(JobPosition__c updatedposition:JobPositions)
        {
            if(updatedposition.Position_Budget__c>5000)
            {
                System.assert(createdTask[k].Subject=='Review high budget position '+updatedposition.Name  );
            }
            k++;
        }
    }
}