public with sharing class ConfigurationSelector1 {
    public static List<ApexTrigger> getTriggers()
    {
        List<ApexTrigger> triggerList = new List<ApexTrigger>([Select TableEnumOrId,Name from ApexTrigger]);
        return triggerList;
    }
    public static List<ApexPage> getVisualforcePages()
    {      
        List<ApexPage> apexPageList = new List<ApexPage>([Select Id, Name From Apexpage]);
        return apexPageList;
    }
}