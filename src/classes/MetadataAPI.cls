public class MetadataAPI {
    
    //RETRIVING WORKFLOW RULE
    public MetadataService.FileProperties[] listWorkflowMetadata()
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();
        MetadataService.ListMetadataQuery queryWorkflow = new MetadataService.ListMetadataQuery();
        queryWorkflow.type_x = 'WorkflowRule';
        queries.add(queryWorkflow);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 25);
		
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
    public Boolean deleteWorkflow(List<String> workflowList,String sessionID){
    	System.debug('workflowList - ' + workflowList);
        MetadataService.MetadataPort service = createServiceBatch(sessionID);
        List<MetadataService.DeleteResult> results = service.deleteMetadata('WorkflowRule', workflowList);
        handleDeleteResults(results[0]);
        return results.size() > 0 ? results[0].success : false;
    }
    
    //DELETE VALIDATION RULE
    /*public Boolean deleteValidationRule(List<String> validationList){
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results = service.deleteMetadata('ValidationRule', validationList);
        handleDeleteResults(results[0]);
        return results.size() > 0 ? results[0].success : false;
    }*/
    //DELETE VALIDATION RULE
    public Boolean deleteValidationRule(List<String> validationList,String sessionID){
        MetadataService.MetadataPort service = createServiceBatch(sessionID);
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
    public static MetadataService.MetadataPort createServiceBatch(string sessionId)
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = sessionId;
        return service;
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
            messages.add(
                (deleteResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + deleteResult.fullName + '.');
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
    /*Creating apex pages in bulk*/
	public static void createPage(string fullName, string label)
    {
        MetadataService.MetadataPort service = createService();
        MetadataService.ApexPage apexPage = new MetadataService.ApexPage();
        apexPage.apiVersion = 25;
        apexPage.fullName = fullName;
        apexPage.label = label;
        apexPage.content = EncodingUtil.base64Encode(Blob.valueOf('<apex:page/>'));
        List<MetadataService.SaveResult> results =
            service.createMetadata(
                new MetadataService.Metadata[] { apexPage });
        handleSaveResults(results[0]);
    }
}