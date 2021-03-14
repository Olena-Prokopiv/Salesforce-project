public with sharing class CandidateTriggerHelper {
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

    public static void changeRecovered(List<Candidate__c> Candidates){

        List<Candidate__c> candidateList = new List<Candidate__c>();

        for( Candidate__c candidateitem:Candidates )
        {
            candidateList.add(new Candidate__c(id=candidateitem.id, Recovered__c=true));            
        }
       
        update candidateList;
    }
}
