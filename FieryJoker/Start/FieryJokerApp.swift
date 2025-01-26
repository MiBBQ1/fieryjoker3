import AppTrackingTransparency
import SwiftUI

extension Notification.Name {
    static let notat = Notification.Name("didReceiveTrackingAuthorization")
}

class AppState: ObservableObject {
    @Published var sho: Bool = true
}

@main
struct FieryJokerApp: App {
    @State private var isLoad = true
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if !isLoad {
                MunuView()
            }
            else {
                ContentView()
                    .onAppear {
                        askCall()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoad = false
                        }
                    }
            }
        }
    }
    
    func askCall() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    NotificationCenter.default.post(name: .notat, object: nil)
                case .denied:
                    NotificationCenter.default.post(name: .notat, object: nil)
                case .restricted:
                    break
                case .notDetermined:
                    askCall()
                @unknown default:
                    break
                }
            }
        }
    }
}
