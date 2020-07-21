//
//  Queen.swift
//  ChessApp
//
//  Copyright © 2020 Simon Lee. All rights reserved.
//

import UIKit
import Foundation

class Queen: Piece {
    init(_ row: Int, _ col: Int, _ team: Team, _ image: UIImageView) {
        super.init("Queen", 9, row, col, team, image)
        self.image.isUserInteractionEnabled = true;
        if(team == .White) {
            self.image.image = UIImage(named: "WQueen")
        }
        else if(team == .Black) {
            self.image.image = UIImage(named: "BQueen")
        }
    }
    
    override func validMove(_ row: Int, _ col: Int, _ board: [[Piece]]) -> Bool {
        if(col != self.col && row != self.row) {
            var hit = false
            var found = false
            for i in 1...7 {
                if(i <= abs(self.row-row)) {
                    if(i <= abs(self.col-col)) {
                        var p: Piece = board[0][0] // temp
                        var testRow: Int = 0 // temp
                        var testCol: Int = 0 // temp
                        if(row > self.row) {
                            if(col > self.col) {
                                p = board[self.row+i][self.col+i]
                                testRow = self.row+i
                                testCol = self.col+i
                            }
                            else if(col < self.col) {
                                p = board[self.row+i][self.col-i]
                                testRow = self.row+i
                                testCol = self.col-i
                            }
                        }
                        else if(row < self.row) {
                            if(col > self.col) {
                                p = board[self.row-i][self.col+i]
                                testRow = self.row-i
                                testCol = self.col+i
                            }
                            else if(col < self.col) {
                                p = board[self.row-i][self.col-i]
                                testRow = self.row-i
                                testCol = self.col-i
                            }
                        }
                        if !(p is BlankSpace) {
                            if(p.team == self.team) {
                                return false
                            }
                            else if(hit) {
                                return false
                            }
                            else if(p.team != self.team ) {
                                hit = true
                            }
                        }
                        if(row == testRow && col == testCol) {
                            found = true
                        }
                    }
                }
            }
            if(!found) {
                return false
            }
            return true
        }
        
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
