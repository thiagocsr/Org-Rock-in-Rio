public class OportunidadeTriggerHandler extends TriggerHandler{

    private List<Atracao__c> newList;
    private List<Atracao__c> oldList;
    private Map<Id,Atracao__c> newMap;
    private Map<Id,Atracao__c> oldMap;
    
    public OportunidadeTriggerHandler(){
        this.newList = (List<Atracao__c>) Trigger.new;
        this.oldList = (List<Atracao__c>) Trigger.old;
        this.newMap = (Map<Id,Atracao__c>) Trigger.newMap;
        this.oldMap = (Map<Id,Atracao__c>) Trigger.oldMap; 
    }
    
    protected override void beforeInsert(){
        new AtracaoTriggerValidaPalcoHora(newList, oldMap).run();
    }
    
    protected override void afterInsert(){
        
    }
    
    protected override void beforeUpdate(){
        
    }
    
    protected override void afterUpdate(){
        
    }
    
}