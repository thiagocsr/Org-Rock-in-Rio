import { LightningElement, wire } from 'lwc';
import getLineUp from '@salesforce/apex/CalendarioAtracoesController.getLineUp';

export default class LineUp extends LightningElement {

    activeValueMessage = '';
    dataLineUp = '2023-09-10 ';

    //@wire(getLineUp, { dataLineUp: '$dataLineUp' })
    infoLineUp;
    error;

    atracoes;

    handleActive(event) {
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