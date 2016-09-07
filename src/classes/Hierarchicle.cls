public class Hierarchicle {
    
    Map<String,Schema.SObjectType> lstOfObj{get;set;} 
    public  list<String> objects{get;set;}
    public  list<String> finalRelationList{get;set;}
    Map<String , Set<String>> mapObj_Rel{get;set;} 
    SelectorHandlerDataCleanUp selector = new SelectorHandlerDataCleanUp();
    //Constructor of the class
    public 	Hierarchicle()
    {
        lstOfObj = Schema.getGlobalDescribe();//get all the objects from org using getGlobalDescribe()
        finalRelationList = new list<String>();
        objects = new list<String>();
        objects.addAll(lstOfObj.KeySet());
        mapObj_Rel= new  Map<String , Set<String>>(); 
    }
    public void mapRelationList()
    {
         mapObj_Rel= new  Map<String , Set<String>>(); 
    }
    public List<String> allStandardObj()
    {
        List<String> objectList = new List<String>();
        for(integer i =0;i< objects.size();i++)
        {
            if(objects[i].endsWith('kav') || objects[i].containsIgnoreCase('CollaborationGroupRecord'))
            {
                objects.remove(i);
            }
        }
        Schema.DescribeSObjectResult[] results = Schema.DescribeSObjects(objects);
        String nameSpace = selector.nameSpaceprefixOfOrg();
        for(Schema.DescribeSObjectResult res : results)
        {
            String resString = String.valueOf(objectList);
            if(!res.isCustomSetting() &&!res.isCustom() && res.getRecordTypeInfos().size() > 0 && res.isqueryable()  && res.isDeletable() && res.isCreateable())//get the list of objetcs which are queryable,deletable and creatable
            {
                if(nameSpace != null && resString.startsWith(nameSpace + '__'))
                {
                    objectList.add(res.getname());
                }
                else if(namespace == null && resString.countMatches('__') < 2)
                {
                    objectList.add(res.getname());
                } 
            }
        }
         return objectList;
     }
    //Get a list of All Custom Objects
    public List<String> allCustomObj()
    {
        List<String> objectList = new List<String>();
        Schema.DescribeSObjectResult[] results = Schema.DescribeSObjects(objects);
        String nameSpace = selector.nameSpaceprefixOfOrg();
        for(Schema.DescribeSObjectResult res : results)
        {
            String resString = String.valueOf(res.getName());
            if(!res.isCustomSetting()  && res.iscustom() && res.getRecordTypeInfos().size() > 0 && res.isqueryable()  && res.isDeletable() && res.isCreateable())//get the list of objetcs which are queryable,deletable and creatable
            {
                if(nameSpace != null && resString.startsWith(nameSpace + '__'))
                {
                    objectList.add(res.getname());
                }
                else if(namespace == null && resString.countMatches('__') < 2)
                {
                    objectList.add(res.getname());
                } 
            }
        }
        return objectList; 
    }
    /* This method finds the relation between parent and child and store it in mapObj_Rel*/
    public Map<string,Set<String>> findChildObjects(list<String> objList)
    {
        Schema.DescribeSObjectResult[] results = Schema.DescribeSObjects(objList);
        for(Schema.DescribeSObjectResult R : results)
        {
            if(R.isqueryable() && R.isDeletable())
            {
                Set<String> putInMap = new Set<String>();
                list<Schema.ChildRelationship> childRel = R.getChildRelationships();
                if(childRel != null)
                {
                    for(Schema.ChildRelationship cr : childRel)
                    {
                        if(R.getName() =='Account')
                        {
                            list<String> recussionList = new list<String>();
                            recussionList.add('Opportunity');
                            findChildObjects(recussionList);
                            putInMap.add('Opportunity');
                            recussionList.add('Contact');
                            findChildObjects(recussionList);
                            putInMap.add('Contact');
                            
                        }
                        if(cr.isRestrictedDelete() &&  String.valueOf(cr.getChildSObject()) != R.getName() )
                        {	
                            list<String> recussionList = new list<String>();
                            recussionList.add(String.valueOf(cr.getChildSObject()));
                            findChildObjects(recussionList);
                            putInMap.add(String.valueOf(cr.getChildSObject()));
                        }
                    }
                }
                mapObj_Rel.put(R.getName(),putInMap) ;//It creates a map relation which stores parent as a key and its related objects as child
            }
        }
        return mapObj_Rel; 
    }
    /* Call Recurssion function to find child's child*/
    public List<String> findNullValues(Map<string,Set<String>> mapObj_Rel)
    {
        for(String k : mapObj_Rel.keySet())
        {
            checkForRelationShip(k);
            finalRelationList.add(k);
        }
        return finalRelationList;
    }
    /* This method is used to find child who is not parent of another object*/
    public void checkForRelationShip(String keys)
    {
        Set<String> mapValues = new Set<String>();
        mapValues = mapObj_Rel.get(keys);
        if(mapValues != null)
        {
            for(String values : mapValues)
            {
                checkForRelationShip(values);
            }
        }
    }  
}