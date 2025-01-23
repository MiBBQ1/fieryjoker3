import SwiftUI

struct ShopView: View {
    @Binding var showPlay: Bool

    let cardCovers = [
        ("Default", 0, "tile0"),
        ("Cover 2", 100, "tile1"),
        ("Cover 3", 500, "tile2"),
        ("Cover 4", 750, "tile3"),
    ]

    let maskCovers = [
        ("Default Mask", 0, "mask0"),
        ("Mask 2", 150, "mask1"),
        ("Mask 3", 500, "mask2"),
        ("Mask 4", 750, "mask3"),
    ]

    @State private var selectedCategory: String = "Tiles"
    @State private var whereSwip: AnyTransition = .identity
    @State private var isSwiping: Bool = false
    @Binding var selectedTile: Int
    @Binding var selectedMask: Int
    @Binding var purchasedCovers: [Int]
    @Binding var purchasedMasks: [Int]
    @State private var indexCurrent: Int = 0

    var body: some View {
        ZStack {
            Image("IMG_1662 (2) 1")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()

            VStack {
                
                Spacer().frame(height: UIScreen.main.bounds.height > 667 ? 50 : 70)
                HStack {
                    Button(action: {
                        withAnimation { showPlay = false }
                    }) {
                        Image("IMG_1694 1")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .scaledToFit()
                    }
                    .padding(.leading)
                    Spacer()
                    ZStack {
                        Image("table_teenpatti_normal")
                            .resizable()
                            .frame(width: 211, height: 118)
                        Text("Shop")
                            .foregroundColor(.white)
                            .font(.custom("Grenze-BoldItalic", size: 40))
                            .padding(.bottom)
                    }
                    .padding(.trailing, 70)
                    Spacer()
                }
                

                HStack {
                    CoinView()
                        .padding(.leading)
                    Spacer()
                    LifeView()
                        .padding(.trailing)
                }
                Spacer()

                HStack(spacing: 0) {
                    ForEach(["Tiles", "Masks"], id: \.self) { item in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(item == selectedCategory ? Color(hex: "#9E1838") : Color.clear)
                                .animation(.easeInOut(duration: 0.3), value: selectedCategory)
                            Text(item)
                                .font(item == selectedCategory ? .custom("Grenze-Bold", size: 31) : .custom("Grenze-Regular", size: 31))
                                .foregroundColor(item == selectedCategory ? Color.white : Color.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())  
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                selectedCategory = item
                            }
                        }
                    }
                }
                .frame(height: 55)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()



                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(Color(hex: "#3A0000"))
                        .frame(width: UIScreen.main.bounds.height > 667 ? 323 : 275,
                               height: UIScreen.main.bounds.height > 667 ? 323 : 275)
                        .cornerRadius(23)
                        .overlay(
                            RoundedRectangle(cornerRadius: 23)
                                .stroke(Color(hex: "#FFE28C"), lineWidth: 23)
                        )

                    let currentCovers = selectedCategory == "Tiles" ? cardCovers : maskCovers

                    ZStack {
                        ForEach(0..<currentCovers.count, id: \.self) { index in
                            if index == indexCurrent {
                                VStack {
                                    Image(currentCovers[index].2)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 109, height: 109)
                                        .cornerRadius(16)
                                        .transition(whereSwip)
                                        .animation(.easeInOut(duration: 0.4), value: selectedTile)

                                    ZStack {
                                        Rectangle()
                                            .fill(Color(hex: "#9E1838"))
                                            .frame(width: 114, height: 46)
                                            .cornerRadius(10)
                                        HStack {
                                            Text("\(currentCovers[index].1)")
                                                .foregroundColor(.white)
                                                .font(.custom("Grenze-Bold", size: 34))
                                                .padding(.leading)
                                            Image("coin")
                                                .resizable()
                                                .frame(width: 46, height: 46)
                                        }
                                        .padding(.bottom, 5)
                                    }
                                    Button(action: {
                                        var coinsCounter = UserDefaults.standard.integer(forKey: "coinAmount")
                                        if selectedCategory == "Tiles" {
                                            if purchasedCovers.contains(indexCurrent) {
                                                selectedTile = indexCurrent
                                                UserDefaults.standard.set(indexCurrent, forKey: "selectedCover")
                                            } else if coinsCounter >= currentCovers[indexCurrent].1 {
                                                coinsCounter -= currentCovers[indexCurrent].1
                                                purchasedCovers.append(indexCurrent)
                                                UserDefaults.standard.set(purchasedCovers, forKey: "purchasedCovers")
                                                UserDefaults.standard.set(coinsCounter, forKey: "coinAmount")
                                            }
                                        }
                                        else {
                                            if purchasedMasks.contains(indexCurrent) {
                                                selectedMask = indexCurrent
                                                UserDefaults.standard.set(selectedMask, forKey: "selectedMask")
                                            } else if coinsCounter >= currentCovers[indexCurrent].1 {
                                                coinsCounter -= currentCovers[indexCurrent].1
                                                purchasedMasks.append(indexCurrent)
                                                UserDefaults.standard.set(purchasedMasks, forKey: "purchasedMasks")
                                                UserDefaults.standard.set(coinsCounter, forKey: "coinAmount")
                                            }
                                        }
                                       
                                        
                                    }) {
                                        ZStack {
                                            Image("Button Framed")
                                                .resizable()
                                                .frame(width: 236, height: 80)
                                                .scaledToFill()
                                            if selectedCategory == "Tiles" {
                                                Text(selectedTile == indexCurrent ? "Selected" : purchasedCovers.contains(indexCurrent) ? "Select" : "Buy")
                                                    .foregroundColor(.white)
                                                    .font(.custom("Grenze-BoldItalic", size: 40))
                                                    .frame(width: 236, height: 80)
                                            }
                                            else {
                                                Text(selectedMask == indexCurrent ? "Selected" : purchasedMasks.contains(indexCurrent) ? "Select" : "Buy")
                                                    .foregroundColor(.white)
                                                    .font(.custom("Grenze-BoldItalic", size: 40))
                                                    .frame(width: 236, height: 80)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .overlay(
                        HStack {
                            Button(action: {
                                backElemt(currentCovers: currentCovers)
                            }) {
                                Image("IMG_1694 1")
                                    .resizable()
                                    .frame(width: 56.09, height: 51.33)
                            }
                            Spacer()
                            Button(action: {
                                nextElement(currentCovers: currentCovers)
                            }) {
                                Image("IMG_1694 2")
                                    .resizable()
                                    .frame(width: 56.09, height: 51.33)
                            }
                        }
                        .padding(.horizontal, -60)
                        
                    )
                }
                .padding(.bottom, UIScreen.main.bounds.height > 667 ? 0 : 80)
                Spacer()
            }
        }
    }

    private func nextElement(currentCovers: [(String, Int, String)]) {
        guard !isSwiping else { return }
        isSwiping = true
        whereSwip = .move(edge: .leading)
        withAnimation(.easeInOut(duration: 0.4)) {
            indexCurrent = (indexCurrent + 1) % currentCovers.count
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isSwiping = false
        }
    }

    private func backElemt(currentCovers: [(String, Int, String)]) {
        guard !isSwiping else { return }
        isSwiping = true
        whereSwip = .move(edge: .trailing)
        withAnimation(.easeInOut(duration: 0.4)) {
            indexCurrent = (indexCurrent - 1 + currentCovers.count) % currentCovers.count
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isSwiping = false
        }
    }
}

#Preview {
    ShopView(showPlay: .constant(true),
             selectedTile: .constant(0),
             selectedMask: .constant(0),
             purchasedCovers: .constant([0]),
             purchasedMasks: .constant([0]))
}
