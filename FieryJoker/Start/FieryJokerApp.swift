import AppTrackingTransparency
import SwiftUI

@main
struct FieryJokerApp: App {
    @State private var isLoad = true
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
                    break
                case .denied:
                    break
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
