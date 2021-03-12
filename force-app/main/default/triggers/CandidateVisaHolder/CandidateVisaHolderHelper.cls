public with sharing class CandidateVisaHolderHelper {
    public static void showError(List<Candidate__c> Candidates)
    {
        for(Candidate__c candidateitem: Candidates)
        {
            if(candidateitem.USA_visa_holder__c==true && (	candidateitem.USA_visa_valid_From__c==null || 	candidateitem.USA_visa_valid_To__c==null))
            {
                candidateitem.addError('Please specify your visa date information');
            }
        }  
    }
}