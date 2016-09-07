public with sharing class ConfigurationCleanUpServiceHandler {
   public static string generateJsonForTrigger(Map<string, List<List<string>>> configurationList){
       System.debug('In Service Handler ');
    	JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeFieldName('data');
        gen.writeStartArray();
        Integer count = 1;	
        
        for(String objectName: configurationList.keySet()){
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
            
            for(List<String> configDetails : configurationList.get(objectName))
            {
                gen.writeStartObject();
        		gen.writeStringField('id', count + '' + (ChildCount+1));
        		gen.writeStringField('configID', configDetails[1]);
        		gen.writeStringField('name', configDetails[0]);
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
    public static string generateJsonForApexPage(List<ApexPage> configurationList){
    	JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeFieldName('data');
        gen.writeStartArray();
        Integer count = 1;	
        
        for(ApexPage apexPageObj: configurationList){
         	gen.writeStartObject();
        	gen.writeStringField('id', String.valueOf(count));
        	gen.writeStringField('configID', apexPageObj.ID);
        	gen.writeStringField('name', apexPageObj.Name);
        	gen.writeStringField('enbl', '0');
        	gen.writeStringField('level', '0');
        	gen.writeStringField('parent', '');
        	gen.writeStringField('isLeaf', 'false');
        	gen.writeStringField('expanded', 'false');
        	gen.writeStringField('loaded', 'false');
        	gen.writeEndObject();
			count++;
        }
        gen.writeEndArray();
        gen.writeEndObject();
        return gen.getAsString();
    }
}