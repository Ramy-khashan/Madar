import Flutter
import UIKit
import GoogleMaps


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if let mapsApiKey = Bundle.main.object(forInfoDictionaryKey: "MAPS_API_KEY") as? String {
      let trimmedKey = mapsApiKey.trimmingCharacters(in: .whitespacesAndNewlines)
      if !trimmedKey.isEmpty && trimmedKey != "$(MAPS_API_KEY)" {
        GMSServices.provideAPIKey(trimmedKey)
        print("Google Maps initialized with API key")
      } else {
        print("Warning: Google Maps API key is not configured properly")
      }
    } else {
      print("Warning: Google Maps API key not found in Info.plist")
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
