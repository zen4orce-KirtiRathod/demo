public class SelectorHandlerDataCleanUp {
    
   //Query for find NamespacePrefix of your Organization
    public String nameSpaceprefixOfOrg()
    {
        String nameSpace;
        Organization org = [SELECT NamespacePrefix FROM Organization];
        nameSpace = String.valueOf(org.NamespacePrefix);
        return nameSpace;
    }
    
    //Query for find numberOfReocrds of Object
    public integer numberOfReocrds(String obj)
    {
        integer count;	
        count= database.countQuery('SELECT count() FROM '+obj);
        return count;
    }
    
    //Query for returning records to batch class
    public Database.QueryLocator queryLocatorById(String query)
    {
        return Database.getQueryLocator(query);
    }
    
    //Query to AsyncApexJob object to find Status of job
    public AsyncApexJob asyncApexJobDetails(Id idOfJob)
    {
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
            		      TotalJobItems, CreatedBy.Email
             			  FROM AsyncApexJob WHERE Id =:idOfJob];
 		return a;
    }
    public List<AsyncApexJob> batchRunningDetails(String batchClassName)
    {
        List<AsyncApexJob> a = [SELECT Id,ApexClass.name ,Status 
                          FROM AsyncApexJob
                          WHERE ApexClass.name =: batchClassName AND
           				  (Status =:'Processing' OR Status = : 'Queued' OR Status  =: 'Preparing') LIMIT 1];
        return a;
    }
}