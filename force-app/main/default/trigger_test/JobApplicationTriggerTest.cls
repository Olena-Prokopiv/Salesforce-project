@isTest
public with sharing class JobApplicationTriggerTest {
    @isTest
    static void  testVisa(){    
        List<JobApplication__c> JobApplications = new List<JobApplication__c>();
        List<JobPosition__c> JobPositions = new List<JobPosition__c>();
        List<Candidate__c> Candidates = new List<Candidate__c>();
        
        Contact contact=new Contact(LastName ='Olena', MailingCountry='USA');    
        insert contact;
        
        for (Integer i = 0; i < 250; ++i) {
            JobPositions.add(new JobPosition__c(Name = 'developer'+i,CandidateLevel__c='Junior Software Engineer',Location__c='USA',Practice_Unit__c='Salesforce',Priority__c='Low',Position_Budget__c=400+i, HR_Manager__c =contact.Id));
            Candidates.add(new Candidate__c(Name = 'candidate'+i,Email__c='fortegroup@gmail.com',PhoneNumber__c='380504159832',Years_in_IT__c=1,USA_visa_holder__c=true,USA_visa_valid_From__c=Date.today()-(2+i),USA_visa_valid_To__c=Date.today().addYears(1)+i) ) ;
            JobApplications.add(new JobApplication__c(Expected_Salary__c=300+i, JobPosition__c=JobPositions[i].Id,Candidate__c=Candidates[i].Id));
        }
        insert JobPositions;
        insert Candidates;
        
        Test.startTest();
        Database.SaveResult[] results = Database.insert(JobApplications, false);
        Test.stopTest();
        for(Database.SaveResult dr : results) {
            System.assert(!dr.isSuccess());
            System.assert(dr.getErrors().size() > 0);
        }
        List<JobApplication__c> NewApplication = [SELECT Id,JobPosition__c,Candidate__c FROM JobApplication__c];
        
        /*     for(JobApplication__c application:NewApplication) {                 
JobPosition__c newPosition=[Select Id,Location__c from JobPosition__c where Id = :application.JobPosition__c];
Candidate__c newCandidate=[Select Id,USA_visa_holder__c,USA_visa_valid_From__c,USA_visa_valid_To__c from Candidate__c where Id = :application.Candidate__c];

if(!(newPosition.Location__c == 'USA' && newCandidate.USA_visa_holder__c==true && newCandidate.USA_visa_valid_From__c<=Date.Today() && newCandidate.USA_visa_valid_To__c>=Date.Today().addYears(1)))
{

}
*/
    }
}