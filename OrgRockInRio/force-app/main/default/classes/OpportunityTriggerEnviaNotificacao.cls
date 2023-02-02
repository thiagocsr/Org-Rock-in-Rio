public class OpportunityTriggerEnviaNotificacao {

    private List<Opportunity> m_listDataNew;
    private Map<Id, Opportunity> m_mapDataOld;
    private Map<Id, Opportunity> m_mapObjFiltered = new Map<Id, Opportunity>();
    private Boolean hasRecords;
    
	public OpportunityTriggerEnviaNotificacao(List<Opportunity> lstDataNew, Map<Id,Opportunity> mapDataOld){
        this.m_listDataNew = lstDataNew;
        this.m_mapDataOld = mapDataOld;
        filter();
        this.hasRecords = !m_mapObjFiltered.isEmpty();
    }

    private void filter(){
        for(Opportunity itemNew : m_listDataNew){
            if(itemNew.TipoPatrocinio__c == 'Parceiro Atração' 
               		&& itemNew.StageName != m_mapDataOld.get(itemNew.Id).StageName //IS CHANGED
               			&& itemNew.StageName == 'Fechado/Ganho'){
                            m_mapObjFiltered.put(itemNew.Id, itemNew);
            }
        }
    }
    
    
    public void run(){
        if(hasRecords){
            //Buscando atrações da(s) Oportunidade(s) fechado/ganho
            List<ParceiroAtracao__c> parceiroAtracaoList = [SELECT Id, 
                                                                Valor_Destinado__c,
                                                            	Atracao__c,
                                                                Atracao__r.Conta__r.Valor_Base_Cache__c,
                                                            	Atracao__r.Conta__r.Name,
                                                                Oportunidade__r.OwnerId,
                                                                Oportunidade__r.Owner.Name
                                                            FROM ParceiroAtracao__c 
                                                            WHERE Oportunidade__c in : m_mapObjFiltered.keySet()];
			
            //Monta set de atrações para buscar as oportunidades como Fechado/Ganho
            Set<Id> atracoes = new Set<Id>();
            for(ParceiroAtracao__c parceiroAtracao : parceiroAtracaoList){
                atracoes.add(parceiroAtracao.Atracao__c);
            }
            
            Map<Id, Decimal> mapaDebitoAtracoes = buscarMapaDebitoAtracoes(atracoes, m_mapObjFiltered.keySet());
            
            CustomNotificationType notificationType = SendCustomNotification.getCustomNotificationType('NotificacaoOportunidade');
            
           	for(ParceiroAtracao__c parceiroAtracao : parceiroAtracaoList){
                if(mapaDebitoAtracoes.containsKey(parceiroAtracao.Atracao__c)){
                    Decimal valorRestanteAtracao = mapaDebitoAtracoes.get(parceiroAtracao.Atracao__c);
                    if(valorRestanteAtracao > 0 && (valorRestanteAtracao - parceiroAtracao.Valor_Destinado__c) <= 0){
                        enviaNotificacao(parceiroAtracao.Oportunidade__c, parceiroAtracao.Atracao__r.Conta__r.Name, notificationType.Id, parceiroAtracao.Oportunidade__r.OwnerId);
                    }
                }else{
                    Decimal valorAtracao = parceiroAtracao.Atracao__r.Conta__r.Valor_Base_Cache__c;
                    if(valorAtracao > 0 && (valorAtracao - parceiroAtracao.Valor_Destinado__c) <= 0){
                        enviaNotificacao(parceiroAtracao.Oportunidade__c, parceiroAtracao.Atracao__r.Conta__r.Name, notificationType.Id, parceiroAtracao.Oportunidade__r.OwnerId);
                    }
                    
                }
            }
        }
    }
    
    private Map<Id, Decimal> buscarMapaDebitoAtracoes(Set<Id> atracoes, Set<Id> oportunidadesQueEstaoEncerrando){
        Map<Id, Decimal> mapaDebitoAtracoes = new Map<Id, Decimal>();
        
        //Busca todas os parceiros atrações já encerrados anteriormente
        List<ParceiroAtracao__c> parceiroAtracoesFechadoGanho = [
            SELECT Id, 
            Valor_Destinado__c,
            Atracao__c,
            Atracao__r.Conta__r.Valor_Base_Cache__c,
            Oportunidade__r.OwnerId,
            Oportunidade__r.Owner.Name
            FROM ParceiroAtracao__c 
            WHERE Atracao__c in : atracoes
            AND Oportunidade__r.StageName = 'Fechado/Ganho'
            AND Oportunidade__c NOT in :oportunidadesQueEstaoEncerrando 
        ];
        
        for(ParceiroAtracao__c parceiroAtracao : parceiroAtracoesFechadoGanho){
        	Decimal cacheBanda = parceiroAtracao.Atracao__r.Conta__r.Valor_Base_Cache__c;
            Id atracaoId = parceiroAtracao.Atracao__c;
            
            if(!mapaDebitoAtracoes.containsKey(atracaoId)){
                mapaDebitoAtracoes.put(atracaoId, (cacheBanda - parceiroAtracao.Valor_Destinado__c));
            }else{
                Decimal cacheBandaComDebitos = mapaDebitoAtracoes.get(atracaoId);
                mapaDebitoAtracoes.put(atracaoId, (cacheBandaComDebitos - parceiroAtracao.Valor_Destinado__c));
            }
        }
        
        return mapaDebitoAtracoes;
    }
    
    private void enviaNotificacao(Id oppId, String atracao, Id notificationTypeId, Id OwnerId){
        SendCustomNotification notifica = new SendCustomNotification();
        SendCustomNotification.sendNotifications(
                   ' PARABÉNS, A META DA ATRAÇÃO '+atracao+' FOI BATIDA, VOCÊ VAI GANHAR UM BÔNUS.', 
                   '',
                   oppId,
                   'META BATIDA', 
                   notificationTypeId,
            	   new Set<String> {OwnerId}
        );
    }   
    
    //Notificar quando o consultor bater uma meta
    //
    //1 - Construir uma Trigger (classe de automação) OK
    //2 - Filtrar os registros que foram fechado/ganho do Tipo PARCEIRO ATRAÇÃO (método Filter) OK
    //3 - Buscar as atrações vinculadas as oportunidades encerradas (objeto PARCEIRO ATRAÇÂO) OK
    //4 - Sabendo quais atrações terão um aporte financeiro, buscar as demais oportunidades 
    //encerradas vinculadas as atrações buscadas no Item 3
    //	4.1 - Montar set com atrações para buscar OK
    //	4.2 - Query para buscar atrações com os valores aportados OK
    //5 - Validar quais nao tiveram a meta batida ainda e verificar o saldo (restante a completar) OK
    //6 - Verificar quais atrações terão a Meta Batida com o valor destinado as atrações das
    //oportunidades que estão encerrando (Item 3) OK
    //7 - Para cada atração com meta batida enviar notificação OK    
    
}