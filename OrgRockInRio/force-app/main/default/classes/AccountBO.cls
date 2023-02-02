public class AccountBO {

    public AccountBO(){
        
    }
    
    public void notificaNovasBandas(List<Account> contas){
        enviaTarefaNovaBanda(contas);
        enviaEmailNovaBanda(contas);
    }
    
    private void enviaTarefaNovaBanda(List<Account> contas){
        
        List<Task> tasks = new List<Task>();
        
        for(Account conta : contas){
            Task tarefa = new Task();
            tarefa.Subject = 'Entrar em contato com a Banda ' + conta.Name;
            tarefa.OwnerId = conta.OwnerId;
            tarefa.WhatId = conta.Id;
            tarefa.ActivityDate = System.today().addDays(1);
            
            tasks.add(tarefa);
        }
        
        insert tasks;
        
    }
    
    private void enviaEmailNovaBanda(List<Account> contas){
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        
        for(Account conta : contas){
            
            //We instantiate our single email message object
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
           // Strings to hold the email addresses to which you are sending the email.
           String[] toAddresses = new String[] {conta.Email__c};
           //Assign the TO address to our mail object
           mail.setToAddresses(toAddresses);
    
           // Set the subject line for your email address.
           mail.setSubject('Bem-Vindo ao Rock in Rio!!!');
    
           // You can set this to true if you want to BCC yourself on the email
           mail.setBccSender(false);
    
           // You can specify your plain text here
           mail.setPlainTextBody('Bem-Vindo ao RiR!!!');
    
           //Specify any html - for example this will display a link in the email
           mail.setHtmlBody('Your Link <a href=https://www.rockinrio/rio/pt-br/home.com/>Rock in Rio.</a>');
    
           emails.add(mail);            
           
        }
        
         Messaging.SendEmailResult[] results = Messaging.sendEmail(emails);
        for(Messaging.SendEmailResult result : results){
            if (result.success) {
            	System.debug('The email was sucess!');
         	}else {
            	System.debug('The email failed to send: ' + result.errors[0].message);
         	}
        }
        
         
    }  
}