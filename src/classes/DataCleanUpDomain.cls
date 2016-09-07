public  with sharing class DataCleanUpDomain {
    Public Static integer NumberOfRecordsNotCreated = 0;
    Public Static integer NumberOfRecordsCreated = 0;
    //Delete a list of records --
    public static void executeMethod(list<SObject> lstOfRecords)
    {
       if(lstOfRecords.size() > 0)
        {
            Database.DeleteResult[]  results = Database.delete(lstOfRecords, false);
            for (Database.DeleteResult sr :results)
        	{  
                if (sr.isSuccess()) 
                {
                    NumberOfRecordsCreated++;
                }
                else
                {
                    NumberOfRecordsNotCreated++;
                }
            }
        }
    }

}