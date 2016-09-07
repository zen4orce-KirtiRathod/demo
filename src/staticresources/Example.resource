<script type="text/javascript">
      var j$=jQuery.noConflict();
    	j$(document).ready(function(){
          j$("#myDialog").dialog({
             autoOpen  : false,
             modal     : true,
             closeText:""
		});
        
        j$("#dependancyCheck").dialog({
             autoOpen  : false,
             modal     : true,
             closeText: "",
             buttons : [{
                  text: "Confirm",
                  click: function() {
                     deleteRecords();
                  },
                 style : "position: absolute; left:20px;"
               },
               {
                  text: "Cancel",
                  click: function() {                      
                      j$(this).dialog("close");
                  }
               }]
		});
        j$("#NoData").dialog({
        	autoOpen : false,
            modal    : true,
            closeText : "",
            buttons : [{
                  text: "Confirm",
                  click: function() {
                      j$(this).dialog("close");
                  },
                 style : "position: absolute; left:20px;",
                 click : function(){
            	deleteRecords();
            }
               },
               {
                  text: "Cancel",
                  click: function() {                      
                      j$(this).dialog("close");
                  }
               }]
            });
           
    });
    function showCount(count)
      {
          debugger;
          console.log(count);
          j$("#recordCount").text(count);
      	  j$("#myDialog").dialog("open");
          
      }
    function showDependency(dependentList)
    { 
        if(dependentList.length > 2)
        {
            j$("#dependentObjects").text(dependentList);
        	j$("#dependancyCheck").dialog("open");
		}
         else
         {
             
             j$("#NoRecordData").text();
             j$("#NoData").dialog("open");
         }
                
       
    }
</script>