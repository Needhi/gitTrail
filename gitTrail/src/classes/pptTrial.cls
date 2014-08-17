public class pptTrial {    

private Boolean EditMode = false;
// Setter method
public String selectedValue { get;set; }
// Constructor method
public pptTrial() {
    if (selectedValue != null) {
        EditMode = true;
    }
    system.debug('**EditMode **'+EditMode);
}
public PageReference save(){
    system.debug('**selectedValue**'+selectedValue);
    return null;
}


//Constructor method
/*public pptTrial () {
    if (selectedValue != null) {
        EditMode = true;
    }
    system.debug('**EditMode **'+EditMode);
}

private Boolean EditMode = false;
//Setter method
public String selectedValue { get;set; }

public PageReference save(){
    system.debug('**selectedValue**'+selectedValue);
    return null;
}*/

}