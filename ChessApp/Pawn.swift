//
//  Pawn.swift
//  ChessApp
//
//  Copyright © 2020 Simon Lee. All rights reserved.
//

import UIKit
import Foundation

class Pawn: Piece {
    init(_ row: Int, _ col: Int, _ team: Team, _ image: UIImageView) {
        super.init("Pawn", 1, row, col, team, image)
        self.image.isUserInteractionEnabled = true;
        if(team == .White) {
            self.image.image = UIImage(named: "WPawn")
        }
        else if(team == .Black) {
            self.image.image = UIImage(named: "BPawn")
        }
    }
    
    override func validMove(_ row: Int, _ col: Int, _ board: [[Piece]]) -> Bool {
        if(col != self.col) {
            if(self.team == .White && row == self.row - 1 && (col == self.col - 1 || col == self.col + 1)) {
                if(board[row][col] is BlankSpace) {
                    return false
                }
                if(board[row][col].team == self.team) {
                    return false
                }
                return true
            }
            if(self.team == .Black && row == self.row + 1 && (col == self.col - 1 || col == self.col + 1)) {
                if(board[row][col] is BlankSpace) {
                    return false
                }
                if(board[row][col].team == self.team) {
                    return false
                }
                return true
            }
            else {
                return false
            }
        }
        
        var numSpaces = 1
        if(self.team == .White && self.row == 6) {
            numSpaces = 2
        }
        else if(self.team == .Black && self.row == 1) {
            numSpaces = 2
        }
        
        if(self.team == .White && row < self.row && row >= self.row - numSpaces) {
            for r in row...(self.row - 1) {
                if !(board[r][col] is BlankSpace) {
                    return false
                }
            }
        }
        else if(self.team == .Black && row > self.row && row <= self.row + numSpaces) {
            for r in (self.row + 1)...row {
                if !(board[r][col] is BlankSpace) {
                    return false
                }
            }
        }
        else {
            return false
        }
        return true
    }
}
