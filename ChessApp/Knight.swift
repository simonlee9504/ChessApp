//
//  Knight.swift
//  ChessApp
//
//  Copyright © 2020 Simon Lee. All rights reserved.
//

import UIKit
import Foundation

class Knight: Piece {
    init(_ row: Int, _ col: Int, _ team: Team, _ image: UIImageView) {
        super.init("Knight", 3, row, col, team, image)
        self.image.isUserInteractionEnabled = true;
        if(team == .White) {
            self.image.image = UIImage(named: "WKnight")
        }
        else if(team == .Black) {
            self.image.image = UIImage(named: "BKnight")
        }
    }
    
    override func validMove(_ row: Int, _ col: Int, _ board: [[Piece]]) -> Bool {
        if(board[row][col].team == self.team) {
            return false
        }
        
        if(row == self.row + 2 || row == self.row - 2) {
            if(col == self.col + 1 || col == self.col - 1) {
                return true
            }
        }
        else if(row == self.row + 1 || row == self.row - 1) {
            if(col == self.col + 2 || col == self.col - 2) {
                return true
            }
        }
        return false
    }
}
