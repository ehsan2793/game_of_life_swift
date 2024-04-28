import Foundation

let WIDTH = 0..<40
let HEIGHT = 0..<30

var nextCells: [[String]] = []

// create our next cells
for _ in WIDTH {
    var column: [String] = []
    for _ in HEIGHT {
        if Int.random(in: 0...1) == 0 {
            column.append("■")
        } else {
            column.append(" ")
        }
    }
    nextCells.append(column)
}

while true {
    print("\n")
    let currentCells = nextCells
    for y in HEIGHT {
        for x in WIDTH {
            print(currentCells[x][y], separator: "", terminator: "")
        }
        print("")
    }
    
    // now we calculate next generation
    var newCells = nextCells
    
    for x in WIDTH {
        for y in HEIGHT {
            // Calculate indices with proper wrapping
            let left_cord  = (x + WIDTH.upperBound - 1) % WIDTH.upperBound
            let right_cord = (x + 1) % WIDTH.upperBound
            let upper_cord = (y + HEIGHT.upperBound - 1) % HEIGHT.upperBound
            let lower_cord = (y + 1) % HEIGHT.upperBound
            
            // find the number of neighbors
            var total = 0
            
            if currentCells[left_cord][upper_cord] == "■" && x != 0 && y != 0 {
                total += 1 // upper left is live
            }
            if currentCells[x][upper_cord] == "■" && y != 0 {
                total += 1 // upper is live
            }
            if currentCells[right_cord][upper_cord] == "■" && x != WIDTH.upperBound - 1 && y != 0 {
                total += 1 // upper right is live
            }
            if currentCells[left_cord][y] == "■" && x != 0 {
                total += 1 // left is live
            }
            if currentCells[right_cord][y] == "■" && x != WIDTH.upperBound - 1 {
                total += 1 // right is live
            }
            if currentCells[left_cord][lower_cord] == "■" && x != 0 && y != HEIGHT.upperBound - 1 {
                total += 1 // left bottom is live
            }
            if currentCells[x][lower_cord] == "■" && y != HEIGHT.upperBound - 1 {
                total += 1 // bottom is live
            }
            if currentCells[right_cord][lower_cord] == "■" && x != WIDTH.upperBound - 1 && y != HEIGHT.upperBound - 1 {
                total += 1 // right bottom is live
            }
            
            if currentCells[x][y] == "■" && (total == 2 || total == 3) {
                newCells[x][y] = "■"
            } else if currentCells[x][y] == " " && total == 3 {
                newCells[x][y] = "■"
            } else {
                newCells[x][y] = " "
            }
        }
    }
    
    nextCells = newCells
    sleep(1)
}

