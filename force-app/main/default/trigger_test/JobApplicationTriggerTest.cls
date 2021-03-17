@isTest
public with sharing class JobApplicationTriggerTest {
    @isTest
    static void  testVisa(){    
        List<JobApplication__c> JobApplications = new List<JobApplication__c>();
        List<JobPosition__c> JobPositions = new List<JobPosition__c>();
        List<Candidate__c> Candidates = new List<Candidate__c>();
        
        Contact contact=new Contact(LastName ='Klery', MailingCountry='USA');    
        insert contact;
        
        for (Integer i = 0; i < 250; ++i) {
            JobPositions.add(new JobPosition__c(Name = 'position'+i,CandidateLevel__c='Junior Software Engineer',Location__c= 'USA' ,Practice_Unit__c='Salesforce',Priority__c='Low',Position_Budget__c=400+i, HR_Manager__c =contact.Id));
            Candidates.add(new Candidate__c(Name = 'candidate'+i,Email__c='fortegroup@gmail.com',PhoneNumber__c='380504159832',Years_in_IT__c=1,USA_visa_holder__c=true,USA_visa_valid_From__c=Date.today()-i,USA_visa_valid_To__c=Date.today().addYears(1)+i) ) ;
            JobApplications.add(new JobApplication__c(Expected_Salary__c=300+i, JobPosition__c=JobPositions[i].Id,Candidate__c=Candidates[i].Id));
        }
        insert JobPositions;
        insert Candidates;
        
        Test.startTest();
        Database.SaveResult[] results = Database.insert(JobApplications, false);
        Test.stopTest();
        
        
        Map <Id,JobPosition__c> positionsMap = new Map  <Id,JobPosition__c> ([Select Id,Location__c from JobPosition__c ]);
        Map <Id,Candidate__c> candidatesMap = new  Map <Id,Candidate__c> ([Select Id,USA_visa_holder__c,USA_visa_valid_From__c,USA_visa_valid_To__c from Candidate__c ]);
        
        Integer k=0;
        for( JobApplication__c  applicationitem: JobApplications)
        {
            JobPosition__c position = positionsMap.get(applicationitem.JobPosition__c);
            Candidate__c candidate= candidatesMap.get(applicationitem.Candidate__c);
            if(position.Location__c == 'USA' && (candidate.USA_visa_holder__c==false || candidate.USA_visa_valid_From__c>Date.Today() || candidate.USA_visa_valid_To__c<Date.Today().addYears(1)))
            {                  
                System.assert(!results[k].isSuccess());
                System.assert(results[k].getErrors().size() > 0);
                System.assertEquals('You can not apply for this job due to your US visa expiration date.', results[k].getErrors()[0].getMessage());
            }
            k++;
        }
    }
}