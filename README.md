# MumuChatApp with Flutter and Firebase

This is a basic application and web browser project to practice and get an introduction to how to use Flutter and Firebase. It helps new developers like myself practice Flutter and Firebase development.
I am following the **Backslash Flutter** channel on YouTube for guidance (https://www.youtube.com/watch?v=Qwk5oIAkgnY&list=LL&index=70) and adapting some features to be more user-friendly, including a feature that allows users to upload a profile picture, which can be selected from the camera or gallery and removed if needed. The Firebase plan I’m using is the free plan.

## Each file have details:
1. assets folder: contains resources used in the app, such as images. In this case, it contains pictures related to the login and register screens.
2. lib folder: Contains all files and code related to the app's functionality.
	- helper folder: Stores shared data or functions that can be used across the app.
		- helper_function.dart: This file is separated to help make the code in other parts of the app more organized and easier to manage. The purpose is to handle storage data for login state, username, and email so that this information can be retrieved later without asking for it again each time. It uses SharedPreferences to manage this data efficiently and persistently, ensuring that users don't need to log in every time they open the app, as their login status and personal information are saved.
	- pages folder: keep page files.
		- auth folder: handle authentication-related functionality within the application.
			- login_page.dart: providing a user interface for logging into the app. It allows users to input their email and password and authenticate their credentials using Firebase Authentication.
			- register_page.dart: providing a user-friendly interface for registering a new user account. It handles input validation, and performs user registration with Firebase Authentication.  
		- chat_page.dart: providing a interface for real-time group chat functionality. It integrates with Firestore to fetch and display messages dynamically and includes a feature for sending new messages to the group.
		- group_info.dart: providing a detailed view of a group. It allows users to see group details, the list of group members, and leave the group if desired.
		- home_page.dart: serves as a central hub for managing and navigating user group interactions - User data handling, Group list management and Create group dialog, Search integration, Navigation features, and Logout implementation
		- profile_page.dart: handling user profile management, offering functionalities like displaying and updating the profile picture and showing basic user information. 
		- search_page.dart: allowing users to search for groups, view group details, and join groups. 
	- service folder: Contains functions for connecting to APIs or Firebase.
		- auth_service.dart: handling user authentication-related operations using Firebase Authentication. It manages login, registration, and logout processes in the app.
		- database_service.dart: managing the Firebase Firestore database and Firebase Storage operations related to the user and group data. It provides methods for saving user data, uploading profile pictures, creating groups, retrieving chat messages, and managing user memberships in groups.
	- shared folder: Stores shared data or functions used throughout the app.
		- constant.dart
	- widgets folder: Keeps custom UI components.
		- group_tile.dart: using to represent a group in the chat application. It displays a list item for each group, and when the user taps on a group, it navigates them to the corresponding chat page.
		- message_tile.dart: using to display a message in the chat interface. Each message has information about the content, sender, and whether it was sent by the current user or another user.
	- main.dart: serves as the 'entry point' for the application. It contains the main() function, which is executed when the app starts running. This file handles initialization, including both Firebase Initialization (setting up Firebase for different platforms-web, android, and iOS) and ensuring Flutter's binding system is initialized before further setup (e.g., for Firebase). Second is application setup, which defines the root of the application by running runApp() with the top-level widget (MyApp). Third is state management; it uses a stateful widget (MyApp) to manage the user's login status and navigate to the appropriate page. Fourth is user authentication; it retrieves the logged-in status to determine which screen to display initially. Fifth is configures the application's theme, primary color for widgets and background color for the scaffold. Finally, it handles page navigation by deciding the initial screen based on the user's login status.
3. build.gradle file: It's a crucial configuration file in Android Flutter projects and it comes in two primary forms: First, Project-Level (android/build.gradle), defines settings for the entire project, such as Gradle Version (: specifies the version of Gradle and the Android Gradle Plugin used to build the app.) and repositories (: defines repositories for dependencies). Second, Module-Level (android/app/build.gradle), configures settings specific to the app module,  including Application Configuration (: defines the application ID, version code, and version name), SDK Versions (: specifies the minimum and target SDK versions), dependencies (: Lists libraries or plugins e.g., Firebase, Retrofit), and build types (: configures build variants like debug and release).
4. pubspec.ymal file: It's a basic project settings file. First, it's used to manage dependencies (add libraries or packages, e.g., Firebase packages, HTTP packages, state management packages). Second, it defines assets, such as pictures, JSON files, and fonts. Third, it specifies the environment—the SDK versions of Flutter and Dart that are supported. Finally, it defines metadata, which includes general information about the project, such as its name, description, and version.

## resources for helping my first project:
A few resources to get me started with my first Flutter project:
- Firebase Realtime Database: Many-to-Many Relationship Schema (https://alfianlosari.medium.com/firebase-realtime-database-many-to-many-relationship-schema-4155d9647f0f)
- Firebase Realtime Database Setup Guide (https://medium.com/firebasethailand/%E0%B8%A3%E0%B8%B9%E0%B9%89%E0%B8%88%E0%B8%B1%E0%B8%81-firebase-realtime-database-%E0%B8%95%E0%B8%B1%E0%B9%89%E0%B8%87%E0%B9%81%E0%B8%95%E0%B9%88-zero-%E0%B8%88%E0%B8%99%E0%B9%80%E0%B8%9B%E0%B9%87%E0%B8%99-hero-5d09210e6fd6)
- Firebase Documentation (https://firebase.google.com/docs/)
- GeeksforGeeks (https://www.geeksforgeeks.org/)
