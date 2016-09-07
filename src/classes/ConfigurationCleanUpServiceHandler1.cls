public with sharing class ConfigurationCleanUpServiceHandler1 {
   public static string generateJson(Map<string, List<List<string>>> apexTriggerList){
    	JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeFieldName('data');
        gen.writeStartArray();
        Integer count = 1;	
        
        for(String objectName: apexTriggerList.keySet()){
         	gen.writeStartObject();
        	gen.writeStringField('id', String.valueOf(count));
        	gen.writeStringField('name', objectName);
        	gen.writeStringField('enbl', '0');
        	gen.writeStringField('level', '0');
        	gen.writeStringField('parent', '');
        	gen.writeStringField('isLeaf', 'false');
        	gen.writeStringField('expanded', 'false');
        	gen.writeStringField('loaded', 'false');
        	gen.writeEndObject();
            Integer ChildCount = 0;
            
            for(List<String> triggerDetails : apexTriggerList.get(objectName)){
                gen.writeStartObject();
        		gen.writeStringField('id', count + '' + (ChildCount+1));
        		gen.writeStringField('triggerID', triggerDetails[1]);
        		gen.writeStringField('name', triggerDetails[0]);
        		gen.writeStringField('enbl', '0');
        		gen.writeStringField('level', '1');
                gen.writeStringField('parentName', objectName);
        		gen.writeStringField('parent', String.valueOf(count));
        		gen.writeStringField('isLeaf', 'true');
        		gen.writeStringField('expanded', 'false');
        		gen.writeStringField('loaded', 'false');
        		gen.writeEndObject();
                ChildCount++;
            }
			count++;
        }
         gen.writeEndArray();
        gen.writeEndObject();
        return gen.getAsString();
    }
}