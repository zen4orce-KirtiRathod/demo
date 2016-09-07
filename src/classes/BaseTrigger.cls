public abstract  class BaseTrigger implements TrigInterface{
    
    	public void insertRecord(list<sObject> sobjectLsttoUpdate){
        if(!sObjectLsttoUpdate.isEmpty()){
            try{
               
                insert sobjectLsttoUpdate;
            }catch(Exception e){
                
            }
           
        }
    }
    
    public void updateRecord(list<sObject> sobjectLsttoUpdate){
        if(!sObjectLsttoUpdate.isEmpty()){
            try{
                update sobjectLsttoUpdate;
            }catch(Exception e){
                
            }
           
        }
    }

}