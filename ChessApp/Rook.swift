//
//  Rook.swift
//  ChessApp
//
//  Copyright © 2020 Simon Lee. All rights reserved.
//

import UIKit
import Foundation

class Rook: Piece {
    
    init(_ row: Int, _ col: Int, _ team: Team, _ image: UIImageView) {
        super.init("Rook", 5, row, col, team, image)
        self.image.isUserInteractionEnabled = true;
        if(team == .White) {
            self.image.image = UIImage(named: "WRook")
        }
        else if(team == .Black) {
            self.image.image = UIImage(named: "BRook")
        }
    }
    
    override func validMove(_ row: Int, _ col: Int, _ board: [[Piece]]) -> Bool {
        if(col == self.col) {
            if(row > self.row) {
                var hit = false
                for r in (self.row + 1)...row {
                    if !(board[r][col] is BlankSpace) {
                        if(board[r][col].team == self.team) {
                            return false
                        }
                        else if(hit) {
                            return false
                        }
                        else if(board[r][col].team != self.team ) {
                            hit = true
                        }
                    }
                }
            }
            else if(row < self.row) {
                var hit = false
                for r in row...(self.row - 1) {
                    if !(board[r][col] is BlankSpace) {
                        if(board[r][col].team == self.team) {
                            return false
                        }
                        else if(hit) {
                            return false
                        }
                        else if(board[r][col].team != self.team ) {
                            hit = true
                        }
                    }
                }
            }
        }
        else if(row == self.row) {
            if(col > self.col) {
                var hit = false
                for c in (self.col + 1)...col {
                    if !(board[row][c] is BlankSpace) {
                        if(board[row][c].team == self.team) {
                            return false
                        }
                        else if(hit) {
                            return false
                        }
                        else if(board[row][c].team != self.team ) {
                            hit = true
                        }
                    }
                }
            }
            else if(col < self.col) {
                var hit = false
                for c in col...(self.col - 1) {
                    if !(board[row][c] is BlankSpace) {
                        if(board[row][c].team == self.team) {
                            return false
                        }
                        else if(hit) {
                            return false
                        }
                        else if(board[row][c].team != self.team ) {
                            hit = true
                        }
                    }
                }
            }
        }
        else {
            return false
        }
        return true
    }
}
