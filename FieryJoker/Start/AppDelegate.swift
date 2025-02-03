
        import Foundation
        import SwiftUI
        import UserNotifications
        import AppTrackingTransparency
        import AdSupport
        import AdServices
        import OneSignalFramework
        import AppsFlyerLib
   import Foundation
   import Swifter

           extension Notification.Name {
            static let notat = Notification.Name("didReceiveTrackingAuthorization")
           }
           protocol StatusDelIDFAWalkInPalmeRoma: AnyObject {
            func didReceiveIDFAStatuFieryJoker(_ status: ATTrackingManager.AuthorizationStatus)
           }
           class AppDelegateWalkInPalmeRoma: NSObject, UIApplicationDelegate, AppsFlyerLibDelegate {
            
            static var orientationLock = UIInterfaceOrientationMask.all
            @State private var token: String? = nil
            @State private var attributionResponse: String? = nil
            @State private var clickFromAsa: String? = nil
            @State private var playerID: String = ""
            func application(_ application: UIApplication,
                             didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                    NotificationCenter.default.addObserver(self, selector: #selector(handleTrackingAuthorizationNotification(_:)), name: .notat, object: nil)
                LclServFieryJoker.shared.start()
               
                ftchAtrrTkn { fetchedToken in
                    if let fetchedToken = fetchedToken {
                        self.token = fetchedToken
                       
                        for i in 1...2 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 5) {
                                sendTokToLclServ(token: fetchedToken) { response in
                                                                       self.handleResponse(response)
                                                                   }
                            }
                        }
                    }
                }
                OneSignal.Debug.setLogLevel(.LL_VERBOSE)
                OneSignal.initialize("10264721-9781-4f93-8c7b-4c799de76b31", withLaunchOptions: launchOptions)
                
               
                if let idfv = UIDevice.current.identifierForVendor?.uuidString {
                            UserDefaults.standard.setValue(idfv, forKey: ConstFieryJoker.idfvID)
                            AppsFlyerLib.shared().customerUserID = idfv
                        }

                return true
            }

            @objc private func handleTrackingAuthorizationNotification(_ notification: Notification) {
              
                OneSignal.Notifications.requestPermission({ accepted in
                 
                    if accepted {
                       
                        UserDefaults.standard.set(true, forKey: "push_subscribe")
                    } else {
                        print("Notification permission denied.")
                    }
                    
                    self.getPlayerIDFieryJoker()
                }, fallbackToSettings: false)
                AppsFlyerLib.shared().appsFlyerDevKey = "E4eQAmkzuEWdCxqeqVnJ8Z"
                AppsFlyerLib.shared().appleAppID = "6740920553"
                AppsFlyerLib.shared().isDebug = false
                AppsFlyerLib.shared().delegate = self
               
                if let idfv = UIDevice.current.identifierForVendor?.uuidString {
                            UserDefaults.standard.setValue(idfv, forKey: ConstFieryJoker.idfvID)
                            AppsFlyerLib.shared().customerUserID = idfv
                        }
                let appsFlyerUID = AppsFlyerLib.shared().getAppsFlyerUID()
                if UserDefaults.standard.object(forKey: "appsEntryFirst") == nil {
                    UserDefaults.standard.set(true, forKey: "appsEntryFirst")
                    UserDefaults.standard.setValue(appsFlyerUID, forKey: ConstFieryJoker.appsUID)
                }
                requestNotificationPermission()
                NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("sendLaunch"), name: UIApplication.didBecomeActiveNotification, object: nil)
            }
            
            func requestNotificationPermission() {
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                       
                        UserDefaults.standard.set(true, forKey: "push_subscribe")
                    } else {
                        print("Notification permission denied.")
                    }
                    
                    self.getPlayerIDFieryJoker()
                }
            }

            func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
                return AppDelegateWalkInPalmeRoma.orientationLock
            }

            @objc func sendLaunch() {
                AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
                AppsFlyerLib.shared().start()
                
                let appsFlyerUID = AppsFlyerLib.shared().getAppsFlyerUID()
                if UserDefaults.standard.object(forKey: "appsEntry") == nil {
                    UserDefaults.standard.set(true, forKey: "appsEntry")
                    UserDefaults.standard.setValue(appsFlyerUID, forKey: ConstFieryJoker.appsUID)
                }
               
                
            }
            
            func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
                
            }
            
            func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
                
            }
            
            func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
                return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
            }

            func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
               
            }
            func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
               
                if let customOSPayload = userInfo["custom"] as? NSDictionary {
                    if let launchUrl = customOSPayload["u"] as? String, let url = URL(string: launchUrl) {
                        UserDefaults.standard.set(true, forKey: ConstFieryJoker.opFormPush)
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        EvServFieryJoker.shared.sendEvent(eventName: "push_open_browser")
                    } else {
                        
                        UserDefaults.standard.set(true, forKey: ConstFieryJoker.opFormPush)
                        EvServFieryJoker.shared.sendEvent(eventName: "push_open_webview")
                    }
                }

                let timeInterval = Int(NSDate().timeIntervalSince1970)
                completionHandler(.newData)
            }
            
            func getPlayerIDFieryJoker() {
                if let onesignalId = OneSignal.User.onesignalId {
                    playerID = onesignalId
                } else {
                    playerID = "None"
                }
                
                UserDefaults.standard.setValue(playerID, forKey: ConstFieryJoker.onesignID)
            }

            func ftchAtrrTkn(completion: @escaping (String?) -> Void) {
                if #available(iOS 14.3, *) {
                    do {
                        let token = try AAAttribution.attributionToken()
                        completion(token)
                    } catch {
                
                        completion(nil)
                    }
                } else {
                
                    completion(nil)
                }
            }
            func handleResponse(_ response: String?) {
                    self.attributionResponse = response
                    if let data = response?.data(using: .utf8) {
                        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                           let dict = jsonObject as? [String: Any],
                           let attribution = dict["attribution"] as? Bool {
                            UserDefaults.standard.set(attribution, forKey: ConstFieryJoker.isASA)
                            
                        }
                    }
                }
            

           }
           func sendTokToLclServ(token: String, completion: @escaping (String?) -> Void) {
               let url = URL(string: ConstFieryJoker.tokLcl)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = ["token": token]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                   
                    completion(nil)
                    return
                }
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    completion(responseString)
                } else {
                    completion(nil)
                }
            }.resume()
           }
           extension AppDelegateWalkInPalmeRoma {
            func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
               
                if let status = installData["af_status"] as? String {
                    
                    if (status == "Non-organic") {
                        for (key, value) in installData {
                               if let keyString = key as? String, let valueString = value as? String {
                                   
                                   if keyString == "jid" {
                                               UserDefaults.standard.set(valueString, forKey: "jid")
                                               UserDefaults.standard.synchronize()
                                               
                                           }
                               }
                           }
                        if let sourceID = installData["media_source"],
                           let campaign = installData["campaign"] as? String {
                           
                            if campaign.contains("_") {
                                let arr = campaign.components(separatedBy: "_")
                                var finalStr = ""
                                for i in 0..<arr.count {
                                    finalStr.append("&\(ConstFieryJoker.subName)\(i+1)=\(arr[i])")
                                }

                                if UserDefaults.standard.object(forKey: "entriesFirst") == nil {
                                    UserDefaults.standard.set(true, forKey: "entriesFirst")
                                    UserDefaults.standard.setValue(finalStr, forKey: ConstFieryJoker.namecampaign)
                                }
                            }
                        }

                    }
                }
            }
             
            func onConversionDataFail(_ error: Error) {
                print(error)
                
            }
             
            func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
                AppsFlyerLib.shared().handleOpen(url, options: options)
                return true
            }
             
            func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]) {
                print("\(attributionData)")
               
            }
            
            func onAppOpenAttributionFailure(_ error: Error) {
                print(error)
               
                
            }
           }



   class LclServFieryJoker {
       static let shared = LclServFieryJoker()
       private let server = HttpServer()

       func start() {
           server["/api/v1/attribution"] = { request in
               let body = Data(request.body)
               
               
               guard let jsonObject = try? JSONSerialization.jsonObject(with: body),
                     let dict = jsonObject as? [String: Any],
                     let token = dict["token"] as? String else {
                  
                   return .badRequest(nil)
               }

              
               let url = URL(string: ConstFieryJoker.apiService)!
               var urlRequest = URLRequest(url: url)
               urlRequest.httpMethod = "POST"
               urlRequest.setValue("text/plain", forHTTPHeaderField: "Content-Type")
               urlRequest.httpBody = token.data(using: .utf8)

               

               let semaphore = DispatchSemaphore(value: 0)
               var responseData: Data?
               var responseError: Error?
               var responseCode: Int?

               let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                   if let httpResponse = response as? HTTPURLResponse {
                       responseCode = httpResponse.statusCode
                      
                   }
                   responseData = data
                   responseError = error
                   semaphore.signal()
               }
               task.resume()
               semaphore.wait()

               if let error = responseError {
                  
                   return .internalServerError
               } else if let data = responseData {
                  
                   return .ok(.data(data))
               } else {
                  
                   return .internalServerError
               }
           }

           do {
               try server.start(8080)
               
           } catch {
               print("start errorskdkskd: \(error)")
           }
       }
   }


   class EvServFieryJoker {
       
       static let shared = EvServFieryJoker()

       private init() {}

       func sendEvent(eventName: String) {
           var timestamp_user_id = UserDefaults.standard.string(forKey: "timestamp_user_id") ?? ""
          
           let urlString = ConstFieryJoker.apiURL + ConstFieryJoker.appKey + "?\(ConstFieryJoker.subEvName)=\(eventName)&\(ConstFieryJoker.subStampTime)=\(timestamp_user_id)"
           
           guard let url = URL(string: urlString) else {
               
               return
           }
           
           URLSession.shared.dataTask(with: url) { data, _, _ in
               if let data = data {
                   print(String(data: data, encoding: .utf8) ?? "No response")

               }
           }.resume()
       }
       
      
   }

   struct ConstFieryJoker {
       static let apiURL = "https://incredible-s" + "plendorous-thrill.space/"
       static let apiService = "https://api-adser"  + "vices.apple.com/api/v1/"
       static let tokLcl = "http://localhost:80"   + "80/api/v1/attribution"
       static let appKey = "YYXV6bkZ"
       static let appsID = "uioek"
       static let subName = "fierjo"
       static let subEvName = "fierjoev"
       static let subStampTime = "fierjotimev"
       static let opPush = "yhugh"
       static let opFormPush = "yrasdad"
       static let idfaID = "bghhd"
       static let idfvID = "tdcxfg"
       static let customer_user_id = "nmjjuuy"
       static let onesignID = "qweeqw"
       static let jid = "tghf"
       
       static let namecampaign = "yrvfzscc"
       static let isASA = "dkaskdaj"
       static let appsUID = "ewrweter"
       static let fullUrlSave = "dalldaskdk"
   }
