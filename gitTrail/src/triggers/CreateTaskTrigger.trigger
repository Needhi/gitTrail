trigger CreateTaskTrigger on Account (after insert) {

    if(trigger.isAfter){
      if(Trigger.isInsert){
    	
    	  List<Account> accountList = new List<Account>();
    	  accountList = Trigger.new;
    	
    	  CreateTask_Handler handler = new CreateTask_Handler();
    	
    	  List<Task> addTask = handler.createTask(accountList);
    	
    	  if(addTask.size() > 0){
    		insert addTask;
    	  }
    	
      }   
    }
}