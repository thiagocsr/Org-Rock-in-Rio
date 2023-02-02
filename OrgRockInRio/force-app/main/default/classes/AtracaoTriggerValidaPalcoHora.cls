public class AtracaoTriggerValidaPalcoHora {

    private List<Atracao__c> m_listDataNew;
    private Map<Id, Atracao__c> m_mapDataOld;
    private Map<Id, Atracao__c> m_mapObjFiltered = new Map<Id, Atracao__c>();
    private Map<Id, String> msgs = new Map<Id, String>();
    private Boolean hasRecords;

    public AtracaoTriggerValidaPalcoHora(List<Atracao__c> lstDataNew, Map<Id,Atracao__c> mapDataOld){
        this.m_listDataNew = lstDataNew;
        this.m_mapDataOld = mapDataOld;
        filter();
        this.hasRecords = !m_mapObjFiltered.isEmpty();
    }

    private void filter(){
        Set<String> palcos = new Set<String>();
        for(Atracao__c itemNew : m_listDataNew){
        	  palcos.add(itemNew.Palco__c);  
        }
        
        List<Atracao__c> atracoes = [SELECT Id, Conta__r.Name, Palco__c, Data_Hora__c, Data_Hora_Final__c
                                     FROM Atracao__c
                                    WHERE Palco__c in : palcos]; 
        
        //system.debug('Atrações : ' + atracoes);
        
        if(!atracoes.isEmpty()){
            for(Atracao__c itemNew : m_listDataNew){
                
                for(Atracao__c atracaoExistente : atracoes){
                    //system.debug('itemNew.Palco__c : ' + itemNew.Palco__c);
                    //system.debug('itemNew.DataHora__c : ' + atracaoExistente.DataHora__c);
                    //system.debug('atracaoExistente.Palco__c : ' + atracaoExistente.Palco__c);
                    //system.debug('atracaoExistente.DataHora__c : ' + atracaoExistente.DataHora__c);

                    Datetime trintaMinAntesDoShow = atracaoExistente.Data_Hora__c.addMinutes(-30);
                    Datetime trintaMinAposOShow = atracaoExistente.Data_Hora_Final__c.addMinutes(30);

                    if(itemNew.Palco__c == atracaoExistente.Palco__c){
                        String atracao = atracaoExistente.Conta__r.Name.toUpperCase();
                        String dataHoraAtracao = Util.convertDatetimeToString(trintaMinAntesDoShow, 'h:mm a');
                        String dataHoraFimAtracao = Util.convertDatetimeToString(trintaMinAposOShow, 'h:mm a');

                        if(itemNew.Data_Hora__c >= trintaMinAntesDoShow && itemNew.Data_Hora__c <= trintaMinAposOShow){
                            m_mapObjFiltered.put(itemNew.Id, itemNew);
                            msgs.put(itemNew.Id, 'DataHora__c=> Estará ocorrendo a preparação + show do(a) ' + atracao + ' do período de '+dataHoraAtracao+' até '+dataHoraFimAtracao+'. Favor alterar a Data / Hora de Início desta atração.');
                            break;
                        }else if(itemNew.Data_Hora_Final__c >= trintaMinAntesDoShow && itemNew.Data_Hora_Final__c <= trintaMinAposOShow){
                            m_mapObjFiltered.put(itemNew.Id, itemNew);
                            msgs.put(itemNew.Id, 'DataHoraFim__c=> Estará ocorrendo a preparação + show do(a) ' + atracao + ' do período de '+dataHoraAtracao+' até '+dataHoraFimAtracao+'. Favor alterar a Data / Hora de Encerramento desta atração.');
                            break;
                        }
                    }
                }
            }
        } 
    }
    
    public void run(){
        if(hasRecords){
            for(Atracao__c atracao : m_mapObjFiltered.values()){
                String[] fieldMsg = msgs.get(atracao.Id).split('=>');
                String field = fieldMsg[0];
                String msg = fieldMsg[1];
                
                if(field == 'DataHora__c'){
                    atracao.Data_Hora__c.addError(msg);
                }else{ //'DataHoraFim__c'
                    atracao.Data_Hora_Final__c.addError(msg);
                }
            }
        }
    }
}