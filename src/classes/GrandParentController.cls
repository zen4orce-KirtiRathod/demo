global virtual with sharing class GrandParentController  {
      @RemoteAction
    global static String sayHello(String helloTo)
    {
        return 'Hello' + helloTo + 'from the grandparent.' ;
    }

}