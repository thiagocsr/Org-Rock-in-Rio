import { LightningElement, wire } from 'lwc';
import getLineUp from '@salesforce/apex/CalendarioAtracoesController.getLineUp';

const DATAS_ATRACOES = [
    { label: '10/09', title: '10 de Setembro de 2023', value: '2023-09-10' },
    { label: '11/09', title: '11 de Setembro de 2023', value: '2023-09-11' },
    { label: '12/09', title: '12 de Setembro de 2023', value: '2023-09-12' },
    { label: '13/09', title: '13 de Setembro de 2023', value: '2023-09-13' },
    { label: '17/09', title: '17 de Setembro de 2023', value: '2023-09-17' },
    { label: '18/09', title: '18 de Setembro de 2023', value: '2023-09-18' },
    { label: '19/09', title: '19 de Setembro de 2023', value: '2023-09-19' },
    { label: '20/09', title: '20 de Setembro de 2023', value: '2023-09-20' }
]

export default class LineUp extends LightningElement {

    dataAtracoes = DATAS_ATRACOES;
    activeValueMessage = '';
    dataLineUp = '2023-09-10 ';

    //@wire(getLineUp, { dataLineUp: '$dataLineUp' })
    infoLineUp;
    error;

    atracoes;

    handleActive(event) {
        this.infoLineUp = null;
        const dataLineUp = event.target.value;
        this.dataLineUp = dataLineUp;

        getLineUp({ dataLineUp: this.dataLineUp})
        .then((result) => {

            console.log('Retorno Lineup ' , result)
            this.infoLineUp = result;
        })
        .catch(error => {
            this.error = error;
        });
        
    }
}