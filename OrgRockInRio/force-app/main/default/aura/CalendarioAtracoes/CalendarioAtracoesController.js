({
    init : function(component, event, helper) {
        component.set('v.columns', [
            {label: 'Nome da Atração', fieldName: 'nomeAtracao', type: 'text',sortable: true},
            {label: 'Palco', fieldName: 'Palco__c', type: 'text', sortable: true},
            {label: 'Data/Hora Inicio', fieldName: 'Data_Hora__c', sortable: true, type: 'date', 
            typeAttributes: {
              day: 'numeric',
              month: 'short',
              year: 'numeric',
              hour: '2-digit',
              minute: '2-digit',
              second: '2-digit',
              hour12: true
            }},
            {label: 'Data/Hora Final', fieldName: 'Data_Hora_Final__c', sortable: true, type: 'date', 
            typeAttributes: {
              day: 'numeric',
              month: 'short',
              year: 'numeric',
              hour: '2-digit',
              minute: '2-digit',
              second: '2-digit',
              hour12: true
            }}
            
        ]);


        helper.buscarAtracoes(component);
    },

    handleSort: function(cmp, event, helper) {
        helper.handleSort(cmp, event);
    }
}) 