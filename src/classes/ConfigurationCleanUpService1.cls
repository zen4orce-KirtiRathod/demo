public with sharing class ConfigurationCleanUpService1 {
    
    public Map<string, List<String>> apexTriggerList {get; set;}
    public List<ApexPage> visualforcePageList {get; set;}
    public Map<String,String> visualforcePageListTemp {get; set;}
    public Map<string, List<String>> workflowList {get; set;}
    public Map<string, List<String>> validationRuleList {get; set;}
    public List<List<String>> apexPageList { get; set; }
    public List<String> selectedApexTriggerList {get; set;}
    public List<String> selectedVisualforcePageList {get; set;}
    public List<String> selectedWorkflowList {get; set;}
    public List<String> selectedValidationRuleList {get; set;}
    public Map<string, List<List<string>>> apexTriggerDetailMap = new Map<string, List<List<string>>>();
    
    public String triggersJson{get; set;}
    public String selectedTriggers{get; set;}
    public List<String> triggerParentList {get;set;}
    
    public ConfigurationCleanUpService1(){
    	getTriggersDetails();
    	triggersJson = ConfigurationCleanUpServiceHandler1.generateJson(apexTriggerDetailMap);
    }
    public void getTriggersDetails()
    {
    	apexTriggerDetailMap = TriggerService1.getTriggers();
    	triggerParentList = new List<String>();
        triggerParentList.addAll(apexTriggerDetailMap.keySet());
    }
    
    //DONE
   /* public void getTriggers(){
     	apexTriggerList = TriggerService.getTriggers();
     	System.debug('apexTriggerList - '  + apexTriggerList);
    }*/
    //DONE
    public void getVisualforcePages()
    {      
        visualforcePageList = ConfigurationSelector1.getVisualforcePages();
       /* //List<List<String>> someList = new List<List<String>>();
        List<String> someOtherList = new List<String>();
        apexPageList = new List<List<String>>();
        for(ApexPage obj : visualforcePageList){
        	someOtherList = new List<String>();
        	someOtherList.add('"' + obj.Name + '"');
        	someOtherList.add('"' + obj.Id + '"');
        	apexPageList.add(someOtherList);
        }
        visualforcePageListTemp = new Map<String,String>();
        visualforcePageListTemp.put('1','Name1');
        visualforcePageListTemp.put('2','Name2');
        visualforcePageListTemp.put('3','Name3');
        system.debug('visualforcePageList - '+ visualforcePageListTemp);*/
    }
    public void getWorkflows()
    {
    	//workflowList = WorkflowService.getWorkflows();
    	System.debug('workflowList - '  + workflowList);
    }
    public void getValidationRules()
    {
    	//validationRuleList = ValidationRuleService.getValidationRules();
    	System.debug('validationRuleList - '  + validationRuleList);
    }
    public void CleanConfigurations()
    {
    	if(selectedTriggers != null && selectedTriggers != ''){
        	List<String> triggersToDelete = selectedTriggers.split(',');
        	System.debug('triggersToDelete - '+ triggersToDelete);
        	TriggerService1.deleteTrigger(triggersToDelete);
    	}
    }
    public void configurationCleanUp()
    {
    	/*getTriggers();
    	List<List<String>> somelist = new List<List<String>>();
    	somelist = apexTriggerList.values();
    	System.debug('apexTriggerList.values() - ' + somelist[0]);
    	TriggerService.deleteTrigger(somelist[0]);*/
    	
    	/*getVisualforcePages();
    	List<ApexPage> someApexPagelist = new List<ApexPage>();
    	someApexPagelist = visualforcePageList;
    	System.debug('visualforcePageList.values() - ' + someApexPagelist);
    	List<String> pageList = new List<String>();
    	for(ApexPage obj:someApexPagelist){
    		if(obj.Name != 'VFDatatable' && 
    		obj.Name != 'Check' && 
    		obj.Name != 'VFPureBootstrap' && 
    		obj.Name != 'TestVFPage1' && 
    		obj.Name != 'ConfigurationCleanUp' && obj.Name != 'Configurations'){
    			pageList.add(obj.ID);
    		}
    	}
    	System.debug('pageList - ' + pageList);
    	ApexPageService.deleteApexPages(pageList);*/
    	
    	/*getWorkflows();
    	List<String> somelist = new List<String>();
    	for(String key:workflowList.keySet()){
    		for(string values:workflowList.get(key)){
    			somelist.add(key+'.'+values);
    		}
    	}
    	WorkflowService.deleteWorkflows(somelist);*/
    	
    	/*getValidationRules();
    	List<String> somelist = new List<String>();
    	for(String key:validationRuleList.keySet()){
    		for(string values:validationRuleList.get(key)){
    			somelist.add(key+'.'+values);
    		}
    	}
    	ValidationRuleService.deleteValidationRules(somelist);*/
    }
}