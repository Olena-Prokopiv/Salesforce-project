public with sharing class JobApplicationTriggerHelper {
    public static void checkVisaDate(List<JobApplication__c> JobApplications){
        for( JobApplication__c  applicationitem: JobApplications)
        {
            JobPosition__c position=[Select Location__c from JobPosition__c where Id = :applicationitem.JobPosition__c];
            Candidate__c candidate=[Select USA_visa_holder__c,USA_visa_valid_From__c,USA_visa_valid_To__c from Candidate__c where Id = :applicationitem.Candidate__c];
            if(!(position.Location__c == 'USA' && candidate.USA_visa_holder__c==true && candidate.USA_visa_valid_From__c<=Date.Today() && candidate.USA_visa_valid_To__c>=Date.Today().addYears(1)))
            {                
                applicationitem.addError('You can not apply for this job due to your US visa expiration date. ');
            }
    	}
    }
}