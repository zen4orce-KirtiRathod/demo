public class TestParamController{
    String paramValue;
    String inputValue;
    
    public TestParamController(){
        this.inputValue = 'Hai';
    }
    
    public String getParamValue(){
        return paramValue;
    }
    
    public void setParamValue(String paramValue){
        this.paramValue = paramValue;
    }
    
    public String getInputValue(){
        return inputValue;
    }
    
    public void setInputValue(String inputValue){
        this.inputValue = inputValue;
    }
    
    public void passParam(){
        System.debug('ParamValue :'+ this.paramValue);
    }
}