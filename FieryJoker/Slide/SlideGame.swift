import SwiftUI

struct SlideGame: View {
    @Binding var isWin: Bool
    @Binding var currentLevel: Int

    @State private var elements: [GameElement] = []

    let gridSize = 6

    var body: some View {
        GeometryReader { geo in
            let tileSize: CGFloat = 351 / CGFloat(gridSize)
            ZStack {
                ForEach(0..<gridSize, id: \ .self) { row in
                    ForEach(0..<gridSize, id: \.self) { column in
                        Rectangle()
                            .stroke(Color.gray)
                            .frame(width: tileSize, height: tileSize)
                            .position(x: CGFloat(column) * tileSize + tileSize / 2, y: CGFloat(row) * tileSize + tileSize / 2)
                    }
                }
 
                ForEach(elements) { element in
                    Image(getImageName(for: element))
                        .resizable()
                        .frame(width: tileSize * CGFloat(element.width), height: tileSize * CGFloat(element.height))
                        .position(x: tileSize * CGFloat(element.column) + tileSize * CGFloat(element.width) / 2,
                                  y: tileSize * CGFloat(element.row) + tileSize * CGFloat(element.height) / 2)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    moveElement(element: element, by: value.translation, tileSize: tileSize)
                                }
                                .onEnded { value in
                                    finishMovement(element: element, by: value.translation, tileSize: tileSize)
                                }
                        )
                        .animation(.easeInOut, value: element.column)
                        .animation(.easeInOut, value: element.row)
                }
            }
            .frame(width: 351, height: 351)
            .onAppear {
                elements = LevelProvider.generateLevel(currentLevel)
            }
            .onChange(of: currentLevel) { newLevel in
                            elements = LevelProvider.generateLevel(newLevel)
                        }
        }
    }

    func getImageName(for element: GameElement) -> String {
        if element.isYellow {
            return "yellow"
        } else if element.width == 2 {
            return element.isVertical ? "red_2" : "blue_2"
        } else {
            return element.isVertical ? "red_3" : "blue_3"
        }
    }

    func moveElement(element: GameElement, by translation: CGSize, tileSize: CGFloat) {
        guard let index = elements.firstIndex(where: { $0.id == element.id }) else { return }
        let newOffsetX = elements[index].offsetX + translation.width / tileSize
        let newOffsetY = elements[index].offsetY + translation.height / tileSize

        if element.isVertical {
            elements[index].offsetY = newOffsetY
        } else {
            elements[index].offsetX = newOffsetX
        }
    }

    func finishMovement(element: GameElement, by translation: CGSize, tileSize: CGFloat) {
        guard let index = elements.firstIndex(where: { $0.id == element.id }) else { return }
        let gridTranslationX = Int(round(translation.width / tileSize))
        let gridTranslationY = Int(round(translation.height / tileSize))

        if element.isVertical {
            let newRow = elements[index].row + gridTranslationY
            if isValidMove(element: element, newRow: newRow, newColumn: elements[index].column) {
                elements[index].row = newRow
            }
        } else {
            let newColumn = elements[index].column + gridTranslationX
            if isValidMove(element: element, newRow: elements[index].row, newColumn: newColumn) {
                elements[index].column = newColumn
 
                if element.isYellow && newColumn + element.width >= gridSize {
                    removeElementWithAnimation(at: index)
                    isWin = true
                    return
                }
            }
        }

        if isOutOfBounds(element: elements[index]) {
            if element.isYellow {
                isWin = true
            } else {
                removeElementWithAnimation(at: index)
            }
        } else {
            elements[index].offsetX = 0
            elements[index].offsetY = 0
        }
    }

    func isOutOfBounds(element: GameElement) -> Bool {
        return element.column < 0 || element.column + element.width > gridSize ||
               element.row < 0 || element.row + element.height > gridSize
    }

    func removeElementWithAnimation(at index: Int) {
        withAnimation(.easeInOut) {
            elements.remove(at: index)
        }
    }

    func isValidMove(element: GameElement, newRow: Int, newColumn: Int) -> Bool {
        if newColumn < 0 || newColumn + element.width > gridSize || newRow < 0 || newRow + element.height > gridSize {
            return false
        }

        for otherElement in elements where otherElement.id != element.id {
            let otherRect = CGRect(x: otherElement.column, y: otherElement.row, width: otherElement.width, height: otherElement.height)
            let currentRect = CGRect(x: newColumn, y: newRow, width: element.width, height: element.height)
            if otherRect.intersects(currentRect) {
                return false
            }
        }

        return true
    }
}

struct GameElement: Identifiable {
    let id = UUID()
    var imageName: String
    var row: Int
    var column: Int
    var width: Int
    var height: Int
    var isYellow: Bool
    var isVertical: Bool
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
}

struct LevelProvider {
    static let levelCount = 12

