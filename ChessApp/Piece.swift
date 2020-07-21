//
//  Piece.swift
//  ChessApp
//
//  Copyright © 2020 Simon Lee. All rights reserved.
//

import UIKit
import Foundation

class Piece {
    var name: String
    var team: Team
    var value: Int
    var row: Int
    var col: Int
    var image: UIImageView
    
    init(_ name: String, _ value: Int, _ row: Int, _ col: Int, _ team: Team, _ image: UIImageView) {
        self.name = name
        self.value = value
        self.row = row
        self.col = col
        self.team = team
        self.image = image
    }
    
    func validMove(_ row: Int, _ col: Int, _ board: [[Piece]]) -> Bool {
        print("error: tried to move a piece of no type")
        return false
    }
    
    func amIChecked(_ row: Int, _ col: Int, _ board: [[Piece]]) -> Bool {
        return false
    }
    
    func checkPiece() {
        // do nothing
    }
    
    func uncheckPiece() {
        // do nothing
    }
}
