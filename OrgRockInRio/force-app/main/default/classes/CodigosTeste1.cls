public class CodigosTeste1 {
/*Account conta = new Account();
conta.Name = 'Hello World Account 3';
conta.Phone = '99999-9999';
conta.Valor_Base_Cache__c = 100000;

insert conta;

system.debug('CONTA ID >>>>> ' + conta.Id);

// -------------

System.debug('INSERT CONTA >>>>>> ' + EstudosDML.insertAccount('Slipknot', '99999-9999', 1000000));

// -------------

EstudosDML.alterarCacheById('0018c00002V2CkoAAF', 7000000);

// -------------

System.debug('SELECT CONTA >>>>>> ' + EstudosSOQL.selectHelloWorld());
System.debug('SELECT CONTAS - CACHE > 1000 >>>>>> ' + EstudosSOQL.buscarContasValorCacheMaiorQue1000());
System.debug('SELECT CONTA BY ID >>>>>> ' + EstudosSOQL.getContaById('0018c00002V2CkoAAF')); //Conta não existe dá erro
System.debug('SELECT CONTA BY ID 2 (Mais comum) >>>>>> ' + EstudosSOQL.getContaById_2('0018c00002V2CkoAAF'));

// ------

System.debug('SELECT ATRACOES >>>>>> ' + EstudosSOQL.getAtracoes());
System.debug('SELECT CONTAS COM ATRACOES >>>>>> ' + EstudosSOQL.getContasQuePossuemAtracao());
System.debug('MAP ATRACOES 1 >>>>> ' + EstudosSOQL.getMapAtracoes());
System.debug('MAP ATRACOES 2 >>>>> ' + EstudosSOQL.getMapAtracoes_2());

System.Debug('vv Atrações vv ');
for(Atracao__c atracao : EstudosSOQL.getAtracoes()){
    System.Debug('Atração: ' + atracao.Conta__r.Name);
    System.Debug('Valor Liquido Cache Atração: ' + atracao.Conta__r.ValorCacheLiquido__c);
}

List<Account> contasComListaAtracoes = EstudosSOQL.getContasComListaAtracoes();

System.Debug('vv Contas vv ');
for(Account conta : contasComListaAtracoes){
	System.debug('Conta: ' + conta.Name + ' - Atrações: ' + conta.Atracao__r.size());
    /*for(Atracao__c atracao : conta.Atracoes__r){
        System.debug('Atração : ' + atracao.Id);
    }  
}

List<Account> contasQueRealmentePossuemAtracoes = EstudosSOQL.getContasComAtracoes();

System.Debug('vv Contas vv ');
for(Account conta : contasQueRealmentePossuemAtracoes){
	System.debug('Conta: ' + conta.Name + ' - Atrações: ' + conta.Atracao__r.size());  
}

//Rápido exemplo - Comparação Limites Salesforce
Account conta0 = new Account();
conta0.Name = 'Conta 1';
conta0.Phone = '99999-9999';
conta0.Valor_Base_Cache__c = 100000;

insert conta0;

Account conta2 = new Account();
conta2.Name = 'Conta 2';
conta2.Phone = '99999-9999';
conta2.Valor_Base_Cache__c = 100000;

insert conta2;

//------ AGORA INSERT COM LISTA

Account conta3 = new Account();
conta3.Name = 'Conta 1 - insert com lista';
conta3.Phone = '99999-9999';
conta3.Valor_Base_Cache__c = 100000;

Account conta4 = new Account();
conta4.Name = 'Conta 2 - insert com lista';
conta4.Phone = '99999-9999';
conta4.Valor_Base_Cache__c = 100000;

List<Account> contasToInsert = new List<Account> {conta, conta2};
insert contasToInsert;
*/
}