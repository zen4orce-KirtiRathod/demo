public class ExampleForFindDependencyBetweenObjects {
    public 	Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
    public  list<String> objects{get;set;}
    public  String query;
    public  Set<String> newListOfObj;
    public 	list<String> newlist;
    public 	ExampleForFindDependencyBetweenObjects()
    {
        list<String> sortObject = new list<String>();
        objects = new list<String>();
        sortObject.addAll(gd.KeySet());
        sortObject.sort();
        newlist = new list<String>();
        Schema.DescribeSObjectResult[] results = Schema.DescribeSObjects(sortObject);
        for(Schema.DescribeSObjectResult res : results)
        {
            if(!res.isCustomSetting() && res.getRecordTypeInfos().size() > 0 && res.isqueryable() && res.isSearchable() && res.isDeletable() && res.isCreateable() && res.getName() != 'ContentDocumentLink' && res.getName() != 'ContentFolderItem' && res.getName() != 'ContentFolderMem')
            objects.add(res.getname());
        } 
        findChildObjects('Account');
     }
    /*
    public list<String> FindDependency(list<String> objects)
    {
	//newListOfObj = new Set<String>();
	public class ExampleForFindDependencyBetweenObjects {
    public Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
    public  list<String> objects{get;set;}
    public  String query;
    public  list<String> newlist{get;set;}
    public Schema.SObjectType sobjtype1;
    public ExampleForFindDependencyBetweenObjects()
    {
      
            list<String> sortObject = new list<String>();
            objects = new list<String>();
            sortObject.addAll(gd.KeySet());
            sortObject.sort();
            newlist = new list<String>();
            Schema.DescribeSObjectResult[] results = Schema.DescribeSObjects(sortObject);
            for(Schema.DescribeSObjectResult res : results)
            {
                if(!res.isCustomSetting() && res.getRecordTypeInfos().size() > 0 && res.isqueryable() && res.isSearchable() && res.isDeletable() && res.isCreateable() && res.getName() != 'ContentDocumentLink' && res.getName() != 'ContentFolderItem' && res.getName() != 'ContentFolderMem')
                objects.add(res.getname());
            }
        identifyRelationship(objects);
    }
    public list<String> lookupRelatioship(list<String> objects )
    {
        for(String obj : objects)
        {
            sobjtype1 = gd.get(obj);
         	list<Schema.SObjectField> lstOfFields = new list<Schema.SObjectField>();
            lstOfFields = sobjtype1 .getDescribe().fields.get();
            for(Schema.DescribeFieldResult s : lstOfFields)
            {
               Schema.DescribeFieldResult dfr = sobjtype1.s.getDescribe();
               list<Schema.DescribeFieldResult> referencedlist = new list<Schema.DescribeFieldResult>(); 
			   System.debug('this is referenced list' + referencedlist);
            }
       
        }
        
    }*/
    public list<String> findChildObjects(String objlist)
    {
    		Schema.SObjectType convertType = gd.get(objlist);
            System.debug('ConvertType '+convertType);
	    	Schema.DescribeSObjectResult R = convertType.getDescribe();
			Sobject genericObject = convertType.newSObject();
            List<Schema.ChildRelationship> C = R.getChildRelationships(); 
			if(C != null)
			{
				System.debug('In ChildRelatioship');
                list<String> resultList = new list<String>();
                List<String> ChildRelationshipStringList = new list<String>();
				for(Schema.ChildRelationship s1 : C)
				{
				 	System.debug('Child Objects'+ s1);
				 	//list<String> value = new list<String>();
                    //value.add(String.valueOf(s1));
                 	String value = String.valueOf(s1);
                    System.debug('value of '+value);
                    findChildObjects(value);
                    //  Schema.DescribeSObjectResult[] results = Schema.DescribeSObjects(sortObject);
                    /*
                    Schema.DescribeSObjectResult[] results = Schema.DescribeSObjects(value);
                    if(!results[0].isCustomSetting() && results[0].getRecordTypeInfos().size() > 0 && results[0].isqueryable() && results[0].isSearchable() && results[0].isDeletable() && results[0].isCreateable()  )
                    {
                        String obj = String.valueOf(s1);
                        findChildObjects(obj);
                    }*/
				}
				
			}
			else
			{
				newlist.add(R.getname());
	       	}
        return newlist;
    }
        
    }
    
    /*
    public list<String>  identifyRelationship(list<String> objlist)
    {
        for(integer i = 0;i<objlist.size();i++)
        {
            Schema.DescribeSObjectResult R = objlist[i].SObjectType.getDescribe();
            List<Schema.ChildRelationship> ChildObj = R.getChildRelationships(); 
            for(Schema.ChildRelationship i2 : ChildObj)
            {
                 Schema.SObjectType i1 = i2.getChildSObject();
                 System.debug('value of Objects'+ i1);
                 String s  = StringalueOf(i1);
                 if(s.contains('ActivityHistory' || 'AttachedContentDocument' || ''))
                 newlist.add(s);
            }
          }
        
        System.debug('Objects in Order'+ newlist);
        for(String s : newlist)
        {
            System.debug('this is content of newlist'+ s);
        }
        
        }
    }
    	}*/