public class ToolingAPIService {
    
    //METHOD TO DELETE TRIGGER USING REST API
     public void WorkflowDelete(ID a , String sessionID){
        String endp = URL.getSalesforceBaseUrl().toExternalForm() +'/services/data/v29.0/tooling/sobjects/Workflow/'+ a;
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization', 'OAuth  ' + sessionID);
            req.setHeader('Content-Type', 'application/json');
            req.setEndpoint(endp);
            req.setMethod('DELETE');
        
            Http h = new Http();
            HttpResponse res = h.send(req);
            system.debug('************************** Workflow Response'+res.getStatus());
    }
    
    public void TriggerDelete(ID a , String sessionID){
        String endp = URL.getSalesforceBaseUrl().toExternalForm() +'/services/data/v29.0/tooling/sobjects/ApexTrigger/'+ a;
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization', 'OAuth  ' + sessionID);
            req.setHeader('Content-Type', 'application/json');
            req.setEndpoint(endp);
            req.setMethod('DELETE');
        
            Http h = new Http();
            HttpResponse res = h.send(req);
            system.debug('************************** Trigger Response'+res.getStatus());
    }
    
    //METHOD TO DELETE CLASS USING REST API
    public void ClassDelete(ID a , String sessionID){
        String endp = URL.getSalesforceBaseUrl().toExternalForm() +'/services/data/v29.0/tooling/sobjects/ApexClass/'+ a;
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization', 'OAuth  ' + sessionID);
            req.setHeader('Content-Type', 'application/json');
            req.setEndpoint(endp);
            req.setMethod('DELETE');
        
            Http h = new Http();
            HttpResponse res = h.send(req);
            system.debug('************************** Class Response'+res.getStatus());
    }
    
    //METHOD TO DELETE VISUALFORCE PAGE USING REST API
    public void PageDelete(ID a , String sessionID){
        String endp = URL.getSalesforceBaseUrl().toExternalForm() +'/services/data/v29.0/tooling/sobjects/ApexPage/'+ a;
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization', 'OAuth  ' + sessionID);
            req.setHeader('Content-Type', 'application/json');
            req.setEndpoint(endp);
            req.setMethod('DELETE');
        
            Http h = new Http();
            HttpResponse res = h.send(req);
            system.debug('************************** Page Response'+res.getStatus());
    }

}