public class FieldDeleteService {
    public FieldDeleteService()
    {
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe(); 
        Map <String,Schema.SObjectField> fieldMap = schemaMap.get('Test__c').getDescribe().fields.getMap();
        List<String> fieldList = new List<String>();
        for(Schema.SObjectField sfield : fieldMap.Values())
        {
            schema.describefieldresult dfield = sfield.getDescribe();
            List<Schema.sObjectType> s = dfield.getReferenceTo();
                System.debug('s'+' '+s);
            if(dfield.isCustom())
            {
                fieldList.add(dfield.getName());
            }
   		}
        System.debug('fieldList'+fieldList);
        Map<String,List<String>> lstOfFields = new Map<String,List<String>>();
        List<String> lstOfAllFields = new List<String>();
        lstOfAllFields.addAll(fieldList);
        //lstOfAllFields.add('TestField2') ;   
        lstOfFields.put('Test',lstOfAllFields);
        //List<String>lstOfFieldss =  DeleteCustomFields.mapToListConvert(lstOfFields);
        //FieldDeleteBatchService d = new FieldDeleteBatchService(lstOfFieldss);//Created an instance to call Batch Apex class 
       // database.executeBatch(d,10);
    }
    /*
    public with sharing class CustomFieldDeleteService {
	
	public String objCount{get;set;}
    public List<WrapperDataCleanUpService> wrapFieldList{get;set;}
    Map <String, Schema.SObjectField> fieldMap{get;set;}
    public Static ring> objList{get;set;}
    public String selectedField{get;set;}
    public Map<String,String> selectedFieldListToDelete{get;set;}
    private Static Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    Public List<String> objFieldList {get;set;}
    public boolean flag {get;set;}
    public CustomFieldDeleteService() 
    {
        try
        {
            objFieldList = new List<String>();
            objList = CustomFieldDeleteService.listOfAllObj();
            selectedFieldListToDelete = new Map<String,String>();
        }
        catch(Exception e )
        {
            System.debug('Error:'+e.getMessage());
        }
    }
    public static List<String> listOfAllObj()
   	{
       try
       {
           List<String> lstOfallObj = HierarchicalUtilityService.allObjects();
           List<String> lstOfStdObj = HierarchicalUtilityService.allStandardObj(lstOfallObj);
           List<String> lstOfCusObj = HierarchicalUtilityService.allCustomObj(lstOfallObj);
           objList.addAll(lstOfStdObj);
           objList.addAll(lstOfCusObj);
       }
       catch(Exception e )
        {
            System.debug('Error:'+e.getMessage());
        }
      return objList;
   }
   
   public pageReference showAllFields()
   {
       try
       {
           List<String> lstOfFields = new List<String>();
           if(objCount != null)
           { 
               lstOfFields   = allFieldsOfObject(objCount);
               wrapFieldList = HierarchicalUtilityService.wrapObjList(lstOfFields); 
               for(WrapperDataCleanUpService field : wrapFieldList)
               {
                   String objManipulate = objCount+'__c.'+field.objName;
                   System.debug('objManipulate'+objManipulate);
                   if(selectedFieldListToDelete.get(objManipulate) != null)
                   {
                       field.isSelected = true;
                   }
               }
           }
       }
       catch(Exception e )
       {
           System.debug('Error:'+e.getMessage());
       }
      return null;
   }
   public list<String> allFieldsOfObject(String ObjName)
   {
       List<String> fieldList = new List<String>(); 
       try
        {
            Map <String,Schema.SObjectField> fieldMap = schemaMap.get(ObjName).getDescribe().fields.getMap();
           
            for(Schema.SObjectField sfield : fieldMap.Values())
            {
                schema.describefieldresult dfield = sfield.getDescribe();
                if(dfield.isCustom())
                {
                    fieldList.add(dfield.getName());
                }
            }
        }
        catch(Exception e )
        {
            System.debug('Error:'+e.getMessage());
        }
       return fieldList;    
	}
    public pageReference selectedFieldEvent()
    {
        try
        {
            String manipulateString = objCount+'__c.'+selectedField ;
        System.debug('manipulateString'+manipulateString+flag);
 
        objFieldList.add(manipulateString);
        selectedFieldListToDelete.put(manipulateString,manipulateString);
        
        System.debug('objFieldList'+objFieldList);
        }
        catch(Exception e )
        {
            System.debug('Error:'+e.getMessage());
        }
       // objFieldMap.put(objCount,wrapFieldList.objName);
        return null;
    }
    
   public pageReference DeleteAll()
   {
       DeleteFields(objFieldList);
       return null;
   }
   public void DeleteFields()
   {
       /*st<String>  fieldList1= new List<String>();
      fieldList1.add(('contract__c.CampeignItem__c');)
       CustomFieldDeleteBatchService d = new CustomFieldDeleteBatchService(fieldList1)//Created an instance to call Batch Apex class 
       database.executeBatch(d,10);
   }
}*/
}