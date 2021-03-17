public with sharing class JobApplicationTriggerHelper {
    public static void checkVisaDate(List<JobApplication__c> JobApplications){
        Map <Id,JobPosition__c> positions = new Map  <Id,JobPosition__c> ([Select Id,Location__c from JobPosition__c ]);
        Map <Id,Candidate__c> candidates = new  Map <Id,Candidate__c> ([Select Id,USA_visa_holder__c,USA_visa_valid_From__c,USA_visa_valid_To__c from Candidate__c ]);
        
        for( JobApplication__c  applicationitem: JobApplications)
        {
            JobPosition__c position = positions.get(applicationitem.JobPosition__c);
            Candidate__c candidate= candidates.get(applicationitem.Candidate__c);
            if(position.Location__c == 'USA' && (candidate.USA_visa_holder__c==false || candidate.USA_visa_valid_From__c>Date.Today() || candidate.USA_visa_valid_To__c<Date.Today().addYears(1)))
            {                 
                applicationitem.addError('You can not apply for this job due to your US visa expiration date.');
            }
        }
    }
}