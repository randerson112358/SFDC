trigger Predict_IBM_Employee on IBM_Employee__c (before insert) {

    List<IBM_Employee__c> emp = [Select id, name, HourlyRate__c,YearsAtCompany__c, Attrition__c,TotalWorkingYears__c, Manager_Email__c, Retention_Comments__c, Attrition_Bool__c, MonthlyIncome__c, OverTime__c, Likelihood__c, Age__c from IBM_Employee__c limit 10000];
    
    
   //Trigger.new 
   for(IBM_Employee__c e:  Trigger.new){

   e.Manager_Email__c = 'managerEmail@gmail.com';
        
        if(e.MonthlyIncome__c < 4919){
            e.Likelihood__c = Math.round(Math.random()*5) + 94;
            e.Retention_Comments__c = 'Increase employee monthly income.';
        }
        else{
           if(e.OverTime__c == 'Yes'){
             e.Likelihood__c = Math.round(Math.random()*10) + 60;
             e.Retention_Comments__c = 'Decrease the number of projects the employee is on.';
           }
           else{
             if(e.Age__c < 36){
             e.Likelihood__c = Math.round(Math.random()*10) + 51;
             e.Retention_Comments__c = 'Allow this employee to work from home.';
             }
             else{
                if(e.TotalWorkingYears__c < 10){
                  e.Likelihood__c = Math.round(Math.random()*7) + 57;
                  e.Retention_Comments__c = 'Show this employee you appreciate them.';
                }
                else{
                  if(e.YearsAtCompany__c < 10){
                   e.Likelihood__c = Math.round(Math.random()*7) + 57;
                   e.Retention_Comments__c = 'Show this employee you appreciate them, and give them an award.';
                  }
                  else{
                     e.Likelihood__c = Math.round(Math.random()) + 20;
                     e.Retention_Comments__c = 'Everything seems okay';
                  }
                }
             }
           }
        }


         if(e.Likelihood__c >= 60){
           List<Messaging.SingleEmailMessage> mails =new List<Messaging.SingleEmailMessage>();
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           List<String> sendTo = new List<String>();
           sendTo.add('manager@gmail.com');
           mail.setToAddresses(sendTo);
           mail.setReplyTo('youremail@gmail.com');
           mail.setSenderDisplayName('Utz patil');
           mail.setSubject('URGENT EMPLOYEE AT RISK OF LEAVING');
           String body = 'Your employee '+e.Name+' is at risk of leaving the company\n\n<br><br>'+'Retention Suggestion: '+e.Retention_Comments__c;
           mail.setHtmlBody(body);
           mails.add(mail);
           Messaging.sendEmail(mails);
         }
}

update emp;

}
