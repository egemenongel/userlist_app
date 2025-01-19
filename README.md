
# User List App

An iOS application built using Swift, UIKit, and the MVVM (Model-View-ViewModel) architecture. The app displays a list of users and their detailed information while maintaining modular and scalable code.

## Features

-   **User List**: Fetch and display a list of users with their names and emails.
    
-   **User Detail View**: Show detailed information for a selected user, including name, email, phone, and website.
    
-   **Clean Architecture**: Implemented using the **MVVM** pattern for separation of concerns and testability.
    
-   **Networking Layer**: Modular and reusable networking layer for API requests.
    
-   **Dynamic UI**: Uses `UIStackView` for flexible layouts and supports dynamic font sizes for accessibility.
    

## Project Structure

The project follows a modular structure to separate concerns:

1.  **Models**:
    
    -   `User`: Represents the user data model.
        
2.  **ViewModels**:
    
    -   `UserListViewModel`: Handles logic for fetching and managing the list of users.
        
    -   `UserDetailViewModel`: Manages fetching and displaying details for a specific user.
        
3.  **Views**:
    
    -   `UserListViewController`: Displays the list of users in a `UITableView`.
        
    -   `UserDetailViewController`: Displays detailed information about a selected user.
        
4.  **Services**:
    
    -   `UserDetailService`: Fetches user data from the network.
        
5.  **Repositories**:
    
    -   `UserDetailRepository`: Handles API calls and data decoding.
            
## Setup Instructions

1.  Clone the repository:
    
    ```
    git clone https://github.com/yourusername/user-details-app.git
    ```
    
2.  Open the project in Xcode:
    
    ```
    cd user-details-app
    open UserDetailsApp.xcodeproj
    ```
    
3.  Build and run the project:
    
    -   Select a simulator or a connected device in Xcode.
        
    -   Press `Cmd+R` to build and run the app.
        

## API Information

This app fetches data from a REST API endpoint that returns user details:

-   **Endpoints**:
    
    -   `GET /users`: Fetches a list of users.
        
    -   `GET /users/{id}`: Fetches details of a specific user.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
