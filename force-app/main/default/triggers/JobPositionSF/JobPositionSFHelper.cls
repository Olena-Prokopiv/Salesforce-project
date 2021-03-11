public with sharing class JobPositionSFHelper {
    public static void updateJobPositionsTitle(List<JobPosition__c> JobPositions){
        for( JobPosition__c  positionitem: JobPositions)
        {
            if(positionitem.Practice_Unit__c == 'Salesforce')
            {
                positionitem.Name= 'SF-'+positionitem.Name;
            }
        }
    }
}
