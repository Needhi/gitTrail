public with sharing class CreateTask_Account {

    //Constructor
    public CreateTask_Account(){}
    
    public List<Task> createTaskAfterCreationOfAccount(List<Account> accountList){
    
        List<Task> taskToAdd = new List<Task>();
        
        for(Account account : accountList){
        	Task task = new Task();
        	
        	task.Subject = 'Meeting with ' + account.Name;
        	task.WhatId = account.Id;
        	taskToAdd.add(task);
        }//for ends 
              
    	return taskToAdd;
    }
}