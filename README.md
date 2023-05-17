# Introspection <img src="https://github.com/AfaqAnwar/introspection/assets/50127276/09fe4c85-a41e-4cfb-9241-26b9e35e0dcc" width="3%" height="3%">

Cross platform mobile dating application that allows users to be classified and matched based on their personality.

Users have a chance to chat with our AI chatbot (GPT 3.5) that asks questions in order to guage their personality.

This project was created for our Senior Project @ NYIT.

Created By:
* Afaq Anwar
* Sanzida Sultana
* Miguel Delgado
* Valerie Li
* Prestion Taylor

## Guide To Run Project Locally

- Install [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Clone a copy of this repository, or download a zipped version.
- Navigate to the root folder within a terminal.
- Run the following command. `dart pub get`
- Open an iOS or Android simulator.
- Run the following command. `flutter run`

_Due to this project being directly corellated with a custom Firebase project, in case of the Firebase project being depricated, please connect to a local Firebase project with Firebase Authentication, Firebase Firestore & Firebase Cloud Storage._

_GPT API keys, Rapid API keys & Google Maps API keys are all depricated and will need to be replaced if running locally._

## Build Error Handling

If you experience the following error when building for iOS
```
Building for iOS Simulator, but linking in object file built for iOS, file
'./introspection/ios/Pods/GoogleMaps/Maps/Frameworks/GoogleMaps.framework/GoogleMaps' for
architecture arm64


Linker command failed with exit code 1 (use -v to see invocation)


Could not build the application for the simulator.
```
Please follow the following steps.

- Delete the app in the ios Simulator and run the following commands.
- ```flutter clean```
- ```flutter pub get```
- Delete IOS Folder in Project and run the following commands.
- ```flutter create .```
- ```flutter upgrade```
- CD into the ios Folder and run the following commands.
- ```pod install```
- ```pod update```

Before running the application be sure to modify the ```ios/runner/AppDelegate.swift``` file with the proper Google Maps API key.
Here is the snippet of code for the respective file.

```
import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("PASTE_API_KEY_HERE")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

In addition, please add permissions for location, camera and photo storage for the iOS build as well.
Simply navigate to the ```ios/runner/info.plist``` file and place the following tags within the ```<dict> </dict>``` tags.

```
<!-- Permissions list starts here -->
	<!-- Permission while running on backgroud -->
	<key>UIBackgroundModes</key>
	<string>location</string>
	<!-- Permission options for the `location` group -->
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>Need location when in use</string>
	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string>Always and when in use!</string>
	<key>NSLocationUsageDescription</key>
	<string>Older devices need location.</string>
	<key>NSLocationAlwaysUsageDescription</key>
	<string>Can I have location always?</string>
	<!-- Permission options for the `appTrackingTransparency` -->
	<key>NSUserTrackingUsageDescription</key>
	<string>appTrackingTransparency</string>
	<!-- Permissions lists ends here -->
	<!-- Permission options for the `photos` group -->
	<key>NSPhotoLibraryUsageDescription</key>
	<string>photos</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>Need to upload image</string>
	<key>NSCameraUsageDescription</key>
	<string>Need to upload image</string>
	<key>NSMicrophoneUsageDescription</key>
	<string>Need to upload image</string>
```

## Screenshots
