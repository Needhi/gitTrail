public with sharing class CreateTask_Handler {

    //Constructor
    public CreateTask_Handler(){}

	public List<Task> createTask(List<Account> accountList){
		
      CreateTask_Account account = new CreateTask_Account();	
	  List<Task> addTask = account.createTaskAfterCreationOfAccount(accountList);	
	  return addTask;
	  	
	}
}