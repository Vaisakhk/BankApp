# BankApp

### Architecture
     - VIPER

### Requirements
     - iOS 13.0 and above
     - Xcode Version 12.2
     
### Assemptions
     - Assuming any user can Login
     - Assuming User(Client) name is unique
     - Assuming Payee name  is unique
     - Amount is limited to 15 characters
     - Assuming Balance can be negative
     
### Approach
     - Using Core Data for the local storage
     - Created 2 entities one for User and one for Transaction process.
     
### Features
    - Login Screen
       - Allowed user to enter Any name and login
    - Home screen
       - Logged in user balance displayed and updated according to transaction.
       - Allowed user to enter the Amount and topup, Balance will immediately reflect in UI
       - Allowed users to enter Any payee name and enter the amount and allowed to pay now. Balance will immediately reflect in UI
       - Given Logout and History option
       - In History page user can see all the transactions
       
    - History screen
       - In history screen all the transactions as displayed
       
### Depedency
    - TPKeyboardAvoidingSwift to dissmiss the keyboard while clicking out side of the textfield, and auto scroll the view when user edit.

### Unit Testing
    - Created Unit test for business logic (Home and History interactor)
