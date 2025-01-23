import SwiftUI

struct TileView: View {
    @Binding var tile: Tile
    @Binding var isFlagMode: Bool

    var body: some View {
        ZStack {
            ZStack {
                Image("tile\(UserDefaults.standard.integer(forKey: "selectedCover"))")
                    .resizable()
                    .frame(width: 60, height: 65)
                if tile.isRevealed {
                    Rectangle()
                        .fill(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .frame(width: 55, height: 55)
                }
            }
            if tile.isFlagged {
                Image("flagImage")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color(hex: "#470000"))
                    .frame(width: 36.09, height: 40.15)
            } else if tile.isRevealed {
                if tile.isMine {
                    Image("mask\(UserDefaults.standard.integer(forKey: "selectedMask"))")
                        .resizable()
                        .frame(width: 36.09, height: 36.09)
                } else if tile.number > 0 {
                    Text("\(tile.number)")
                        .foregroundColor(tile.numberColor)
                        .font(.custom("Grenze-BoldItalic", size: 40))
                        .padding(.bottom)
                }
            }
        }
    }
}

struct Tile {
    var isRevealed: Bool = false
    var isFlagged: Bool = false
    var isMine: Bool = false
    var number: Int = 0

    var numberColor: Color {
        switch number {
        case 1: return Color(hex: "#0002F3")
        case 2: return Color(hex: "#067B00")
        case 3: return Color(hex: "#FFCC00")
        case 4: return Color(hex: "#9E1838")
        default: return .black
        }
    }
}
