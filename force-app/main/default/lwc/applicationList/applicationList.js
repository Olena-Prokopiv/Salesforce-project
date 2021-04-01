import {LightningElement, track, wire} from 'lwc';

import getApplicationList from '@salesforce/apex/ApplicationController.getApplicationList';
import deleteApplications from '@salesforce/apex/ApplicationController.deleteApplications';

import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

import ID_FIELD from '@salesforce/schema/JobApplication__c.Name';
import EXPECTED_SALARY_FIELD from '@salesforce/schema/JobApplication__c.Expected_Salary__c';
import HPS_PHONE_FIELD from '@salesforce/schema/JobApplication__c.HR_phone_number__c';

const COLUMNS = [
    {label: 'Application', fieldName: ID_FIELD.fieldApiName, type: 'num'},
    {label: 'Expected salary', fieldName: EXPECTED_SALARY_FIELD.fieldApiName, type: 'num',editable: true},
    {label: 'HR`s phone', fieldName: HPS_PHONE_FIELD.fieldApiName, type: 'text'}
];


export default class ApplicationList extends LightningElement {
    columns = COLUMNS; 
    
    
  @track allApplications = []; 
    @track data;
    @track isExpanded = false;
    @track buttonLabel = 'Delete';
    @track isLoaded = false;
    @track isTrue = false;
    @track recordsCount = 0;
    @track applicationList = [];


    selectedRecords = [];
    saveDraftValues = []; 
    error;

    @wire(getApplicationList)  loadPositions(result) {
        this.allApplications = result;

        if (result.data) {
            this.applicationList = result.data;
            this.error = undefined;
          } else if (result.error) {
            this.error = result.error;
            this.applicationList = [];
          }
    }
    
    renderedCallback() {
        this.isLoaded = true;
    }

    handleClickExtend() {
        this.isExpanded = !this.isExpanded;
    }
  


    handleSave(event) {
        this.saveDraftValues = event.detail.draftValues;
        const recordInputs = this.saveDraftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });

        const promises = recordInputs.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(res => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Application(s) Updated Successfully!!',
                    variant: 'success'
                })
            );
            this.saveDraftValues = [];
            return refreshApex(this.allApplications);
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'An Error Occured!!',
                    variant: 'error'
                })
            );
        }).finally(() => {
            this.saveDraftValues = [];
        });
    }



    getSelectedRecords(event) {
        const selectedRows = event.detail.selectedRows;
        this.recordsCount = event.detail.selectedRows.length;

        let conIds = new Set();

        for (let i = 0; i < selectedRows.length; i++) {
            conIds.add(selectedRows[i].Id);
        }

        this.selectedRecords = Array.from(conIds);
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
        .then(result  => {

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

            return refreshApex(this.allApplications);
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