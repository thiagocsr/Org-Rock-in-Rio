public with sharing class CalendarioAtracoesController {
    public CalendarioAtracoesController() {

    }

    @AuraEnabled
    public static List<Atracao__c> getAtracoes(){
        List<Atracao__c> atracoes = [SELECT id,Conta__c, Conta__r.Name, Data_Hora__c, Data_Hora_Final__c, Palco__c FROM Atracao__c ORDER BY Data_Hora__c];

        return atracoes;
    }

    @AuraEnabled
    public static LineUp getLineUp(String dataLineUp){       
        List<Atracao__c> atracoes = [SELECT id,Conta__c, Conta__r.Name, Data_Hora__c, Data_Hora_Final__c, Palco__c 
        FROM Atracao__c 
        WHERE DataLineUpString__c = :dataLineUp
        ORDER BY Palco__c, Data_Hora__c];

        LineUp lineup = new Lineup();
        lineup.dataLineUp = dataLineUp;
        lineup.mapAtracoes = montaMapaAtracoesPorPalco(atracoes);
        lineup.palcos = new List<String>(lineup.mapAtracoes.keySet());

        return lineup;
    }

    private static Map<String, List<Atracao>> montaMapaAtracoesPorPalco(List<Atracao__c> atracoes){
        Map<String, List<Atracao>> mapAtracoes = new Map<String, List<Atracao>>();

        for(Atracao__c atracaoObj: atracoes){
            Atracao atracao = new Atracao();
            atracao.idAtracao = atracaoObj.Id;
            atracao.nomeAtracao = atracaoObj.Conta__r.Name;
            atracao.dataHora = atracaoObj.Data_Hora__c;
            atracao.dataHoraFinal = atracaoObj.Data_Hora_Final__c;
            atracao.palco = atracaoObj.Palco__c;

            if(!mapAtracoes.containsKey(atracao.palco)){
                mapAtracoes.put(atracao.palco, new List<Atracao> {atracao});
            }else {
                mapAtracoes.get(atracao.palco).add(atracao);
            }

        }

        return mapAtracoes;
    }

    class Atracao {
        @AuraEnabled
        public String idAtracao;
        @AuraEnabled
        public String nomeAtracao;
        @AuraEnabled
        public DateTime dataHora;
        @AuraEnabled
        public DateTime dataHoraFinal;
        @AuraEnabled
        public String palco;
    }

    public class LineUP {
        @AuraEnabled
        public String dataLineUp;
        @AuraEnabled
        public List<String> palcos;
        @AuraEnabled
        public Map<String, List<Atracao>> mapAtracoes;


    }
}