public class AccountTriggerHandler extends TriggerHandler{

    private List<Account> newList;
    private List<Account> oldList;
    private Map<Id,Account> newMap;
    private Map<Id,Account> oldMap;
    
    public AccountTriggerHandler(){
        this.newList = (List<Account>) Trigger.new;
        this.oldList = (List<Account>) Trigger.old;
        this.newMap = (Map<Id,Account>) Trigger.newMap;
        this.oldMap = (Map<Id,Account>) Trigger.oldMap; 
    }
    
    protected override void beforeInsert(){
        
    }
    
    protected override void afterInsert(){
        new AccountTriggerNotificaNovaBanda(newList, oldMap).run();
    }
    
    protected override void beforeUpdate(){
        
    }
    
    protected override void afterUpdate(){
        
    }

}