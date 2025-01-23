import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("Splash screen")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                
           
        }
    }
}

#Preview {
    ContentView()
}
