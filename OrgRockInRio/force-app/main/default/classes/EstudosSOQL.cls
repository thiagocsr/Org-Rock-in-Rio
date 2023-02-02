public class EstudosSOQL {

    /*
     	SELECT Id, Name, Valor_Base_Cache__c FROM Account 
		WHERE Valor_Base_Cache__c > 0
		LIMIT 100 
     */
    
    public static Account selectHelloWorld(){
    	Account conta = [SELECT Valor_Base_Cache__c 
                         FROM Account 
                         WHERE Id = '0018c00002WcSZuAAN'
						 ];
        return conta;
    }
    
    
    public static List<Account> buscarContasValorCacheMaiorQue1000(){
        List<Account> contas = [SELECT Id, Name, Valor_Base_Cache__c FROM Account 
                            WHERE Valor_Base_Cache__c > 1000
                            LIMIT 100 
						 ];
        return contas;
        
    }
    
    public static Account getContaById(Id contaId){
    	Account conta = [SELECT Name, Valor_Base_Cache__c 
                         FROM Account 
                         WHERE Id = :contaId
						 ];
        return conta;
    }

    //LIST para retornar 1 registro
    public static Account getContaById_2(Id contaId){
    	List<Account> contas = [SELECT Name, Valor_Base_Cache__c 
                         FROM Account 
                         WHERE Id = :contaId
						 ];
        
        Account conta = null;
        if(!contas.isEmpty()){
            conta = contas[0];
        }
        
        return conta;
    }
    
    public static List<Account> getAccountsById(Set<Id> ids){
        return [SELECT Name, Valor_Base_Cache__c 
                FROM Account 
                WHERE Id in :ids
               ];  
    }
    
    public static Account getAccountById(Id accountId){
        //Collection do tipo SET
        //SET evita variaveis duplicados
        //Minha intenção foi não escrever a query de novo, quis reaproveitar
        
        List<Account> contas = getAccountsById(new Set<Id> {accountId});
        
        Account conta = null;
        if(!contas.isEmpty()){
            conta = contas[0];
        }
        
        return conta;
    }
	    
    //Retorna Atrações com valores do campo de pesquisa Conta__c
    public static List<Atracao__c> getAtracoes(){
        return [SELECT Conta__c, Conta__r.Name, Conta__r.ValorCacheLiquido__c, Data_Line_up__c FROM Atracao__c];
    }
    
    public static List<Account> getContasQuePossuemAtracao(){
        List<Atracao__c> atracoes = getAtracoes();
        
        Set<Id> setContaIds = new Set<Id>();
        
        for(Atracao__c atracao : atracoes){
            setContaIds.add(atracao.Conta__c);
        }
        
        //system.debug('>>>> LIST: ' + contaIds);
        //system.debug('>>>> SET: ' + setContaIds);

        //Buscar as Contas
        return getAccountsById(setContaIds);
    }

    //MAP --> Primeiro JEITO (Criando Map e populando iterando a lista)
    public static Map<Id, Atracao__c> getMapAtracoes(){
        List<Atracao__c> atracoes = getAtracoes();
        Map<Id, Atracao__c> mapa = new Map<Id, Atracao__c>();
        for(Atracao__c atracao : atracoes){
            mapa.put(atracao.Id, atracao);
        }
        
        return mapa;
    }

    //MAP --> Segundo JEITO (Criando Map passando a lista ou query no Construtor)
	public static Map<Id, Atracao__c> getMapAtracoes_2(){
        List<Atracao__c> atracoes = getAtracoes();
        Map<Id, Atracao__c> mapa = new Map<Id, Atracao__c>(atracoes);
        return mapa;
    }
    
    //MAP --> Terceiro JEITO (retornando direto a instancia do Map passando a lista ou query no Construtor)
	public static Map<Id, Atracao__c> getMapAtracoes_3(){
        return new Map<Id, Atracao__c>(getAtracoes());
    }    
    
    public static List<Account> getContasComListaAtracoes(){
        return [
            SELECT Name, Valor_Base_Cache__c,  
            (SELECT Id FROM Atracao__r)
            FROM 
            Account
            WHERE
            RecordType.DeveloperName = 'Banda'
        ];
    } 
    
    //Quem realmente possuam atrações
    public static List<Account> getContasComAtracoes(){
        return [
            SELECT Name, Valor_Base_Cache__c,  
            (SELECT Id FROM Atracao__r)
            FROM 
            Account
            WHERE
            RecordType.DeveloperName = 'Banda'
            AND
            Id in (SELECT Conta__c FROM Atracao__c)
        ];
    }
    
    public static List<Account> getBandas(String estilo, Decimal cacheMinimo){
        
        String query = 'Select Name, Valor_Base_Cache__c FROM Account Where RecordType.DeveloperName = \'Banda\' ';
        
        if(!String.isBlank(estilo)){
            query += ' AND Estilo__c = :estilo';
        }
        
        if(cacheMinimo != null && cacheMinimo > 0){
            query += ' AND Valor_Base_Cache__c >= :cacheMinimo';
        }
        
        return Database.query(query);
    }
    
}