@isTest
public with sharing class JobPositionTriggerTest {
    @isTest
    static void testUpdateTitleForPracticeUnitSalesforce()
    {
        List<JobPosition__c> JobPositions = new List<JobPosition__c>();
        Contact contact=new Contact(LastName ='Olena');
        insert contact;
        
        for (Integer i = 0; i < 250; ++i) {
             JobPositions.add(new JobPosition__c(Name = 'developer'+i,CandidateLevel__c='Junior Software Engineer',Location__c='Ukraine',Practice_Unit__c='Salesforce',Priority__c='Low',Position_Budget__c=400+i, HR_Manager__c =contact.Id));
        }
        for (Integer i = 250; i < 500; ++i) {
             JobPositions.add(new JobPosition__c(Name = 'developer'+i,CandidateLevel__c='Junior Software Engineer',Location__c='Ukraine',Practice_Unit__c='.Net',Priority__c='Low',Position_Budget__c=400+i, HR_Manager__c =contact.Id));
        }
        insert JobPositions;
        
        List<JobPosition__c> UpdatedJobPositions = [SELECT Id,Name,Practice_Unit__c FROM JobPosition__c];
        
         for(JobPosition__c position:UpdatedJobPositions) {                 
             if(position.Practice_Unit__c=='Salesforce'){
       	 System.assert(position.Name.startsWith('SF-'));
             }
            }
        }
    }
}