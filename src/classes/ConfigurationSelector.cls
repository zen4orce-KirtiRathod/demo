public with sharing class ConfigurationSelector {
    public static List<ApexTrigger> getTriggers()
    {
        List<ApexTrigger> triggerList = new List<ApexTrigger>([Select TableEnumOrId,Name from ApexTrigger]);
        return triggerList;
    }
    public static List<ApexPage> getVisualforcePages(){      
        List<ApexPage> apexPageList = new List<ApexPage>([Select Id, Name From Apexpage]);
        return apexPageList;
    }
}