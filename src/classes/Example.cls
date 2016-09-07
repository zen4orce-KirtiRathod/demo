public with sharing class Example {
   
    //public Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
    public list<String> objects = new list<String>();
   // public Schema.SObjectType sobjtype1;
    public  Example()
    {
        {
             	Organization org = [SELECT NamespacePrefix FROM Organization];
                String nameSpace = String.valueOf(org.NamespacePrefix);
                list<String> sortObject = new list<String>();
                //sortObject.addAll(gd.KeySet());
                sortObject.add('Goal');
                
                DescribeSObjectResult[] results = Schema.describeSObjects(sortObject);
                System.debug('results'+results);
                List<String> sorted = new List<String>();
                sorted.add('Goal');
                //sorted.add('Metric');
                Schema.DescribeSObjectResult[] descResult = Schema.describeSObjects(sorted);
                for(Schema.DescribeSObjectResult res : descResult )
                {
                    System.debug(res);
                }
                 //Schema.DescribeFieldResult F = Account.Industry.getDescribe();
                 
                     //System.debug('this is ur Answer'+ F);
         /*       
                for(Schema.DescribeSObjectResult res : results)
                {
                    String resString = res.getName();
                    system.debug(res);
                     if(!res.isCustomSetting() && !res.iscustom() && res.getRecordTypeInfos().size() > 0 && res.isCreateable() &&  res.isqueryable()  && res.isDeletable())
                   		 {
                            objects.add(res.getname());
                            //system.debug(res);
                              //Schema.SObjectType sobjType = gd.get(objName);
                				//Schema.DescribeSObjectResult R = sobjType.getDescribe();
                            
                    	 }
                }
               
            //for(String s :objects )
            {
                //System.debug(s);
            } 
            for(String objName : sortObject)
            {
              // Schema.SObjectType sobjType = gd.get(objName);
                Schema.DescribeSObjectResult R = sobjType.getDescribe();
                 System.debug('SObjectType'+ ' '+R);
            }
        }
        catch(Exception e)
        {
            System.debug('An exception occurred: ' + e.getMessage());
        }
    }
    
*/
    
        }
    }
        
}