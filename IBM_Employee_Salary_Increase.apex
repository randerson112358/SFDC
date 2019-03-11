trigger IBM_Employee_Salary_Increase on IBM_Employee__c (before insert) {

List<IBM_Employee__c> emp = [Select id, name, Manager_Email__c, YearsAtCompany__c, Age__c from IBM_Employee__c limit 10000];

//Trigger.new (Returns a list of the new versions of the sObject records)
for(IBM_Employee__c e: Trigger.new){
  
  //Update the manager email address
  e.Manager_Email__c = 'ManagerEmail@gmail.com';
  
  //Check the years the employee has been at the company
  if(e.YearsAtCompany__c == 10){
    
     //Update the employees monthly income by 5%
     e.MonthlyIncome__c = e.MonthlyIncome__c * (1.05); 
  }
  
  //Send Email to the Manager if the employee has been with the company for 10 years and is older than 21
  if(e.YearsAtCompany__c == 10 && e.Age__c > 21){
      
      List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      List<String> sendTo = new List<String>();
      sendTo.add('ManagerEmail@gmail.com');
      mail.setToAddresses(sendTo);
      mail.setReplyTo('HumanResources@gmail.com');
      mail.setSenderDisplayName('Human resources');
      mail.setSubject('URGENT EMPLOYEE HAS BEEN WITH THE COMPANY FOR 10 YEARS, SALARY INCREASED');
      String body = 'Your employee'+e.name+' has been with the company for 10 years, their monthly income has increased by 5%';
      mail.setHtmlBody(body);
      mails.add(mail);
      Messaging.sendEmail(mails);
  
  }

}

//Update the IBM_Employee__c record(s)
update emp;

}
