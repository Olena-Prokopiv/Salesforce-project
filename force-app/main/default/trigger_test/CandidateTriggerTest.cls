@isTest
public with sharing class CandidateTriggerTest {    
    @isTest
    static void testUpdatedCandidateWhichVisaHolderTrue()
    {
        List<Candidate__c> Candidates = new List<Candidate__c>();
        
        for (Integer i = 0; i < 250; ++i) {
            Candidates.add(new Candidate__c(Name = 'candidate'+i,Email__c='fortegroup@gmail.com',PhoneNumber__c='380504159832',Years_in_IT__c=1,USA_visa_holder__c=true,USA_visa_valid_From__c=null,USA_visa_valid_To__c=null));              
        }
        
        Test.startTest();
        Database.SaveResult[] results = Database.insert(Candidates, false);
        Test.stopTest();
        
        Integer k=0;
        for(Candidate__c candidate:Candidates)
        {
            if(candidate.USA_visa_holder__c==true && (	candidate.USA_visa_valid_From__c==null || 	candidate.USA_visa_valid_To__c==null))
            {
                System.assert(!results[k].isSuccess());
                System.assert(results[k].getErrors().size() > 0);
                System.assertEquals('Please specify your visa date information', results[k].getErrors()[0].getMessage());
            }
            k++;
        }
    }
    
    @isTest
    static void testCheckRecoveredAfterUndelete()
    {
        List<Candidate__c> Candidates = new List<Candidate__c>();
        
        for (Integer i = 0; i < 250; ++i) {
            Candidates.add(new Candidate__c(Name = 'candidate'+i,Email__c='fortegroup@gmail.com',PhoneNumber__c='380504159832',Years_in_IT__c=1,USA_visa_holder__c=true,USA_visa_valid_From__c=date.today(),USA_visa_valid_To__c=date.today()+1));              
        }
        insert Candidates;
        delete Candidates;
        undelete Candidates;
        
        
        List<Candidate__c> InsertedCandidates = [SELECT Id,Recovered__c FROM Candidate__c];
        
        for(Candidate__c candidate:InsertedCandidates) {   
            System.assert(candidate.Recovered__c==true);
        }
    }    
}
