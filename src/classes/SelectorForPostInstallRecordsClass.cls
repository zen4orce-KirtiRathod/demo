global class SelectorForPostInstallRecordsClass {
    
    public StaticResource queryOnStaticResourceData()
    {
        StaticResource s = new StaticResource();
        s = [SELECT id,Body FROM StaticResource WHERE Name = 'XYZ'];
        return s;
     }

}