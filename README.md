# Mobiflix

A movie viewing app for movie buffs

# Video Demo
[https://photos.app.goo.gl/2ifTeFp7j6CUKyyZ8](https://photos.app.goo.gl/1kDpkhVZVbDn15ww5)

## Getting Started

This project is a starting point for a Flutter application.
Xin
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Requirement

- [Flutter Stable channer 3.19.6](https://docs.flutter.dev/release/archive))
- Dart Sdk 3.4.1,[How to download Dart Sdk 3.4.1](https://community.chocolatey.org/packages/dart-sdk/3.4.1#install)
Make sure the above libraries are installed before running the code.

## Project Structure

📦 lib
├── 📂 constant           # Contains global constants used throughout the project  
├── 📂 controller         # Main controllers handling logic and state  
├── 📂 core              # Core configurations (theme, config, helpers, etc.)  
├── 📂 data              # Manages data sources, API calls, and local database  
├── 📂 models            # Data models  
├── 📂 modules           # Main modules of the application  
│   ├── 📂 detail_movie  # Movie detail screen  
│   │   ├── 📂 bindings   # Dependency injection management  
│   │   ├── 📂 controller # Handles business logic and state management  
│   │   ├── 📂 model      # Defines data models for this module  
│   │   ├── 📂 provider   # Manages API communication and local storage  
│   │   ├── 📂 repository # Handles data processing logic  
│   │   ├── 📂 view       # UI components for the module  
│   │   ├── 📂 widgets    # Reusable widgets for the module  
│   ├── 📂 genre_movie   # Genre listing screen (same structure as `detail_movie`)  
│   ├── 📂 home          # Home screen (same structure as `detail_movie`)  
│   ├── 📂 option_movie  # Movie options screen (same structure as `detail_movie`)  
│   ├── 📂 play_movie    # Movie player screen (same structure as `detail_movie`)  
│   ├── 📂 search_movie  # Movie search screen (same structure as `detail_movie`)  
│   ├── 📂 splash        # Splash screen  
├── 📂 responsibility    # Handles business logic  
├── 📂 routes           # Manages screen navigation  
├── 📂 services         # Common services (authentication, storage, etc.)  
├── 📂 widgets          # Reusable widgets across the application  
├── 📝 main.dart        # Entry point of the application  

## How to run

1. Clone the repository (if not already):
### ab c
sh
git clone <repository_url>
cd <project_folder>
2. Open the project in Android Studio:

Open Android Studio → Click "Open" → Select the project folder.
Run Flutter pub get (to fetch dependencies):

3. Open Terminal in Android Studio and run:
sh

flutter pub get
4. Select a Device:

Click on the Device Selector in the top toolbar and choose an emulator or connected device.
5. Run the app:

Click the Run ▶ button in Android Studio OR run the following command in the terminal:
sh

flutter run