    static func generateLevel(_ level: Int) -> [GameElement] {
        let levelLayouts: [[Int]] = [
            // Each level is a 6x6 grid represented by integers
            // 0 = empty, 1 = horizontal blue 2, 2 = vertical red 2, 3 = horizontal blue 3, 4 = vertical red 3, 5 = yellow
            [
                0, 0, 0, 3, 0, 0,
                1, 0, 0, 0, 2, 0,
                5, 0, 4, 0, 0, 0,
                0, 0, 0, 3, 0, 0,
                1, 0, 0, 1, 0, 2,
                0, 1, 0, 1, 0, 0
            ],
            [
                2, 0, 0, 0, 2, 2,
                0, 3, 0, 0, 0, 0,
                5, 0, 2, 2, 2, 2,
                1, 0, 0, 0, 0, 0,
                0, 0, 0, 2, 1, 0,
                0, 0, 0, 0, 0, 0
            ],
            [
                2, 2, 2, 0, 0, 2,
                0, 0, 0, 1, 0, 0,
                5, 0, 0, 0, 2, 0,
                1, 0, 0, 4, 0, 0,
                3, 0, 0, 0, 0, 0,
                1, 0, 0, 0, 0, 0
            ],
            [
                2, 0, 1, 0, 2, 0,
                0, 3, 0, 0, 0, 0,
                5, 0, 2, 2, 0, 0,
                0, 2, 0, 0, 0, 0,
                0, 0, 0, 2, 1, 0,
                0, 0, 0, 0, 0, 0
            ],
            [
                0, 0, 0, 2, 1, 0,
                0, 0, 2, 0, 1, 0,
                5, 0, 0, 2, 2, 2,
                1, 0, 0, 0, 0, 0,
                2, 3, 0, 0, 0, 2,
                0, 3, 0, 0, 0, 0
            ],
            [
                1, 0, 2, 0, 0, 0,
                2, 0, 0, 1, 0, 0,
                0, 5, 0, 4, 2, 0,
                0, 0, 0, 0, 0, 0,
                3, 0, 0, 0, 2, 0,
                0, 0, 1, 0, 0, 0
            ],
            [
                2, 3, 0, 0, 2, 4,
                0, 0, 4, 2, 0, 0,
                5, 0, 0, 0, 0, 0,
                1, 0, 0, 2, 0, 0,
                0, 1, 0, 0, 2, 0,
                0, 3, 0, 0, 0, 0
            ],
            [
                2, 1, 0, 1, 0, 2,
                0, 0, 0, 4, 0, 0,
                5, 0, 2, 0, 0, 0,
                0, 0, 0, 0, 1, 0,
                3, 0, 0, 0, 2, 2,
                1, 0, 0, 0, 0, 0
            ],
            [
                0, 3, 0, 0, 0, 2,
                0, 0, 2, 1, 0, 0,
                5, 0, 0, 0, 0, 2,
                0, 0, 0, 4, 0, 0,
                0, 0, 0, 0, 1, 0,
                3, 0, 0, 0, 0, 0
            ],
            [
                0, 0, 0, 2, 1, 0,
                0, 0, 2, 0, 1, 0,
                5, 0, 0, 2, 2, 2,
                1, 0, 0, 0, 0, 0,
                2, 3, 0, 0, 0, 2,
                0, 3, 0, 0, 0, 0
            ],
            
            [
                1, 0, 2, 0, 0, 0,
                2, 0, 0, 1, 0, 0,
                0, 5, 0, 4, 2, 0,
                0, 0, 0, 0, 0, 0,
                3, 0, 0, 0, 2, 0,
                0, 0, 1, 0, 0, 0
            ],
        ]

        let layout = levelLayouts[level % levelLayouts.count]
        var elements: [GameElement] = []

        for row in 0..<6 {
            for column in 0..<6 {
                let value = layout[row * 6 + column]
                switch value {
                case 1:
                    elements.append(GameElement(imageName: "blue_2", row: row, column: column, width: 2, height: 1, isYellow: false, isVertical: false))
                case 2:
                    elements.append(GameElement(imageName: "red_2", row: row, column: column, width: 1, height: 2, isYellow: false, isVertical: true))
                case 3:
                    elements.append(GameElement(imageName: "blue_3", row: row, column: column, width: 3, height: 1, isYellow: false, isVertical: false))
                case 4:
                    elements.append(GameElement(imageName: "red_3", row: row, column: column, width: 1, height: 3, isYellow: false, isVertical: true))
                case 5:
                    elements.append(GameElement(imageName: "yellow", row: row, column: column, width: 2, height: 1, isYellow: true, isVertical: false))
                default:
                    break
                }
            }
        }

        return elements
    }
}

struct SlideGame_Previews: PreviewProvider {
    static var previews: some View {
        SlideGame(isWin: .constant(false), currentLevel: .constant(0))
    }
}
