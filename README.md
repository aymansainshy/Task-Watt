

## Introduction
The Trip Tracker app is a Flutter application designed to track trips from one location to another. It provides a user-friendly interface for setting start and end locations, displays the route on Google Maps, and generates a trip summary with essential details. The application follows best practices and Flutter conventions for clean, readable, and maintainable code.


## App Structure
The app is structured using the MVC (Model-View-Controller) architecture pattern to separate concerns and improve maintainability. The project directory is organized as follows
```dart
task_watt/
|-- lib/
|    |-- config/
|    |-- core/
|    |-- features/
|    |    |-- auth/
|    |    |    |-- controllers/
|    |    |    |-- models/
|    |    |    |-- repositories/
|    |    |    |-- views/
|    |    |    |-- widgets/
|    |    |-- map/
|    |    |    |-- controllers/
|    |    |    |-- models/
|    |    |    |-- repositories/
|    |    |    |-- views/
|    |    |    |-- widgets/
|    |-- utils/
|    |-- di.dart
|    |-- main.dart
|-- pubspec.yaml
|-- ...
```

- **`config/`**: Contains essential configuration details such as `domainName`, `user` information, and `app` version.
- **`core/`**: Centralized folder for shared classes, functions, constants, and widgets utilized throughout the application.
- **`di.dart/`**: Configuration file and dependency injection with GetX.
- **`features/`**: Embracing a modular architecture, each module is treated as an independent feature.
    - **`auth/`**:
        - **`controllers/`**: Manages application logic and UI state for authentication.
        - **`models/`**: Defines data models for entities within the authentication feature.
        - **`repositories/`**: Houses data-related functionality for authentication.
        - **`views/`**: Consists of UI widgets and screens associated with authentication.
        - **`widgets/`**: Houses small components specific to the authentication feature.
    - **`map/`**:
        - **`controllers/`**: Manages logic and UI state for the map feature.
        - **`models/`**: Contains data models specific to the map feature.
        - **`repositories/`**: Handles data-related functionality for the map feature.
        - **`views/`**: Includes UI widgets and screens associated with the map feature.
- **`utils/`**: General utility functions and helper classes used universally across the application.


## State Management

The application leverages GetX for state management, utilizing its observable, reactive, and dependency injection features to efficiently manage and update the application state.

## Google Maps Integration

Seamless integration of Google Maps enhances the application's functionality, enabling location tracking. The Google Maps API is employed to display maps, markers, and routes between selected start and end points, utilizing `Google Map SDKs for Android` and `iOS`, `Directions API`, `Places API`, `Distance Matrix API`, `Geocoding API`, and `Routes API`.

## Authentication

The app boasts a login screen with thorough validation and authentication powered by GetX's state management capabilities. After a successful login, users are seamlessly navigated to the map screen.

## Location Tracking 

Users can easily set start and end locations for tracking on a dedicated screen. Whether inputting locations manually or selecting them from the map, markers are displayed for the chosen points. The app dynamically moves the start marker to the end location, offering a visual representation through animation or real-time updates.

## Trip Summary

The app provide comprehensive trip summary, encompassing start and end locations, destination, distance, start time, end time, duration, and cost calculated at a rate of 2 AED per kilometer traveled.

## Error Handling 

Robust error-handling mechanisms are implemented throughout the application to gracefully manage exceptions, network errors, and edge cases. This ensures a smooth and reliable user experience.

## Setup Instructions 

To set up the Trip Tracker app, follow these steps:

1. Clone the repository: **`git clone`**  https://github.com/aymansainshy/Task-Watt.git
2. Navigate to the project directory: **`cd`  Task-Watt**
3. Run **`flutter pub get`** to install dependencies.
4. Set up your Google Maps API key. For instructions, refer to: https://pub.dev/packages/google_maps_flutter.
5. Add the Google Maps API key to the app.
6. Connect a device or start an emulator.
7. Run **`flutter run`** to launch the application.

## Usage Guidelines

Follow these guidelines to make the most of the Trip Tracker app:

1. **Login**: Use the provided credentials (email: **`ayman@gmail.com`**, password: **`Password123`**) to access the app .
2. **Set Locations**: Navigate to the location-setting screen to input start and end locations.
3. **Map Screen**: Explore the map displaying selected locations and the route.
4. **Start Trip**: Initiate tracking to visualize the movement of the start marker to the end location.
5. **Trip Summary**: View the summary in top of the **`mapView`**, which includes distance, time, and cost.
6. **Error Handling**: In case of errors or unexpected issues, the app provides informative messages for a user-friendly experience.




**Developed by**

This project is developed by Ayman Abdulrahman. Connect with Ayman on https://www.linkedin.com/in/ayman-abdulrahman-4aa89b195/









## Some ScreenShots

<img src="https://github.com/aymansainshy/Task-Watt/blob/main/assets/screenshots/sc3.png" width="700">

<img src="https://github.com/aymansainshy/Task-Watt/blob/main/assets/screenshots/sc5.png" width="350"> <img src="https://github.com/aymansainshy/Task-Watt/blob/main/assets/screenshots/sc6.png" width="350"> 

<img src="https://github.com/aymansainshy/Task-Watt/blob/main/assets/screenshots/sc1.png" width="700">
<img src="https://github.com/aymansainshy/Task-Watt/blob/main/assets/screenshots/sc2.png" width="700">























- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# task_watt_google_map
# Task-Watt
