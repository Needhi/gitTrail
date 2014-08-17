public class vfpagetest{

public Map<String,Map<String,String>> tmp {get;set;}
public String s {get;set;}

    public vfpagetest(){
    s = 'TEST';
        tmp = New Map<String,Map<String,String>>();

        tmp.put('1',New Map<String,String>{'A'=>'3','B'=>'4'});
        tmp.put('2',New Map<String,String>{'C'=>'5','D'=>'6'});
    system.debug(logginglevel.error,tmp);
    }


}