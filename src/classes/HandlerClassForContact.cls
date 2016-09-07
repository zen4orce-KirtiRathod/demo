public with sharing class HandlerClassForContact extends BaseTrigger{
    
    // Constructor
    public HandlerClassForContact()
    {
    }
 
    public void bulkBefore()
    {
    }
 
    public void bulkAfter()
    {
    }
 
    public void beforeInsert(list<Contact> newlist)
    {
        list<Account> accList = new list<Account>();
        for(Contact  c : newlist)
        {
            if(c.Account == null)
            {
             	Account a = new Account(Name = 'Hello');
                 
                accList.add(a);
            }
        }
        insert accList;
        if(accList.size() > 0)
        {
            for(Account a :accList)
            {
               for(Contact  c : newlist)
        		{
                    if(c.Account == null)
                    {
                        c.AccountId = a.id;
                    }
        		}
    
    		}
        }
     } 
 
    public void beforeUpdate(Map<Id,SObject> oldSo, Map<Id,SObject> so)
    {
    }
    
    public void beforeDelete(List<SObject> so)
    {
        
    }
 
    public void afterInsert(List<SObject> so)
    {
        
        
    }
 
    public void afterUpdate(Map<id,sObject> oldMap, Map<Id,sObject> newMap)
    {
        
        
        
        
    }
 
    public void afterDelete(List<SObject> so)
    {
    }
 
    public void andFinally()
    {
        
    }
}