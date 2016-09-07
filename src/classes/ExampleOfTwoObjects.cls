public class ExampleOfTwoObjects
{
    public 	Map<String,Schema.SObjectType> lstOfObj = Schema.getGlobalDescribe(); //get all the objects from org using getGlobalDescribe()
    public  list<String> objects{get;set;}
    Map<String ,Set<Schema.SObjectType>> childObjects = new Map<String,Set<Schema.SObjectType>>();
    public  list<String> finalMapList = new list<String>();
    public  Map<String , Set<String>> mapObj_Rel = new Map<String , Set<String>>();
    
    //Constructor of the class
    public 	ExampleOfTwoObjects()
    {
        list<String> sortObject = new list<String>();
        objects = new list<String>();
        sortObject.addAll(lstOfObj.KeySet());
        Schema.DescribeSObjectResult[] results = Schema.DescribeSObjects(sortObject);
        
        for(Schema.DescribeSObjectResult res : results)
        {
            String resString = String.valueOf(res.getName());
            if(res.getname() == 'kirtirathod__knowledgearticleversion__kav')
            {
                 objects.add('KnowledgeArticleVersion');
            }
            if(!res.isCustomSetting() && res.getRecordTypeInfos().size() > 0 && res.isqueryable()  && res.isDeletable() && res.isCreateable())
         	{
           		 objects.add(res.getname());
            }
        } 
        objects.add('test7__c');
        For(String s :objects )
        {
            System.debug(s);
        } 
        
      	/*findChildObjects(objects);
        for(Set<String> s : mapObj_Rel.values())
        {
            System.debug('Map Values'+ s);
        }
    }
    
    /* This method finds the relation between parent and child and store it in mapObj_Rel*/
   /* public void findChildObjects(list<String> objects)
    {
        for(String objName : objects)
        {
            System.debug('I am in this Objects   ' + objName);
            Schema.SObjectType sobjType = lstOfObj.get(objName);
            Schema.DescribeSObjectResult R = sobjType.getDescribe();
            if(R.isqueryable() && R.isDeletable() )
            {
                System.debug('In the first if loop');
                Set<String> putInMap = new Set<String>();
                list<Schema.ChildRelationship> childRel = R.getChildRelationships();
           		if(childRel != null)
                {
                    for(Schema.ChildRelationship cr : childRel)
                    {
                        if(cr.isRestrictedDelete() &&  String.valueOf(cr.getChildSObject()) != objName )
                        {
                            list<String> recussionList = new list<String>();
                            recussionList.add(String.valueOf(cr.getChildSObject()));
                            System.debug('list of Child Objects' + recussionList);
                            findChildObjects(recussionList);
                            putInMap.add(String.valueOf(cr.getChildSObject()));
                        }
                    }
                }
               mapObj_Rel.put(objName,putInMap) ;
            }
        } 
        System.debug('Mppaing relation:' +mapObj_Rel);
        For(Set<String> s : mapObj_Rel.values())
        {
            System.debug('string ' + s);
        }
    }
    /* call recurssion function */
   /* public void findNullValues()
    {
        for(String k : mapObj_Rel.keySet())
        {
            System.debug('value of Keyset' + K);
            checkForMap(k);
            finalMapList.add(k);
            System.debug('FinalMapList' + finalMapList);
        }
    }
    /* This method is used to find child who is not parent of another object*/
   /* public void checkForMap(String keys)
    {
            Set<String> mapValues = new Set<String>();
            mapValues = mapObj_Rel.get(keys);
            if(mapValues != null)
            {
                for(String values : mapValues)
                {
                    checkForMap(values);
           		}
            }
}*/} }