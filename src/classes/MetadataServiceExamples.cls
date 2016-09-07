public class MetadataServiceExamples {
    
    //RETRIVING WORKFLOW RULE
    public MetadataService.FileProperties[] listWorkflowMetadata()
    {
        MetadataService.MetadataPort service = createService();
        System.debug('service'+service);
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();
        MetadataService.ListMetadataQuery queryWorkflow = new MetadataService.ListMetadataQuery();
        queryWorkflow.type_x = 'WorkflowRule';
        queries.add(queryWorkflow);
        System.debug('hello');
        System.debug('queries'+queries);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 25);
		System.debug('fileProperties   '+fileProperties);
        return fileProperties;
    }
    
    //RETRIVE VALIDATION RULE
    public MetadataService.FileProperties[] listValidationRuleMetadata()
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();
        MetadataService.ListMetadataQuery queryValidationRule = new MetadataService.ListMetadataQuery();
        queryValidationRule.type_x = 'ValidationRule';
        queries.add(queryValidationRule);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 25);
        
        return fileProperties;
    }
    
    //RETRIVE CUSTOM FIELDS
    public MetadataService.FileProperties[] listFieldsMetadata()
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();
        MetadataService.ListMetadataQuery queryValidationRule = new MetadataService.ListMetadataQuery();
        queryValidationRule.type_x = 'CustomField';
        queries.add(queryValidationRule);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 25);
        System.debug('fileProperties custom Fields'+fileProperties);
        return fileProperties;
    }
    
    //RETRIVE CUSTOM OBJECTS
    public MetadataService.FileProperties[] listObjectsMetadata()
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();
        MetadataService.ListMetadataQuery queryValidationRule = new MetadataService.ListMetadataQuery();
        queryValidationRule.type_x = 'CustomObject';
        queries.add(queryValidationRule);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 25);
        
        return fileProperties;
    }
    
    //DELETE CUSTOM FIELDS
    public Boolean deleteField(List<String> fieldList)
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results = service.deleteMetadata('CustomField', fieldList);
        
        handleDeleteResults(results[0]);
        return results.size() > 0 ? results[0].success : false;
    }
    
    //DELETE CUSTOM OBJECTS
    public Boolean deleteObject(List<String> objectList){
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results = service.deleteMetadata('CustomObject', objectList);
        handleDeleteResults(results[0]);
        return results.size() > 0 ? results[0].success : false;
    }
    
    //DELETE WORKFLOW RULE
    public Boolean deleteWorkflow(List<String> workflowList){
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results = service.deleteMetadata('WorkflowRule', workflowList);
        handleDeleteResults(results[0]);
        return results.size() > 0 ? results[0].success : false;
    }
    
    //DELETE VALIDATION RULE
    public Boolean deleteValidationRule(List<String> validationList){
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results = service.deleteMetadata('ValidationRule', validationList);
        handleDeleteResults(results[0]);
        return results.size() > 0 ? results[0].success : false;
    }
    
    //DELETE FLOW 
    public Boolean deleteFlow(List<String> flowList){
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results = service.deleteMetadata('Flow', flowList);
        handleDeleteResults(results[0]);
        return results.size() > 0 ? results[0].success : false;
    }

    //DELETE STATIC RESOURCE
    public Boolean deleteStaticResource(List<String> packageList)
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results = service.deleteMetadata('StaticResource', packageList);
        handleDeleteResults(results[0]);
        return results.size() > 0 ? results[0].success : false;
    }
	
	//UNINSTALL PACKAGES
    public Boolean uninstallPackages(List<String> packageList)
    {
        // Uninstall packages
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results =
            service.deleteMetadata('InstalledPackage', packageList);
        handleDeleteResults(results[0]);
		return results.size() > 0 ? results[0].success : false;
    } 
    
    public class MetadataServiceExamplesException extends Exception { }

    public static MetadataService.MetadataPort createService()
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }
    public static void createField()
    {
        MetadataService.MetadataPort service = createService();
        for(integer i = 600;i<=1000;i++)
        {
            MetadataService.CustomField customField = new MetadataService.CustomField();
            customField.fullName = 'Test6__c.TestField'+i+'__c';
            customField.label = 'Test Field';
            customField.type_x = 'Text';
            customField.length = 42;
            List<MetadataService.SaveResult> results =
                service.createMetadata(
                    new MetadataService.Metadata[] { customField });
            handleSaveResults(results[0]);
        }
    }

    /**
     * Example helper method to interpret a SaveResult, throws an exception if errors are found
     **/
    public static void handleSaveResults(MetadataService.SaveResult saveResult)
    {
        // Nothing to see?
        if(saveResult==null || saveResult.success)
            return;
        // Construct error message and throw an exception
        if(saveResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (saveResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + saveResult.fullName + '.');
            for(MetadataService.Error error : saveResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
        }
        if(!saveResult.success)
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }

    /**
     * Example helper method to interpret a SaveResult, throws an exception if errors are found
     **/
    public static void handleDeleteResults(MetadataService.DeleteResult deleteResult)
    {
        // Nothing to see?
        if(deleteResult==null || deleteResult.success)
            return;
        // Construct error message and throw an exception
        if(deleteResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add('Error occured processing component ' + deleteResult.fullName + '.');
            for(MetadataService.Error error : deleteResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
        }
        if(!deleteResult.success)
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }
    public static void updateField()
    {
        MetadataService.MetadataPort service = createService();
        MetadataService.CustomField customField = new MetadataService.CustomField();
        customField.fullName = 'Test6__c.FirstName__c';
        customField.label='New Test Field Label';
        customField.type_x = 'Text';
        customField.length = 52;
        List<MetadataService.SaveResult> results =
            service.updateMetadata(
                new MetadataService.Metadata[] { customField });
        handleSaveResults(results[0]);
    }
   	public static void readFlow()
    {
        MetadataService.MetadataPort service = createService();
        
        // Read Flow
        MetadataService.Flow flow =
            (MetadataService.Flow) service.readMetadata('Flow',
                new String[] { 'FlowCheck' }).getRecords()[0];
        System.debug('flow'+flow);
        System.debug('Description ' + flow.description);
        System.debug('Name ' + flow.RecordCreates[0].name);
        System.debug('Location X ' + flow.RecordCreates[0].locationX);
        System.debug('Location Y ' + flow.RecordCreates[0].locationY);
    }  
  public static Map<string, List<String>> getValidationRules()
    {
     Map<string, List<String>> ValidationRuleMap = new Map<string, List<String>>();
     MetadataServiceExamples mapi = new MetadataServiceExamples();
     MetadataService.FileProperties[] fileproperties = mapi.listValidationRuleMetadata();
        if(fileproperties != null)
		{
			list<String> ValidationRuleName;
			for(MetadataService.FileProperties fileProperty : fileproperties)
			{
				if(fileProperty.fullName != null && fileProperty.fullName != '')
				{
					ValidationRuleName = new List<String>();                
					string Objectname = fileProperty.fullName;
					if(ValidationRuleMap.containsKey(Objectname.substringBefore('.')))
					{ 
						ValidationRuleName.addAll(ValidationRuleMap.get(Objectname.substringBefore('.')));
						ValidationRuleName.add(Objectname.substringAfter('.'));   
					}
					else
					{
						ValidationRuleName.add(Objectname.substringAfter('.'));
					}
				ValidationRuleMap.put(Objectname.substringBefore('.'), ValidationRuleName);      
				}
			}
        }
     return ValidationRuleMap;         
    }
}