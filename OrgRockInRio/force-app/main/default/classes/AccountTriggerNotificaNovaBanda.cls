public class AccountTriggerNotificaNovaBanda {

    private List<Account> m_listDataNew;
    private Map<Id, Account> m_mapDataOld;
    private Map<Id, Account> m_mapObjFiltered = new Map<Id, Account>();
    private Boolean hasRecords;

    public AccountTriggerNotificaNovaBanda(List<Account> lstDataNew, Map<Id,Account> mapDataOld){
        this.m_listDataNew = lstDataNew;
        this.m_mapDataOld = mapDataOld;
        filter();
        this.hasRecords = !m_mapObjFiltered.isEmpty();
    }
    
    //MÉTODO ONDE EU VOU CRIAR A LÓGICA PARA FILTRAR APENAS OS REGISTROS DO GATILHO (TRIGGER)
    //OU SEJA, VALIDAR ONDE IREMOS AUTOMATIZAR
    private void filter(){
        for(Account itemNew : m_listDataNew){
            if(itemNew.RecordTypeId == Util.getAccountRecordTypeByDeveloperName('Banda')){
                m_mapObjFiltered.put(itemNew.Id, itemNew);
            }
        }
        
    }
    
    public void run(){
        if(hasRecords){
            new AccountBO().notificaNovasBandas(m_mapObjFiltered.values());
        }
        //senão tiver registros, significa que no método filter, nenhum novo registro 
        //se enquadra para receber email ou tarefa
    }    
    
}