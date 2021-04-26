import {LightningElement, track, wire, api} from 'lwc';
import NAME_FIELD from '@salesforce/schema/JobPosition__c.Name';
import OPEN_DUE_DATE_FIELD from '@salesforce/schema/JobPosition__c.Open_Due_Date__c';
import PRACTICE_UNIT_FIELD from '@salesforce/schema/JobPosition__c.Practice_Unit__c';
import PRIORITY_FIELD from '@salesforce/schema/JobPosition__c.Priority__c';
import getPositionList from '@salesforce/apex/PositionController.getPositionList';

const COLUMNS = [
    {label: 'Title', fieldName: NAME_FIELD.fieldApiName, type: 'text', hideDefaultActions: true},
    {label: 'Open Due Date', fieldName: OPEN_DUE_DATE_FIELD.fieldApiName, type: 'date', hideDefaultActions: true},
    {label: 'Practice Unit', fieldName: PRACTICE_UNIT_FIELD.fieldApiName, type: 'text', hideDefaultActions: true},
    {label: 'Priority', fieldName: PRIORITY_FIELD.fieldApiName, type: 'text', hideDefaultActions: true}
];

const DOT_NET = '.Net';
const JAVA = 'Java';
const SALESFORCE = 'Salesforce';
const PYTHON = 'Python';
const PHP = 'PHP';
const ALL_PRACTICE_UNIT = 'All';

const filterOptions = [
    {value: DOT_NET, label: DOT_NET},
    {value: JAVA, label: JAVA},
    {value: SALESFORCE, label: SALESFORCE},
    {value: PYTHON, label: PYTHON},
    {value: PHP, label: PHP},
    {value: ALL_PRACTICE_UNIT, label: ALL_PRACTICE_UNIT},
];


export default class PositionListFiltered extends LightningElement {
    @api position;
    
    columns = COLUMNS;
    allPositions;
    @track currentFilter = ALL_PRACTICE_UNIT;
    @track isExpanded = false;
    @track itemsForCurrentView;
    @track isLoaded = false;
    filterOptions = filterOptions;

    @wire(getPositionList)
    loadPositions({error, data}) {
        this.allPositions = data;
        this.itemsForCurrentView = data;
    }

    renderedCallback() {
        this.isLoaded = true;
    }

    selectHandler(event) {
        event.preventDefault();
        const selectedEvent = new CustomEvent('selected', { detail: this.position.Id });
        this.dispatchEvent(selectedEvent);
    }

    get dropdownTriggerClass() {
        if (this.isExpanded) {
            return 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click custom_list_view slds-is-open'
        } else {
            return 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click custom_list_view'
        }
    }

    handleFilterChangeButton(event) {
        this.isLoaded = false;
        let filter = event.target.dataset.filter;
        this.isExpanded = !this.isExpanded;
        if (filter !== this.currentFilter) {
            this.currentFilter = event.target.dataset.filter;
            setTimeout(() => {
                this.handleFilterData(this.currentFilter), 0
            });
        } else {
            this.isLoaded = true;
        }
    }

    handleFilterData(filter) {
        if (filter === ALL_PRACTICE_UNIT) {
            this.itemsForCurrentView = this.allPositions
        } else {
            this.itemsForCurrentView = this.allPositions.filter(item => {
                return item.Practice_Unit__c === filter;
            })
        }
        this.isLoaded = true;
    }

    handleClickExtend() {
        this.isExpanded = !this.isExpanded;
    }
}