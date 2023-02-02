public class CriaTarefasAtracoes {

    //iremos criar uma classe que cria tarefas para as 
    //atrações das Bandas que possuem Parceiro Atração 
	  //pois tem patrocínios que para atrações específicas

    //Quando a oportunidade for FECHADO/GANHO serão criada as Tarefas
    //Com o assunto (subject) 'Adicionar Propagando no Telão da Banda .....' 30 minuto antes da Data/hora do Evento
    //Vou usar o Objetos Tarefa (Task), Atracao__c
    
    @InvocableMethod(label='Cria Tarefas para Parceiro Atrações' description='Cria Tarefas para Parceiro Atrações' category='Opportunity')
    public static void criaTarefasAtracoes(List<Id> oportunidades){
        //N - N (Oportunidade e Atração a partir do objeto Parceiro_Atracao__c)
        List<ParceiroAtracao__c> parceiroAtracoes = [SELECT Atracao__c, Oportunidade__r.AccountId, Oportunidade__r.Account.Name, Atracao__r.Data_Line_up__c 
                                                     FROM ParceiroAtracao__c 
                                                     WHERE Oportunidade__c in : oportunidades];
        
        List<Task> tarefas = new List<Task>();
        for(ParceiroAtracao__c atracao : parceiroAtracoes){
            //Data Vencimento, Assunto, WhatId, AccountId
            
            Task tarefa = new Task();
            tarefa.Subject = 'Adicionar Propagando no Telão da Banda ' + atracao.Oportunidade__r.Account.Name;
            tarefa.ActivityDate = atracao.Atracao__r.Data_Line_up__c;
            //tarefa.AccountId = atracao.Oportunidade__r.AccountId;
            tarefa.WhatId = atracao.Atracao__c;
            tarefa.OwnerId = '2F0058c00000CteoH'; //NÃO É BOA PRÁTICA MAS PREENCHE O ID DO USUARIO PARA TESTE
            tarefas.add(tarefa);
        }
        
        insert tarefas;
    }
    
}