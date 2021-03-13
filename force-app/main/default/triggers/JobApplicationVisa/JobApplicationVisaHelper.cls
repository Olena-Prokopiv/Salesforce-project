public with sharing class JobApplicationVisaHelper {
    public static void checkVisaDate(List<JobApplication__c> JobApplications){
        for( JobApplication__c  applicationitem: JobApplications)
        {
            if(!(applicationitem.JobPosition__r.Location__c == 'USA' && applicationitem.Candidate__r.USA_visa_holder__c==true && applicationitem.Candidate__r.USA_visa_valid_From__c<=Date.Today() && applicationitem.Candidate__r.USA_visa_valid_To__c>=Date.Today().addYears(1)))
            {
              applicationitem.addError('You can not apply for this job due to your US visa expiration date. ');
            }
        }
    }
}
