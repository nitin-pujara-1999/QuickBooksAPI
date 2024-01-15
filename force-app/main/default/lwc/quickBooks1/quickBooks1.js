import { LightningElement, wire,api } from 'lwc';
import getPaymentAccounts from '@salesforce/apex/QuickBooksAPI.getPaymentAccounts';
import getPaymentAccounts2 from '@salesforce/apex/QuickBooksAPI.getPaymentAccounts2';
import getExpenseCategory from '@salesforce/apex/QuickBooksAPI.getExpenseCategory';
import createExpense from '@salesforce/apex/QuickBooksAPI.createExpense';
import getVendors from '@salesforce/apex/QuickBooksAPI.getVendors';

export default class QuickBooks1 extends LightningElement {

quickBooksBankAccount;
quickBookCardAccounts;
selectedAccountId;
accountTypeOptions;
selectedAccountBalance;
expenseCategoryData;
expenseCategoryOptions;
accountNameIdMap;
accountNameTypeMap;

//child component rows
category = 'CATEGORY';

categoryDescription = 'DESCRIPTION';
categoryAmount = 'AMOUNT';
categoryBillable = 'BILLABLE';
itemProduct = 'PRODUCT/SERVICE';
itemDescription = 'DESCRIPTION';
itemQuantity = 'QTY';
itemRate = 'RATE';

    @wire(getPaymentAccounts)
    getPaymentAccount({data, error}){
        if(data){
            this.quickBooksBankAccount = data;
            console.log('quickBooksBankAccount' , this.quickBooksBankAccount);
            this.getAccountOptions();
        } 
        else if(error){
            console.log('Error' , error);

        }
    }

    @wire(getPaymentAccounts2)
    getPaymentAccount2({data, error}){
        if(data){
            this.quickBookCardAccounts = data;
            console.log('quickBookCardAccounts' , this.quickBookCardAccounts);
            this.getAccountOptions();

        } 
        else if(error){
            console.log('Error' , error);

        }
    }
    accountBalancesMap = new Map();

    getAccountOptions() {
        if (this.quickBooksBankAccount && this.quickBookCardAccounts != null) {
            console.log('In Get Accounts Function');
            try {
                const bankAccounts = JSON.parse(this.quickBooksBankAccount).QueryResponse.Account;
                const cardAccounts = JSON.parse(this.quickBookCardAccounts).QueryResponse.Account;
                const accounts = [...bankAccounts, ...cardAccounts];
                const accountNames = accounts.map(account => account.Name);
                console.log('accountNames' , JSON.stringify(accountNames));

                const accountId = accounts.map(id => id.Id);
                console.log('accountId' , JSON.stringify(accountId));

                this.accountTypeOptions = accountNames.map(name => ({ label: name, value: name }));
                const accountBalance = accounts.map(account => account.CurrentBalance);

                this.accountNameIdMap = new Map(accounts.map(account => [account.Name , account.Id]));
                console.log('accountNameIdMap' , this.accountNameIdMap);

                const accountBalances = new Map(accounts.map(account => [account.Name, account.CurrentBalance]));
                console.log('accountBalances' , accountBalances);
                this.accountBalancesMap = accountBalances;

                this.accountNameTypeMap = new Map(accounts.map(account => [account.Name , account.AccountType]));
                console.log('accountNameTypeMap' , this.accountNameTypeMap);


                console.log('accountBalancesMap' , this.accountBalancesMap);

                console.log('account balance' , JSON.stringify(accountBalance));
                console.log('TYPE' , typeof this.accountTypeOptions);
                console.log('accountTypeOptions' , this.accountTypeOptions);
            } catch (error) {
                console.error(JSON.stringify(error));
            }
        }
    }
    expenseCategoryNameIdMap;

