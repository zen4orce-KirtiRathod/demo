public with sharing class WorkflowService {
    public static Map<string, List<List<String>>> getWorkflows()
    {
    	Map<string, List<List<String>>> WorkflowMap = new Map<string, List<List<String>>>();
    	MetadataAPI mapi = new MetadataAPI();
        MetadataService.FileProperties[] fileproperties = mapi.listWorkflowMetadata();
        if(fileproperties != null){
        	list<String> WorkflowName;
        	list<List<String>> WorkflowName1;
    		for(MetadataService.FileProperties fileProperty : fileproperties)
    		{
	    		if(fileProperty.fullName != null && fileProperty.fullName != '')
    	        {
    	        	System.debug('fileProperty.fullName - ' + fileProperty.fullName);
    	        	System.debug('fileProperty.fullName - ' + fileProperty.Id);
        	        WorkflowName = new List<String>();  
        	        WorkflowName1 = new List<List<String>>();              
            	    string Objectname = fileProperty.fullName;
                	if(WorkflowMap.containsKey(Objectname.substringBefore('.')))
                	{ 
	                    WorkflowName1.addAll(WorkflowMap.get(Objectname.substringBefore('.')));
    	                WorkflowName.add(Objectname.substringAfter('.'));  
    	                WorkflowName.add(fileProperty.ID); 
    	                WorkflowName1.add(WorkflowName);
        	        }
            	    else{
                	   	WorkflowName.add(Objectname.substringAfter('.'));
                	   	WorkflowName.add(fileProperty.ID);
                	   	WorkflowName1.add(WorkflowName);
                	}
               		WorkflowMap.put(Objectname.substringBefore('.'), WorkflowName1);      
    			}
    		}
        }
    	return WorkflowMap;        
    }
    public static void deleteWorkflows(List<String> selectedWorkflows)
    {
        Map<string, List<String>> workflowsMap = new Map<string, List<String>>();
        workflowsMap.put('Workflow', selectedWorkflows);
        Id batchJobId = database.executeBatch(new ConfigurationCleanUpBatchService(workflowsMap),100);
        System.debug('batchJobId Apex Page- ' + batchJobId);
        
        //MetadataAPI mapi = new MetadataAPI();
        //mapi.deleteWorkflow(selectedWorkflows);
    }
}