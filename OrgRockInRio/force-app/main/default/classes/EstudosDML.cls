public class EstudosDML {

    //SObject
    
    //primeiro exemplo de INSERT
    public static void insertHelloWorld(){
		
		Account conta = new Account();
        conta.Name = 'Hello World Account';
        conta.Phone = '99999-9999';
        conta.Valor_Base_Cache__c = 100000;
        
        insert conta;
        
        system.debug('CONTA ID >>>>> ' + conta.Id);
    }
    
    public static void insertHelloWorld_2(){
		
		Account conta = new Account(Name = 'Hello World Account - Com Construtor', 
                                    Phone = '88888-8888', 
                                    
Valor_Base_Cache__c = 200000);
        
        insert conta;
        
        system.debug('CONTA ID >>>>> ' + conta.Id);
    }
    
    public static void insertHelloWorld_3(){		
		insert new Account(Name = 'Hello World Account - Com Construtor - 2', 
                           Phone = '88888-8888', 
                           Valor_Base_Cache__c = 300000);
 
    }
    
    public static Account insertAccount(String nomeConta, String telefone, Decimal cache){
        Account conta = new Account();
        conta.Name = nomeConta;
        conta.Phone = telefone;
        conta.Valor_Base_Cache__c = cache;
        
        insert conta;
        return conta;
    }
    
    public static void alterarCacheById(Id contaId, Decimal novoCache){
        Account conta = new Account();
        conta.Id = contaId;
        conta.Valor_Base_Cache__c = novoCache;
        update conta;
    }
    
    public static void insertAccounts(List<Account> contas){
        Database.SaveResult[] lsr = Database.insert(contas, false);
        
        for(Database.SaveResult result : lsr){
            if(!result.isSuccess()){
               
            }
        }
    }
    
    public static void upsertAccounts(List<Account> novasContas){
        Account[] acctsList = [SELECT Id, Name FROM Account WHERE Estilo__c = '' AND RecordType.DeveloperName = 'Banda'];
        
        for(Account a : acctsList){
            a.Estilo__c = 'Country';
        }
        
        acctsList.addAll(novasContas);
        
        try{
            upsert acctsList;
        } catch (DmlException e){
			system.debug('Exceção : ' + e.getMessage());            
        }
    }
    
}