    @wire(getExpenseCategory)
    expenseCategories({data , error}){
        if(data){
            console.log('Expense Category' , data);
            this.expenseCategoryData = data;

            const expenseCategories = JSON.parse(this.expenseCategoryData).QueryResponse.Account;
            const expenseCategoryNames = expenseCategories.map(expenseCategories => expenseCategories.Name);
            const expenseCategoryIds = expenseCategories.map(expenseCategories => expenseCategories.Id);
            this.expenseCategoryNameIdMap = new Map(expenseCategories.map(expenseCategories => [expenseCategories.Name , expenseCategories.Id]));
            console.log('expenseCategoryNameIdMap' , this.expenseCategoryNameIdMap);
            console.log('expenseCategoryIds' , expenseCategoryIds);
            console.log('expenseCategoryNames' , expenseCategoryNames);
            this.expenseCategoryOptions = expenseCategoryNames.map(category => ({ label: category, value: category }));
        }
        else if(error){
            console.log(error);
        }
    }
    vendornamesoptions;
    vendorNameIdMap;
    @wire(getVendors)
    getExpenseVendors({data , error}){
        if(data){
            console.log('Vendor Data' , data);
            const vendorNames = JSON.parse(data).QueryResponse.Vendor;
            console.log('vendorNames' , vendorNames);
            const vendorNameList = vendorNames.map(vendornames => vendornames.DisplayName);
            console.log('vendorNameList' , vendorNameList);
            const vendorId = vendorNames.map(vendorids => vendorids.Id);
            console.log('vendorId' , vendorId);
            this.vendornamesoptions = vendorNameList.map(vendornames => ({ label: vendornames , value: vendornames}));
            this.vendorNameIdMap = new Map(vendorNames.map(vendorNameIds => [vendorNameIds.DisplayName , vendorNameIds.Id]));
            console.log('vendorNameIdMap' , this.vendorNameIdMap);
        }
        else if(error){
            console.log('Vendor Error' , error);
        }
    }
    
    handleAccountChange(event) {
        this.selectedAccountId = event.detail.value;
        console.log('selectedAccountId'  ,this.selectedAccountId);
        this.selectedAccountBalance = this.accountBalancesMap.get(this.selectedAccountId);
        this.selectedAccountBalance = this.selectedAccountBalance.toLocaleString('us-US', { style: 'currency', currency: 'USD' })
        console.log('selectedAccountBalance' , this.selectedAccountBalance.toLocaleString('us-US', { style: 'currency', currency: 'USD' }));

    }

