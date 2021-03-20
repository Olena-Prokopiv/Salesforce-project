@isTest
public with sharing class JobApplicationTriggerTest {
    @TestSetup
    static void makeData(){
        List<JobPosition__c> JobPositions = DataFactory.generatePositionRecords(250);
        List<Candidate__c> Candidates =  DataFactory.generateCandidateRecordsValid(250);
        
        insert JobPositions;
        insert Candidates;
    }
    
    @isTest
    static void  testVisa(){    
        List<JobPosition__c> JobPositions =[SELECT Id, Location__c FROM JobPosition__c];
        List<Candidate__c> Candidates= [SELECT Id,USA_visa_holder__c,USA_visa_valid_From__c,USA_visa_valid_To__c from Candidate__c ];
        List<JobApplication__c> JobApplications = DataFactory.generateApplicationRecords(JobPositions,Candidates,250);
        
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
            else
            {
                System.assert(results[k].isSuccess());
            }
            k++;
        }
    }
}