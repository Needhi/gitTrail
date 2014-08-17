public with sharing class RedirectController {

  public PageReference reDirect(){
    PageReference pageRef = new PageReference('http://www.google.com');
    return pageRef; 
  }
}