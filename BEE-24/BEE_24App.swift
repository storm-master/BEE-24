import SwiftUI
import OneSignalFramework

@main
struct BEE_24App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}

enum Constants {
    static var signalID = "7c1ad11f-7cf1-408a-b711-243236f95030"
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        OneSignal.initialize(Constants.signalID, withLaunchOptions: launchOptions)
        OneSignal.Notifications.requestPermission({ accepted in
            print("User accepted notifications: \(accepted)")
        }, fallbackToSettings: false)
        
        return true
    }
}