    requestBodyString;
    createExpenseBody(){
        const paymentTypeMap = {
            'Visa': 'CreditCard',
            'Mastercard': 'creditcard',
            'Checking': 'Cash',
            'Savings': 'Cash'
        };
    
        const accountName = this.selectedAccountId;
        const accountId = this.accountNameIdMap.get(accountName);
        const expenseAmount = this.selectedCategoryAmount;
    
        const paymentType = paymentTypeMap[accountName];
    
        const requestBody = {
            PaymentType: paymentType,
            AccountRef: {
                name: accountName,
                value: accountId
            },
            EntityRef: {
                value: this.vendorNameIdMap.get(this.selectedVendor),
                name: this.selectedVendor,
                type: 'Vendor'
            },
            Line: [
                {
                    DetailType: 'AccountBasedExpenseLineDetail',
                    Amount: expenseAmount,
                    AccountBasedExpenseLineDetail: {
                        AccountRef: {
                            name: this.selectedCategory,
                            value: this.expenseCategoryNameIdMap.get(this.selectedCategory)
                        }
                    }
                }
            ]
        };
        this.requestBodyString = JSON.stringify(requestBody);
        console.log('requestBodyString', this.requestBodyString);
    }
    
//     handleCreateExpense() {
//         console.log('Save Button Clicked');
//         // Construct the request body
//         this.createExpenseBody();
//         console.log(this.createExpenseBody);
    
//         // Get the attachment file content, name, and type
//         let fileInput = this.template.querySelector('input[type="file"]');
//         console.log('fileInput', fileInput);
//         if (fileInput && fileInput.files.length > 0) {
//                 let file = fileInput.files[0];
//                 console.log('file', file);
//             if(file){
//                 console.log('file Name', file.name);
//                 console.log('file type', file.type);
//             }
//             else{
//                 console.log('No file selected');
//             }
//         let reader = new FileReader();
//         reader.onload = () => {
//             let fileContent = reader.result.split(',')[1];
//             console.log('fileContent', fileContent);
    
//             // Call the createExpense Apex method
//             createExpense({ reqBody: this.requestBodyString, attachmentBody: fileContent, attachmentName: file.name, attachmentType: file.type })
//                 .then(result => {
//                     // Handle successful expense creation
//                     console.log('Expense created successfully', result);
//                 })
//                 .catch(error => {
//                     // Handle any errors
//                     console.error('Error in creating expense', error);
//                 })
//                 .finally(()=>{
//                     console.log('Expense Created');
//                 });
//         };
//         reader.readAsDataURL(file);
//     }
// else {
//     console.error('No file selected');
// }
//     }
    

handleCreateExpense() {
        console.log('Save Button Clicked');
        // Construct the request body
        this.createExpenseBody();
        console.log(this.createExpenseBody);

    // Get the attachment file content, name, and type
    let fileInput = this.template.querySelector('input[type="file"]');
    let files = fileInput.files;
    if (files.length > 0) {
        let filePromises = [];
        for (let i = 0; i < files.length; i++) {
            filePromises.push(this.readFile(files[i]));
        }
        Promise.all(filePromises).then(fileContents => {
            // Call the createExpense Apex method
            createExpense({ reqBody: this.requestBodyString, files: fileContents })
                .then(result => {
                    // Handle successful expense creation
                    console.log('Expense created successfully', result);
                })
                .catch(error => {
                    // Handle any errors
                    console.error('Error in creating expense', error);
                });
        });
    } else {
        console.error('No file selected');
    }
}

readFile(file) {
    return new Promise((resolve, reject) => {
        let reader = new FileReader();
        reader.onload = () => {
            let fileContent = reader.result.split(',')[1];
            resolve({
                body: fileContent,
                name: file.name,
                type: file.type
            });
        };
        reader.readAsDataURL(file);
    });
}

    // openfileUpload(event) {
    //     const file = event.target.files[0]
    //     console.log('file', file);
    //     var reader = new FileReader()
    //     reader.onload = () => {
    //         var base64 = reader.result.split(',')[1]
    //         this.fileData = {
    //             'filename': file.name,
    //             'base64': base64,
    //             'recordId': this.recordId
    //         }
    //         console.log(this.fileData)
    //     }
    //     reader.readAsDataURL(file)
    // }

    // handleClick(){
    //     console.log('Save Button Clicked');
    //     const {base64, filename, recordId} = this.fileData
    //     uploadFile({ base64, filename, recordId }).then(result=>{
    //         this.fileData = null
    //         let title = `${filename} uploaded successfully!!`
    //         this.toast(title)
    //     })
    // }
   

    // toast(title){
    //     const toastEvent = new ShowToastEvent({
    //         title, 
    //         variant:"success"
    //     })
    //     this.dispatchEvent(toastEvent)
    // }


    childData;
    selectedCategory;
    selectedCategoryAmount;
    handleChildDataChange(event) {
        const data = event.detail;
        console.log('Data from child:', data);
    
        this.selectedCategory = data.category;
        this.selectedCategoryAmount = data.categoryAmount;
    
        console.log('Selected category:', this.selectedCategory);
        console.log('Selected category amount:', this.selectedCategoryAmount);
    }

    selectedVendor;
    handleVendorChange(event){
        this.selectedVendor = event.detail.value;
        console.log('selectedVendor' , this.selectedVendor );


    }
}