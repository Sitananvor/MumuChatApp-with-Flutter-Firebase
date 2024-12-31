# MumuChatApp with Flutter and Firebase

This is a basic application and web browser project to practice and get an introduction to how to use Flutter and Firebase. It helps new developers like myself practice Flutter and Firebase development.
I am following the **Backslash Flutter** channel on YouTube for guidance (https://www.youtube.com/watch?v=Qwk5oIAkgnY&list=LL&index=70) and adapting some features to be more user-friendly, including a feature that allows users to upload a profile picture, which can be selected from the camera or gallery and removed if needed. The Firebase plan I’m using is the free plan.

## Each file have details:
1. assets floder: contains resources used in the app, such as images. In this case, it contains pictures related to the login and register screens.
2. lib folder: 
	- helper folder: 
		- helper_function.dart: 
	- pages folder: 
		- auth folder: 
			- login_page.dart: 
			- register_page.dart: 
		- chat_page.dart: 
		- group_info.dart: 
		- home_page.dart: 
		- profile_page.dart: 
		- search_page.dart: 
	- service folder: 
		- auth_service.dart: 
		- database_service.dart: 
	- shared folder: 
		- constant.dart: 
	- widgets folder: 
		- group_tile.dart: 
		- message_tile.dart: 
	- main.dart: 
3. build.gradle file: It's a crucial configuration file in Android Flutter projects and it comes in two primary forms: First, Project-Level (android/build.gradle), defines settings for the entire project, such as Gradle Version (: specifies the version of Gradle and the Android Gradle Plugin used to build the app.) and repositories (: defines repositories for dependencies). Second, Module-Level (android/app/build.gradle), configures settings specific to the app module,  including Application Configuration (: defines the application ID, version code, and version name), SDK Versions (: specifies the minimum and target SDK versions), dependencies (: Lists libraries or plugins e.g., Firebase, Retrofit), and build types (: configures build variants like debug and release).
4. pubspec.ymal file: It's a basic project settings file. First, it's used to manage dependencies (add libraries or packages, e.g., Firebase packages, HTTP packages, state management packages). Second, it defines assets, such as pictures, JSON files, and fonts. Third, it specifies the environment—the SDK versions of Flutter and Dart that are supported. Finally, it defines metadata, which includes general information about the project, such as its name, description, and version.

## resources for helping my first project:
A few resources to get me started with my first Flutter project:
- Firebase Realtime Database: Many-to-Many Relationship Schema (https://alfianlosari.medium.com/firebase-realtime-database-many-to-many-relationship-schema-4155d9647f0f)
- Firebase Realtime Database Setup Guide (https://medium.com/firebasethailand/%E0%B8%A3%E0%B8%B9%E0%B9%89%E0%B8%88%E0%B8%B1%E0%B8%81-firebase-realtime-database-%E0%B8%95%E0%B8%B1%E0%B9%89%E0%B8%87%E0%B9%81%E0%B8%95%E0%B9%88-zero-%E0%B8%88%E0%B8%99%E0%B9%80%E0%B8%9B%E0%B9%87%E0%B8%99-hero-5d09210e6fd6)
- Firebase Documentation (https://firebase.google.com/docs/)
- GeeksforGeeks (https://www.geeksforgeeks.org/)
