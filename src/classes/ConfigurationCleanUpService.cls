public with sharing class ConfigurationCleanUpService {
    
    public Map<string, List<String>> apexTriggerList {get; set;}
    public List<ApexPage> visualforcePageList {get; set;}
    public Map<String,String> visualforcePageListTemp {get; set;}
    public Map<string, List<String>> workflowList {get; set;}
    public Map<string, List<String>> validationRuleList {get; set;}
    public Map<String, List<String>> customFieldList{get; set;}
    public List<List<String>> apexPageList { get; set; }
    public List<String> selectedApexTriggerList {get; set;}
    public List<String> selectedVisualforcePageList {get; set;}
    public List<String> selectedWorkflowList {get; set;}
    public List<String> selectedValidationRuleList {get; set;}
    public Map<string, List<List<string>>> apexTriggerDetailMap = new Map<string, List<List<string>>>();
    public Map<string, List<List<string>>> workflowDetailMap = new Map<string, List<List<string>>>();
    
    public String triggersJson{get; set;}
    public String apexPageJson{get; set;}
    public String workflowJson{get; set;}
    public String customFieldJson{get;set;}
    
    public String ConfigurationList{get; set;}
    public String ConfigName {get; set;}
    public List<String> triggerParentList {get;set;}
    
  public ConfigurationCleanUpService(){
    	System.debug('1');
        System.debug('234');
    	getTriggersDetails();
    	triggersJson = ConfigurationCleanUpServiceHandler.generateJsonForTrigger(apexTriggerDetailMap);
    	getVisualforcePages();
    	apexPageJson = ConfigurationCleanUpServiceHandler.generateJsonForApexPage(visualforcePageList);
    	getWorkflows();
    	workflowJson = ConfigurationCleanUpServiceHandler.generateJsonForTrigger(workflowDetailMap);
    	//System.debug('workflowJson - '+ workflowJson); 
        //getCustomFields();
    	//customFieldJson = ConfigurationCleanUpServiceHandler.generateJsonForTrigger(customFieldList);
    }
    public void getTriggersDetails(){
    	apexTriggerDetailMap = TriggerService.getTriggers();
        System.debug('apexTriggerDetailMap'+apexTriggerDetailMap);
    	triggerParentList = new List<String>();
        triggerParentList.addAll(apexTriggerDetailMap.keySet());
        System.debug('triggerParentList'+triggerParentList);
    }
    public void getWorkflows(){
    	workflowDetailMap = WorkflowService.getWorkflows();
    	System.debug('workflowList - '  + workflowDetailMap);
    }
    public void getCustomFields(){
    	customFieldList = CustomFieldDeleteService.listOfAllFields();
    	System.debug('customFieldList - '  + customFieldList);
    }
    
    //DONE
   /* public void getTriggers(){
     	apexTriggerList = TriggerService.getTriggers();
     	System.debug('apexTriggerList - '  + apexTriggerList);
    }*/
    //DONE
    public void getVisualforcePages(){      
        visualforcePageList = ConfigurationSelector.getVisualforcePages();
        System.debug('visualforcePageList'+visualforcePageList);
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
    
    public void getValidationRules(){
    	validationRuleList = ValidationRuleService.getValidationRules();
    	System.debug('validationRuleList - '  + validationRuleList);
    }
    public void CleanConfigurations(){
    	System.debug('ConfigName - '+ConfigName);
    	if(ConfigName == 'Trigger'){
        	//List<String> triggersToDelete = selectedTriggers.split(',');
        	//System.debug('triggersToDelete - '+ triggersToDelete);
        	//TriggerService.deleteTrigger(triggersToDelete);
        	System.debug('selectedTrigger - ' + ConfigurationList);
    	}
    	else if(ConfigName == 'ApexPage'){
        	//List<String> triggersToDelete = selectedTriggers.split(',');
        	//System.debug('triggersToDelete - '+ triggersToDelete);
        	//TriggerService.deleteTrigger(triggersToDelete);
        	System.debug('selectedApexPage - ' + ConfigurationList);
    	}
    }
    public void configurationCleanUp(){
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