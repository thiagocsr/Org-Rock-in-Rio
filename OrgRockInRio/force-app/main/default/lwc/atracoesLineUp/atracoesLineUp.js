import { LightningElement, api } from 'lwc';

const actions = [
    { label: 'Exibir Atração', name: 'show_details'}
]

const columns = [
    {label: 'Nome da Atração', fieldName: 'nomeAtracao', type: 'text'},
    {label: 'Data/Hora Inicio', fieldName: 'dataHora', type: 'date', 
            typeAttributes: {
              day: 'numeric',
              month: 'short',
              year: 'numeric',
              hour: '2-digit',
              minute: '2-digit',
              second: '2-digit',
              hour12: true
            }},
    {label: 'Data/Hora Final', fieldName: 'dataHoraFinal', type: 'date', 
            typeAttributes: {
              day: 'numeric',
              month: 'short',
              year: 'numeric',
              hour: '2-digit',
              minute: '2-digit',
              second: '2-digit',
              hour12: true
            }},
    {
        type: 'action',
        typeAttributes: { rowActions: actions }
    }
];

export default class AtracoesLineUp extends LightningElement {

    columns = columns;

    @api infoLineUp;

    atracoes;

    handleToggleSection(event){
        const palcoSelectionado = event.detail.openSections;
        this.atracoes = this.infoLineUp.mapAtracoes[palcoSelectionado];
        console.log('Atrações do Palco Selecionado ', this.atracoes);
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch(actionName) {
            case 'show_details':
                window.open('/' + row.idAtracao, '_blank');
                break;
            default:
        }
    }

}