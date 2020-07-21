//
//  King.swift
//  ChessApp
//
//  Copyright © 2020 Simon Lee. All rights reserved.
//

import UIKit
import Foundation

class King: Piece {
    var checked: Bool
    
    init(_ row: Int, _ col: Int, _ team: Team, _ image: UIImageView) {
        self.checked = false
        super.init("King", -1, row, col, team, image)
        self.image.isUserInteractionEnabled = true;
        if(team == .White) {
            self.image.image = UIImage(named: "WKing")
        }
        else if(team == .Black) {
            self.image.image = UIImage(named: "BKing")
        }
    }
    
    override func validMove(_ row: Int, _ col: Int, _ board: [[Piece]]) -> Bool {
        if(validMoveNoCheck(row, col, board)) {
            return !willBeChecked(row, col, board)
        }
        return false
    }
    
    // Checks if king can move without checking if it can be checked (to prevent stack overflow in king-vs-king situations)
    func validMoveNoCheck(_ row: Int, _ col: Int, _ board: [[Piece]]) -> Bool {
        if(row > self.row + 1 || row < self.row - 1) {
            return false
        }
        else if(col > self.col + 1 || col < self.col - 1) {
            return false
        }
        
        if(col != self.col) {
            if(board[row][col].team == self.team) {
                return false
            }
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
        return true
    }
    
    override func amIChecked(_ row: Int, _ col: Int, _ board: [[Piece]]) -> Bool {
        for r in board {
            for p in r {
                if(p.team != self.team) {
                    if(p is Pawn) {
                        if(col != p.col) {
                            if(p.team == .White && row == p.row - 1 && (col == p.col - 1 || col == p.col + 1)) {
                                self.checkPiece()
                                return true
                            }
                            if(p.team == .Black && row == p.row + 1 && (col == p.col - 1 || col == p.col + 1)) {
                                self.checkPiece()
                                return true
                            }
                        }
                    }
                    else if(p is King) {
                        let kingP: King = King(p.row, p.col, p.team, p.image)
                        if(kingP.validMoveNoCheck(row, col, board)) {
                            self.checkPiece()
                            return true
                        }
                    }
                    else if(p.validMove(row, col, board)) {
                        self.checkPiece()
                        return true
                    }
                }
            }
        }
        return false
    }

    
    func willBeChecked(_ row: Int, _ col: Int, _ board: [[Piece]]) -> Bool {
        for r in board {
            for p in r {
                if(p.team != self.team) {
                    if(p is Pawn) {
                        if(col != p.col) {
                            if(p.team == .White && row == p.row - 1 && (col == p.col - 1 || col == p.col + 1)) {
                                return true
                            }
                            if(p.team == .Black && row == p.row + 1 && (col == p.col - 1 || col == p.col + 1)) {
                                return true
                            }
                        }
                    }
                    else if(p is King) {
                        let kingP: King = King(p.row, p.col, p.team, p.image)
                        if(kingP.validMoveNoCheck(row, col, board)) {
                            return true
                        }
                    }
                    else if(p.validMove(row, col, board)) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    override func uncheckPiece() {
        self.image.backgroundColor = UIColor(white: 1, alpha: 0.0)
        checked = false
    }
    
    override func checkPiece() {
        self.image.backgroundColor = UIColor(hex: "#c71c1cf0")
        checked = true
    }
}
