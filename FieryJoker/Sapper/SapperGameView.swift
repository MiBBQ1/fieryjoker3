import SwiftUI

struct SapperGameView: View {
    @State private var grid: [[Tile]] = []
    @State private var isFlagMode: Bool = false
    @State private var gameOver: Bool = false
    @State private var noEnoughtCoins: Bool = false
    @State private var gameWon: Bool = false
    @State private var totalMines: Int = Int.random(in: 10...15)
    @State private var openLevels: Int = UserDefaults.standard.integer(forKey: "openLevels")
    
    @Binding var showPlay: Bool

    init(showPlay: Binding<Bool>) {
        self._showPlay = showPlay
        self._grid = State(initialValue: SapperGameView.createGrid(rows: 8, columns: 6, mines: Int.random(in: 10...15)))
    }

    var body: some View {
        ZStack {
            Image("IMG_1662 (2) 1")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            VStack {
                HStack {
                    Spacer()
                    ZStack {
                        Image("table_teenpatti_normal")
                            .resizable()
                            .frame(width: 211, height: 118)
                        Text("Sapper")
                            .foregroundColor(.white)
                            .font(.custom("Grenze-BoldItalic", size: 40))
                            .padding(.bottom)
                    }
                    .padding(.trailing)
                    Button(action: {
                        withAnimation {
                            showPlay = false
                        }
                    }) {
                        ZStack {
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                            Image("checkMark")
                                .resizable()
                                .frame(width: 26.69, height: 26.69)
                                .scaledToFit()
                        }
                    }
                    .padding(.trailing)
                }
                if UIScreen.main.bounds.height > 667 {
                    HStack {
                        CoinView()
                            .padding(.leading)
                        Spacer()
                        LifeView()
                            .padding(.trailing)
                    }
                    Spacer().frame(height: 50)
                }
                
                    ForEach(0..<8, id: \..self) { row in
                        HStack {
                            ForEach(0..<6, id: \..self) { column in
                                TileView(tile: $grid[row][column], isFlagMode: $isFlagMode)
                                    .frame(width: 50, height: 50)
                                    .onTapGesture {
                                        if UserDefaults.standard.integer(forKey: "lives") > 0 {
                                            if isFlagMode {
                                                grid[row][column].isFlagged.toggle()
                                                checkWinCondition()
                                            } else {
                                                revealTile(row: row, column: column)
                                            }
                                        }
                                        else {
                                            withAnimation {
                                                noEnoughtCoins = true
                                            }
                                        }
                                    }
                            }
                        }
                    }
                
                
                HStack {
                    Button(action: { isFlagMode = true }) {
                        ZStack {
                            Rectangle()
                                .fill(Color(hex: "#FF0000"))
                            .frame(width: 80.15, height: 60.04)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 2))
                            Image("flagImage")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(isFlagMode ? Color(hex: "#FFCC00") : Color.white)
                                .frame(width: 36.09, height: 40.15)
                            
                        }
                        
                        
                    }
                    Button(action: { isFlagMode = false }) {
                        ZStack {
                            Rectangle()
                                .fill(Color(hex: "#FF0000"))
                                .frame(width: 80.15, height: 60.04)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 2))
                            Image("clickIcon")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(!isFlagMode ? Color(hex: "#FFCC00") : Color.white)
                                .frame(width: 36.09, height: 40.15)
                        }
                    }
                }
            }
            if gameOver {
                ZStack {
                    Color.black.opacity(0.8)
                               .ignoresSafeArea()
                               .transition(.opacity)
                    VStack {
                        ZStack {
                            Image("table_teenpatti_normal")
                                .resizable()
                                .frame(width: 369, height: 206)
                            Text("Game over")
                                .foregroundColor(.white)
                                .font(.custom("Grenze-BoldItalic", size: 65))
                                .padding(.bottom, 35)
                        }
                        HStack {
                            Button(action: { withAnimation { showPlay = false } }) {
                                ZStack {
                                    Image("SmallButtonFramed")
                                        .resizable()
                                        .frame(width: 113, height: 80)
                                        .scaledToFill()
                                    
                                    Image("homeICon")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                }
                            }
                            Button(action: { restartGame() }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(hex: "#FFCC00"))
                                        .frame(width: 113, height: 80)
                                        .cornerRadius(15)
                                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color(hex: "#EBAA01"), lineWidth: 4))
                                    Image("restartIcon")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                }
                            }
                        }
                    }
                }
            } else if gameWon {
                ZStack {
                    Color.black.opacity(0.8)
                               .ignoresSafeArea()
                               .transition(.opacity)
                    VStack {
                        ZStack {
                            Image("table_teenpatti_normal")
                                .resizable()
                                .frame(width: 369, height: 206)
                            Text("Passed")
                                .foregroundColor(.white)
                                .font(.custom("Grenze-BoldItalic", size: 65))
                                .padding(.bottom, 35)
                        }
                        HStack {
                            Button(action: { withAnimation { showPlay = false } }) {
                                ZStack {
                                    Image("SmallButtonFramed")
                                        .resizable()
                                        .frame(width: 113, height: 80)
                                        .scaledToFill()
                                    
                                    Image("homeICon")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                }
                            }
                            Button(action: { restartGame() }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(hex: "#FFCC00"))
                                        .frame(width: 113, height: 80)
                                        .cornerRadius(15)
                                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color(hex: "#EBAA01"), lineWidth: 4))
                                    Image("restartIcon")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                }
                            }
                        }
                    }
                }
            }
            else if noEnoughtCoins == true {
                ZStack {
                    Color.black.opacity(0.8)
                               .ignoresSafeArea()
                               .transition(.opacity)
                    VStack {
                        ZStack {
                            Image("table_teenpatti_normal")
                                .resizable()
                                .frame(width: 369, height: 206)
                            Text("No Life")
                                .foregroundColor(.white)
                                .font(.custom("Grenze-BoldItalic", size: 65))
                                .padding(.bottom, 35)
                        }
                        Text("Your life counter is 0/3 now. You need to have 1 more life to play again. Counter updates back to 3/3 each day. Return tomorrow, or play Slide game that has no limits.")
                            .foregroundColor(.white)
                            .font(.custom("Grenze-Regular", size: 25))
                            .multilineTextAlignment(.center)
                            Button(action: { withAnimation { showPlay = false } }) {
                                ZStack {
                                    Image("SmallButtonFramed")
                                        .resizable()
                                        .frame(width: 113, height: 80)
                                        .scaledToFill()
                                    
                                    Image("homeICon")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                }
                            }
                             
                        
                    }
                }
            }
        }
    }
    private func restartGame() {
        withAnimation {
            grid = SapperGameView.createGrid(rows: 8, columns: 6, mines: Int.random(in: 10...15))
            isFlagMode = false
            gameOver = false
            gameWon = false
        }
    }

    private func revealTile(row: Int, column: Int) {
        guard !grid[row][column].isRevealed && !grid[row][column].isFlagged else { return }

        grid[row][column].isRevealed = true

        if grid[row][column].isMine {
            var livesCounter =  UserDefaults.standard.integer(forKey: "lives")
            if livesCounter > 0 {
                livesCounter -= 1
                UserDefaults.standard.set(livesCounter, forKey: "lives")
            }
            withAnimation {
                gameOver = true
            }
        } else if grid[row][column].number == 0 {
            for r in max(0, row-1)...min(7, row+1) {
                for c in max(0, column-1)...min(5, column+1) {
                    if !(r == row && c == column) {
                        revealTile(row: r, column: c)
                    }
                }
            }
        }

        checkWinCondition()
    }

    private func checkWinCondition() {
        let allNonMinesRevealed = grid.allSatisfy { row in
            row.allSatisfy { tile in
                (tile.isRevealed && !tile.isMine) || (!tile.isRevealed && tile.isMine)
            }
        }

        let allMinesFlagged = grid.allSatisfy { row in
            row.allSatisfy { tile in
                (tile.isMine && tile.isFlagged) || (!tile.isMine && !tile.isFlagged)
            }
        }

        if allNonMinesRevealed || allMinesFlagged {
            openLevels += 1
            UserDefaults.standard.set(openLevels, forKey: "openLevels")
            withAnimation {
                gameWon = true
            }
        }
    }

    static func createGrid(rows: Int, columns: Int, mines: Int) -> [[Tile]] {
        var grid = Array(repeating: Array(repeating: Tile(), count: columns), count: rows)
 
        var minePositions = Set<[Int]>()
        while minePositions.count < mines {
            let randomRow = Int.random(in: 0..<rows)
            let randomCol = Int.random(in: 0..<columns)
            minePositions.insert([randomRow, randomCol])
        }

        for position in minePositions {
            grid[position[0]][position[1]].isMine = true
        }
 
        for row in 0..<rows {
            for column in 0..<columns {
                if grid[row][column].isMine { continue }

                var mineCount = 0
                for r in max(0, row-1)...min(rows-1, row+1) {
                    for c in max(0, column-1)...min(columns-1, column+1) {
                        if grid[r][c].isMine {
                            mineCount += 1
                        }
                    }
                }
                grid[row][column].number = mineCount
            }
        }

        return grid
    }
}

#Preview {
    SapperGameView(showPlay: .constant(true))
}
