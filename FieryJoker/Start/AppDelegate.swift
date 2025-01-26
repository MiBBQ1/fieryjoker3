import SwiftUI
import OneSignalFramework
import AppsFlyerLib

class AppDelegate: NSObject, UIApplicationDelegate, AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        
    }
    
    func onConversionDataFail(_ error: Error) {
        
    }
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(handleTrackingAuthorizationNotification(_:)), name: .notat, object: nil)
        
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        OneSignal.initialize("10264721-9781-4f93-8c7b-4c799de76b31", withLaunchOptions: launchOptions)
        
        
        return true
    }
    @objc private func handleTrackingAuthorizationNotification(_ notification: Notification) {
        
        OneSignal.Notifications.requestPermission({ accepted in
            
            if accepted {
                
                UserDefaults.standard.set(true, forKey: "push_subscribe")
            }
        }, fallbackToSettings: false)
        AppsFlyerLib.shared().appsFlyerDevKey = "E4eQAmkzuEWdCxqeqVnJ8Z"
        AppsFlyerLib.shared().appleAppID = "6740920553"
        AppsFlyerLib.shared().isDebug = false
        AppsFlyerLib.shared().delegate = self
        
        if let idfv = UIDevice.current.identifierForVendor?.uuidString {
            UserDefaults.standard.setValue(idfv, forKey: "idfv")
            AppsFlyerLib.shared().customerUserID = idfv
        }
        
        askNot()
    }
    func askNot() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
               
                UserDefaults.standard.set(true, forKey: "push_subscribe")
            }
             
        }
    }
}
