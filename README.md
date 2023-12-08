# Banking Application (DEVBANK)

## Overview
This Flutter application is a simple banking platform that allows users to perform various financial transactions seamlessly. The application employs the MVC architectural pattern for enhanced scalability and organized codebase management.

## Features

1. **User Authentication:**
    - Users can sign up and log in using their phone numbers as account credentials.

2. **Transaction Management and Authentication:**
    - The deposit and money transfer functionalities are seamlessly integrated for user convenience. Authentication is accomplished using the token provided to each user upon login, stored on the device for authorization until logout, and automatically cleared.

3. **Transaction History:**
    - Users can visualize their financial activity through a graphical deposit and withdrawal history representation.

4. **Transaction Listing:**
    - A list of transactions is available for users to review and track their financial interactions.

## Codebase Structure
The codebase is organized using the MVC structure, ensuring a clear separation of concerns and ease of scalability. Subfolders within the structure correspond to different aspects of the application.

## Libraries Used

In addition to the default libraries, the following external libraries are utilized in the project:
- Getx
- Shared Preferences
- HTTP
- Fl Chart

## Usage Instructions

1. **Authentication Process:**
    - All users must undergo the authentication process.
    - New users need to register first, providing the necessary details.
    - After registration, proceed to the login screen.
    - Enter the credentials used in registration.

2. **Home Screen:**
    - After successful login, users are directed to the home screen.
    - The home screen displays the user's account number and current balance.
    - The situation where the user has made a transaction and it's not reflecting immediately on this screen just click on the widget-like button showing your account nummber and balance to refresh the balance and will be updated automatically.
    - Navigate to other screens seamlessly using the intuitive interface.

3. **Account Screens:**
    - Depending on the current state of the account, data is displayed on respective transaction screens.
    - Users can deposit, transfer money, view transaction history, and see visualized data on their transactions.

4. **Logout Functionality:**
    - A logout button is located on the top right corner of the home screen.
    - Click the logout button to exit the app and return to the login screen.

## APP Links
* Website preview(Appetize.io) of Apk: <a href="https://appetize.io/app/ngeqvli7mpfrgevtyaomjtjaqe">DEVBANK</a>
* Android: [DEVBANK.zip](https://github.com/Esetobore/Banking-Application/files/13611456/DEVBANK.zip)


### How to Run the App

#### From the APK ZIP

1. Download the ZIP file from the provided link.
2. Extract the app from the ZIP file using a suitable extraction tool.
3. Install and run the app on your device.

#### From the Appetize Link

**Note:** The Appetize link is for webview only and does not install on the device. It serves as a means to interact with the app without installation.

1. Click the provided link to access the webview.
2. Once redirected, choose a preferred phone size and click 'Play' to interact with the app.


## Developer: Esetobore Akpokiniovo
