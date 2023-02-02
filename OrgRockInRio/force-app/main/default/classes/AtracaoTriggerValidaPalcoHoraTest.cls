@isTest 
public class AtracaoTriggerValidaPalcoHoraTest {

    //Método onde eu configuro os dados (ou apenas os principais) que eu preciso 
    //para os meus cenários de teste
    @testSetup 
    static void setup() {
        //Criar uma conta para um show pre definido
        //Criar outra conta para uma atração a ser criado
        
        Account conta1 = new Account();
        conta1.Name = 'Bon Jovi';
        conta1.Phone = '99999-9999';
        conta1.Valor_Base_Cache__c = 100000;
        conta1.Email__c = 'bonjovi@gmail.com';
        
        Account conta2 = new Account();
        conta2.Name = 'Guns';
        conta2.Phone = '99999-9999';
        conta2.Valor_Base_Cache__c = 100000;
        conta2.Email__c = 'guns@gmail.com';
        
        insert new List<Account>{conta1, conta2};
        
        Atracao__c atracaoBonJovi = new Atracao__c();
        atracaoBonJovi.Conta__c = conta1.Id;
        atracaoBonJovi.Palco__c = 'Palco Mundo';
        atracaoBonJovi.Data_Hora__c = Datetime.newInstance(2023, 9, 22, 20, 00, 00);
        atracaoBonJovi.Data_Hora_Final__c = Datetime.newInstance(2023, 9, 22, 21, 30, 00);

        insert atracaoBonJovi;
            
	}
    
    @isTest 
    static void criticaCriacaoNovaAtracaoNaDataInicio() {
    	Account guns = [SELECT Id FROM Account WHERE Name = 'Guns'];
        
        Atracao__c atracaoGuns = new Atracao__c();
        atracaoGuns.Conta__c = guns.Id;
        atracaoGuns.Palco__c = 'Palco Mundo';
        atracaoGuns.Data_Hora__c = Datetime.newInstance(2023, 9, 22, 19, 40, 00);
        atracaoGuns.Data_Hora_Final__c = Datetime.newInstance(2023, 9, 22, 21, 00, 00);
        
        try{
			insert atracaoGuns;            
        }catch(Exception e){
            System.assert(e.getMessage().contains('Estará ocorrendo a preparação + show'));
        }
    }
    
    @isTest 
    static void criticaCriacaoNovaAtracaoNaDataFim() {
    	Account guns = [SELECT Id FROM Account WHERE Name = 'Guns'];
        
        Atracao__c atracaoGuns = new Atracao__c();
        atracaoGuns.Conta__c = guns.Id;
        atracaoGuns.Palco__c = 'Palco Mundo';
        atracaoGuns.Data_Hora__c = Datetime.newInstance(2023, 9, 22, 19, 00, 00);
        atracaoGuns.Data_Hora_Final__c = Datetime.newInstance(2023, 9, 22, 21, 00, 00);
        
        try{
			insert atracaoGuns;            
        }catch(Exception e){
            System.assert(e.getMessage().contains('Estará ocorrendo a preparação + show'));
            List<Atracao__c> atracoes = [SELECT Id FROM Atracao__c WHERE Conta__r.Name = 'Guns'];
            System.assert(atracoes.isEmpty()); 
            
        }
    }
    
    @isTest 
    static void permiteCriarNovaAtracao(){
        Account guns = [SELECT Id FROM Account WHERE Name = 'Guns'];
        
        Atracao__c atracaoGuns = new Atracao__c();
        atracaoGuns.Conta__c = guns.Id;
        atracaoGuns.Palco__c = 'Palco Mundo';
        atracaoGuns.Data_Hora__c = Datetime.newInstance(2023, 9, 22, 18, 00, 00);
        atracaoGuns.Data_Hora_Final__c = Datetime.newInstance(2023, 9, 22, 19, 00, 00);
        
        insert atracaoGuns;
        
        System.assert(atracaoGuns.Id != null);
        System.assertEquals(true, atracaoGuns.Id != null);
        
        List<Atracao__c> atracoes = [SELECT Id FROM Atracao__c WHERE Conta__r.Name = 'Guns'];
		System.assert(!atracoes.isEmpty());        
        
        
    }
}