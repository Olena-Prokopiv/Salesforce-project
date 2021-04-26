public class DataFactory {
    
    public static List<Candidate__c> generateCandidateRecordsInvalid (Integer count) {
        
        List<Candidate__c> Candidates = new List<Candidate__c>();
        
        for (Integer i = 0; i < count; i++) {
            Candidates.add(new Candidate__c(Name = 'candidate'+i,
                                            Email__c='fortegroup@gmail.com',
                                            PhoneNumber__c='380504159832',
                                            Years_in_IT__c=1,
                                            USA_visa_holder__c=true,
                                            USA_visa_valid_From__c=null,
                                            USA_visa_valid_To__c=null));  
        }
        return Candidates;
    }
    
    public static List<Candidate__c> generateCandidateRecordsValid (Integer count) {
        
        List<Candidate__c> Candidates = new List<Candidate__c>();
        
        for (Integer i = 0; i < count; i++) {
            Candidates.add(new Candidate__c(Name = 'candidate'+i,
                                            Email__c='fortegroup@gmail.com',
                                            PhoneNumber__c='380504159832',
                                            Years_in_IT__c=1,
                                            USA_visa_holder__c=true,
                                            USA_visa_valid_From__c=date.today()-i,
                                            USA_visa_valid_To__c=date.today().addMonths(10)+i));
        }
        return Candidates;
    } 
    
    public static List<JobPosition__c> generatePositionRecords(Integer count) {
        Contact contact=new Contact(LastName ='Klery', MailingCountry='USA',Email='kleryk@gmail.com');    
        insert contact;
        
        List<JobPosition__c> Positions = new List<JobPosition__c>();
        
        for (Integer i = 0; i < count; i++) {
            if(math.mod(i,5)==0){
                Positions.add(new JobPosition__c(Name = 'position'+i,
                                                 CandidateLevel__c='Junior Software Engineer',
                                                 Location__c= 'USA' ,
                                                 Practice_Unit__c='Salesforce',
                                                 Priority__c='Low',
                                                 Position_Budget__c=400+i, 
                                                 HR_Manager__c =contact.Id));       
            }
            else if(math.mod(i,5)==1){
                Positions.add(new JobPosition__c(Name = 'position'+i,
                                                 CandidateLevel__c='Middle Software Engineer',
                                                 Location__c= 'Poland' ,
                                                 Practice_Unit__c='Java',
                                                 Priority__c='Low',
                                                 Position_Budget__c=400+i, 
                                                 HR_Manager__c =contact.Id)); 
            }
            else if(math.mod(i,5)==2){
                Positions.add(new JobPosition__c(Name = 'position'+i,
                                                 CandidateLevel__c='Lead Software Engineer',
                                                 Location__c= 'Ukraine' ,
                                                 Practice_Unit__c='PHP',
                                                 Priority__c='Hot',
                                                 Position_Budget__c=500+i, 
                                                 HR_Manager__c =contact.Id)); 
            }
            else if(math.mod(i,5)==3){
                Positions.add(new JobPosition__c(Name = 'position'+i,
                                                 CandidateLevel__c='Senior Software Engineer',
                                                 Location__c= 'Belarus' ,
                                                 Practice_Unit__c='Python',
                                                 Priority__c='Hot',
                                                 Position_Budget__c=500+i, 
                                                 HR_Manager__c =contact.Id)); 
            }
            else if(math.mod(i,5)==4){
                Positions.add(new JobPosition__c(Name = 'position'+i,
                                                 CandidateLevel__c='Senior Software Engineer',
                                                 Location__c= 'Belarus' ,
                                                 Practice_Unit__c='.Net',
                                                 Priority__c='Medium',
                                                 Position_Budget__c=600+i, 
                                                 HR_Manager__c =contact.Id)); 
            }
            
        }
        return Positions;
    } 
    
    public static List<JobApplication__c> generateApplicationRecords(List<JobPosition__c> Positions, List<Candidate__c> Candidates,Integer count) {
        List<JobApplication__c> Applications = new List<JobApplication__c>();
        for (Integer i = 0; i < 250; ++i) {
            Applications.add(new JobApplication__c(Expected_Salary__c=300+i, JobPosition__c=Positions[i].Id,Candidate__c=Candidates[i].Id));
        }
        return Applications;
    }
}