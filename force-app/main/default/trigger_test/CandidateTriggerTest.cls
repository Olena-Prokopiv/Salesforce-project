@isTest
public with sharing class CandidateTriggerTest {    
    @isTest
    static void testInsertCandidateWhichVisaHolderTrue()
    {
        List<Candidate__c> Candidates = DataFactory.generateCandidateRecordsInvalid(250);
        List<Candidate__c> CandidatesInvalid = DataFactory.generateCandidateRecordsInvalid(250);
        Candidates.addAll(CandidatesInvalid);
        
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
            else if(candidate.USA_visa_holder__c==true && 	candidate.USA_visa_valid_From__c!=null && 	candidate.USA_visa_valid_To__c!=null)
            {
                System.assert(results[k].isSuccess());
            }
            k++;
        }
    }
    
    @isTest
    static void testUpdateCandidateWhichVisaHolderTrue()
    {
        List<Candidate__c> Candidates = DataFactory.generateCandidateRecordsInvalid(250);
        List<Candidate__c> CandidatesInvalid = DataFactory.generateCandidateRecordsInvalid(250);
        Candidates.addAll(CandidatesInvalid);
        insert Candidates;
        
        Test.startTest();
        Database.SaveResult[] results = Database.update(Candidates, false);
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
            else if(candidate.USA_visa_holder__c==true && 	candidate.USA_visa_valid_From__c!=null && 	candidate.USA_visa_valid_To__c!=null)
            {
                System.assert(results[k].isSuccess());
            }            
            k++;
        }
    }
    
    @isTest
    static void testCheckRecoveredAfterUndelete()
    {
        List<Candidate__c> Candidates = DataFactory.generateCandidateRecordsValid(250);
        insert Candidates;
        delete Candidates;
        undelete Candidates;
        
        Candidates = [SELECT Id, Recovered__c FROM Candidate__c];
        
        for(Candidate__c candidate:Candidates) {
            System.assert(candidate.Recovered__c==true);
        }
    }    
}