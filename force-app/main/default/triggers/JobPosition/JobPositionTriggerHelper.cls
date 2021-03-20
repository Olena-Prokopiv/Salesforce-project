public with sharing class JobPositionTriggerHelper {
    public static void updateJobPositionsTitle(List<JobPosition__c> JobPositions){
        for( JobPosition__c  positionitem: JobPositions)
        {
            if(positionitem.Practice_Unit__c == 'Salesforce')
            {
                positionitem.Name= 'SF-'+positionitem.Name;
            }
        }
    }
    
    public static void createTaskforHR(Map<Id,JobPosition__c> OldJobPositions,Map<Id,JobPosition__c> NewJobPositions){
        List<Task> taskList = new List<Task>();
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Map<Id,Contact> contacts = new Map<Id,Contact>([Select Id, Email from Contact]);
        
        for( JobPosition__c newPosition: NewJobPositions.values())
        {
            JobPosition__c oldPosition = OldJobPositions.get(newPosition.Id);
            Contact hr= contacts.get(oldPosition.HR_Manager__c);
            
            if((newPosition.Position_Budget__c != oldPosition.Position_Budget__c) && newPosition.Position_Budget__c>5000){
                Task newTask = new Task(OwnerId = UserInfo.getUserId(), Subject='Review high budget position '+ oldPosition.Name, Status='New',WhoId=hr.Id );
                taskList.add(newTask);
                
                Messaging.SingleEmailMessage CaseNotificationmail = new Messaging.SingleEmailMessage();
                CaseNotificationmail.setToAddresses(new List<String> { hr.Email });
                CaseNotificationmail.setReplyTo('noreply@support.sf');
                CaseNotificationmail.setSubject('High budget notification');    
                CaseNotificationmail.setHtmlBody('Please review this high budget position '+ oldPosition.Name);
                mails.add(CaseNotificationmail); 
            }
        }
        insert taskList;    
        Messaging.sendEmail(mails);
    }
}