import {LightningElement, track, wire} from 'lwc';

import ID_FIELD from '@salesforce/schema/JobApplication__c.Name';
import EXPECTED_SALARY_FIELD from '@salesforce/schema/JobApplication__c.Expected_Salary__c';
import HPS_PHONE_FIELD from '@salesforce/schema/JobApplication__c.HR_phone_number__c';

import getApplicationList from '@salesforce/apex/ApplicationController.getApplicationList';
import deleteApplications from '@salesforce/apex/ApplicationController.deleteApplications';

import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {refreshApex} from '@salesforce/apex';

const COLUMNS = [
    {label: 'Application', fieldName: ID_FIELD.fieldApiName, type: 'num', hideDefaultActions: true},
    {label: 'Expected salary', fieldName: EXPECTED_SALARY_FIELD.fieldApiName, type: 'num', hideDefaultActions: true},
    {label: 'HR`s phone', fieldName: HPS_PHONE_FIELD.fieldApiName, type: 'text', hideDefaultActions: true}
];


export default class ApplicationList extends LightningElement {
    columns = COLUMNS;
    @track allApplications;
    @track isExpanded = false;
    @track buttonLabel = 'Delete';
    @track isLoaded = false;
    @track isTrue = false;
    @track recordsCount = 0;


    selectedRecords = [];
    refreshTable;
    error;

    @wire(getApplicationList)
    loadPositions({error, data}) {
        this.refreshTable = data;
        this.allApplications = data;
    }
    

    renderedCallback() {
        this.isLoaded = true;
    }

    handleClickExtend() {
        this.isExpanded = !this.isExpanded;
    }



    getSelectedRecords(event) {
        const selectedRows = event.detail.selectedRows;
        this.recordsCount = event.detail.selectedRows.length;

        let conIds = new Set();

        for (let i = 0; i < selectedRows.length; i++) {
            conIds.add(selectedRows[i].Id);
        }

        this.selectedRecords = Array.from(conIds);
        window.console.log('selectedRecords ====> ' +this.selectedRecords);
    }


    deleteJobApplications() {
        if (this.selectedRecords) {
            this.buttonLabel = 'Processing....';
            this.isTrue = true;
            this.deleteApplic();
        }
    }


    deleteApplic() {
        deleteApplications({lstApplicationIds: this.selectedRecords})
        .then(data => {
            window.console.log('data ====> ' + data);

            this.buttonLabel = 'Delete';
            this.isTrue = false;

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success!!', 
                    message: this.recordsCount + ' Applications are deleted.', 
                    variant: 'success'
                }),
            );
            
            this.template.querySelector('lightning-datatable').selectedRows = [];
            this.recordsCount = 0;

            /*
            getApplicationList().then(result=>{
                console.log('Refresh here');
                console.log(result);
                this.allApplications=result;
                this.refreshTable = result;
                
            });*/
            return refreshApex(this.refreshTable);
        })
        .catch(error => {
            window.console.log(error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error while getting Applications', 
                    message: error.message, 
                    variant: 'error'
                }),
            );
        });
    }  
}