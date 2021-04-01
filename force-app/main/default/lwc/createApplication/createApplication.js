import { LightningElement, track } from 'lwc';

import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createApplication from '@salesforce/apex/ApplicationController.createApplication';

import APPLICATION_OBJECT from '@salesforce/schema/JobApplication__c';
import SALARY_FIELD from '@salesforce/schema/JobApplication__c.Expected_Salary__c';
import POSITION_FIELD from '@salesforce/schema/JobApplication__c.JobPosition__r.Name';
import CANDIDATE_FIELD from '@salesforce/schema/JobApplication__c.Candidate__r.Name';

export default class CreateApplication extends LightningElement {
    @track salary = SALARY_FIELD;
    @track position = POSITION_FIELD;
    @track candidate = CANDIDATE_FIELD;
    rec = {
        Salary : this.salary,
        Position : this.position,
        Candidate : this.candidate
    }
    
    
    handleNameChange(event) {
        this.rec.Salary = event.target.value;
        console.log("Salary", this.rec.Salary);
    }
    
    handleIndChange(event) {
        this.rec.Position = event.target.value;
        console.log("Position", this.rec.Position);
    }
    
    handlePhnChange(event) {
        this.rec.Candidate = event.target.value;
        console.log("Candidate", this.rec.Candidate);
    }

    handleClick() {
        createApplication({ acc : this.rec })
            .then(result => {
                this.message = result;
                this.error = undefined;
                if(this.message !== undefined) {
                    this.rec.Salary = 0;
                    this.rec.Position = '';
                    this.rec.Candidate = '';
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Application created',
                            variant: 'success',
                        }),
                    );
                }
                console.log(JSON.stringify(result));
                console.log("result", this.message);
            })
            .catch(error => {
                this.message = undefined;
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
                console.log("error", JSON.stringify(this.error));
            });
    }
}