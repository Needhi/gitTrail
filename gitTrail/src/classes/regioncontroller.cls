public class regioncontroller {
    public String name { get; set; }
    public String job { get; set; }
    public String welcum { get; set; }
    public String strOncomplete{get; set;}
    public void save(){
       if(name==null || String.isBlank(name)){
          strOncomplete = 'no';
       } else {
          strOncomplete = 'yes';
          welcum = 'Welcome..... ' +name ;
       }      
    }
}