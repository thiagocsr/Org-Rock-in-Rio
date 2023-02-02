public class Util {

    public static Id getAccountRecordTypeByDeveloperName(String developerName){
        id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName()
            .get(developerName).getRecordTypeId();
        return recordTypeId;
    }
    
    public static String convertDateTimeToString(Datetime dataHora, String pattern){
        return dataHora.format(pattern);
    }
    
}