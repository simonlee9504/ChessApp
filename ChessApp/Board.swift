//
//  Board.swift
//  ChessApp
//
//  Copyright © 2020 Simon Lee. All rights reserved.
//

import UIKit
import Foundation

class HighlightedPiece {
    var row: Int
    var col: Int
    
    init(_ row: Int, _ col: Int) {
        self.row = row
        self.col = col
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

class Board {
    
    var pieces: [[Piece]]
    var hPiece: HighlightedPiece
    var currentPlayer: Team
    var WResign: UIButton
    var BResign: UIButton
    var WStart: UIButton
    var BStart: UIButton
    var WTurn: UILabel
    var BTurn: UILabel
    var WScore: UILabel
    var BScore: UILabel
    var WScoreInt: Int
    var BScoreInt: Int
    var kingChecked: Bool
    
    init() {
        pieces = []
        hPiece = HighlightedPiece(-1, -1)
        currentPlayer = .Neither
        WResign = UIButton()
        BResign = UIButton()
        WStart = UIButton()
        BStart = UIButton()
        WTurn = UILabel()
        BTurn = UILabel()
        WScore = UILabel()
        BScore = UILabel()
        WScoreInt = 0
        BScoreInt = 0
        kingChecked = false
    }
    
    init(_ startingPlayer: Team, _ imageArray: [[UIImageView]], _ WResign: UIButton, _ BResign: UIButton, _ WTurn: UILabel, _ BTurn: UILabel, _ WScore: UILabel, _ BScore: UILabel, _ WStart: UIButton, _ BStart: UIButton) {
        currentPlayer = startingPlayer
        self.WResign = WResign
        self.BResign = BResign
        self.WTurn = WTurn
        self.BTurn = BTurn
        self.WScore = WScore
        self.BScore = BScore
        self.WStart = WStart
        self.BStart = BStart
        WScoreInt = 0
        BScoreInt = 0
        kingChecked = false
        /*var otherPlayer = Team.Neither
        if(startingPlayer == .White) {
            otherPlayer = .Black
        }
        else if(startingPlayer == .Black) {
            otherPlayer = .White
        }*/
        pieces = []
        for r in 0...7 {
            pieces.append([])
            for c in 0...7 {
                switch(r, c) {
                    // team = otherPlayer but fixed sides for now
                case (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7):
                    pieces[r].append(Pawn(r, c, .Black, imageArray[r][c]))
                case (0, 0), (0, 7):
                    pieces[r].append(Rook(r, c, .Black, imageArray[r][c]))
                case (0, 1), (0, 6):
                    pieces[r].append(Knight(r, c, .Black, imageArray[r][c]))
                case (0, 2), (0, 5):
                    pieces[r].append(Bishop(r, c, .Black, imageArray[r][c]))
                case (0, 3):
                    pieces[r].append(Queen(r, c, .Black, imageArray[r][c]))
                case (0, 4):
                    pieces[r].append(King(r, c, .Black, imageArray[r][c]))
                    // team = startingPlayer but fixed sides for now
                case (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7):
                    pieces[r].append(Pawn(r, c, .White, imageArray[r][c]))
                case (7, 0), (7, 7):
                    pieces[r].append(Rook(r, c, .White, imageArray[r][c]))
                case (7, 1), (7, 6):
                    pieces[r].append(Knight(r, c, .White, imageArray[r][c]))
                case (7, 2), (7, 5):
                    pieces[r].append(Bishop(r, c, .White, imageArray[r][c]))
                case (7, 3):
                    pieces[r].append(Queen(r, c, .White, imageArray[r][c]))
                case (7, 4):
                    pieces[r].append(King(r, c, .White, imageArray[r][c]))
                default:
                    pieces[r].append(BlankSpace(r, c, imageArray[r][c]))
                }
            }
        }
        hPiece = HighlightedPiece(-1, -1)
    }
    
    func pieceTapRC(_ row: Int, _ col: Int) {
        if(hPiece.row == -1 || hPiece.col == -1) {
            if(pieces[row][col] is BlankSpace) {
                return
            }
            else if(currentPlayer != pieces[row][col].team) {
                return
            }
            else {
                hPiece = HighlightedPiece(row, col)
                highlightPiece(hPiece.row, hPiece.col)
            }
        }
        else if(hPiece.row == row && hPiece.col == col){
            unhighlightPiece(hPiece.row, hPiece.col)
            hPiece = HighlightedPiece(-1, -1)
        }
        else if(pieces[row][col].team == pieces[hPiece.row][hPiece.col].team) {
            unhighlightPiece(hPiece.row, hPiece.col)
            hPiece = HighlightedPiece(row, col)
            highlightPiece(hPiece.row, hPiece.col)
        }
        else {
            if(pieces[hPiece.row][hPiece.col].validMove(row, col, pieces)) {
                updateScore(move(row, col, hPiece.row, hPiece.col))
                unhighlightPiece(hPiece.row, hPiece.col)
                hPiece = HighlightedPiece(-1, -1)
                
                var kingAlive = false
                for r in pieces {
                    for p in r {
                        if(p is King && p.team != currentPlayer) {
                            if(p.amIChecked(p.row, p.col, pieces)) {
                                p.checkPiece()
                                kingChecked = true
                                kingAlive = true
                                break
                            }
                            else {
                                p.uncheckPiece()
                                kingChecked = false
                                kingAlive = true
                                break
                            }
                        }
                    }
                }
                if(!kingAlive) {
                    print("\(currentPlayer) wins!")
                    BResign.isHidden = true;
                    WResign.isHidden = true;
                    WStart.isHidden = false;
                    BStart.isHidden = false;
                    for r in pieces {
                        for p in r {
                            p.image.isUserInteractionEnabled = false
                        }
                    }
                }
                else if(currentPlayer == .White) {
                    BTurn.text = "Black's Turn"
                    WTurn.text = ""
                    
                    BResign.isHidden = false
                    WResign.isHidden = true
                    currentPlayer = .Black
                }
                else if(currentPlayer == .Black) {
                    WTurn.text = "White's Turn"
                    BTurn.text = ""
                    BResign.isHidden = true
                    WResign.isHidden = false
                    currentPlayer = .White
                }
            }
            else {
                unhighlightPiece(hPiece.row, hPiece.col)
                hPiece = HighlightedPiece(-1, -1)
            }
        }
    }
    
    func move(_ toRow: Int, _ toCol: Int, _ fromRow: Int, _ fromCol: Int) -> Int {
        let pieceValue = pieces[toRow][toCol].value
        
        var imageName = "NullImage"
        if(pieces[fromRow][fromCol].team == .White) {
            imageName = "W" + pieces[fromRow][fromCol].name
        }
        else if(pieces[fromRow][fromCol].team == .Black) {
            imageName = "B" + pieces[fromRow][fromCol].name
        }
        
        switch(pieces[fromRow][fromCol].name) {
        case "King":
            pieces[toRow][toCol] = King(toRow, toCol, pieces[fromRow][fromCol].team, pieces[toRow][toCol].image)
            pieces[toRow][toCol].image.image = UIImage(named: imageName)
        case "Queen":
            pieces[toRow][toCol] = Queen(toRow, toCol, pieces[fromRow][fromCol].team, pieces[toRow][toCol].image)
            pieces[toRow][toCol].image.image = UIImage(named: imageName)
        case "Pawn":
            pieces[toRow][toCol] = Pawn(toRow, toCol, pieces[fromRow][fromCol].team, pieces[toRow][toCol].image)
            pieces[toRow][toCol].image.image = UIImage(named: imageName)
        case "Bishop":
            pieces[toRow][toCol] = Bishop(toRow, toCol, pieces[fromRow][fromCol].team, pieces[toRow][toCol].image)
            pieces[toRow][toCol].image.image = UIImage(named: imageName)
        case "Knight":
            pieces[toRow][toCol] = Knight(toRow, toCol, pieces[fromRow][fromCol].team, pieces[toRow][toCol].image)
            pieces[toRow][toCol].image.image = UIImage(named: imageName)
        case "Rook":
            pieces[toRow][toCol] = Rook(toRow, toCol, pieces[fromRow][fromCol].team, pieces[toRow][toCol].image)
            pieces[toRow][toCol].image.image = UIImage(named: imageName)
        default:
            pieces[toRow][toCol] = BlankSpace(toRow, toCol, pieces[toRow][toCol].image)
            pieces[toRow][toCol].image.image = UIImage(named: imageName)
        }
        
        pieces[fromRow][fromCol] = BlankSpace(fromRow, fromCol, pieces[fromRow][fromCol].image)
        pieces[fromRow][fromCol].image.image = UIImage(named: "NullImage")
        
        return pieceValue
    }
    
    // updates score for appropriate team
    func updateScore(_ addScore: Int) {
        if(currentPlayer == .White) {
            WScoreInt += addScore
            WScore.text = "Score: \(WScoreInt)"
        }
        else if(currentPlayer == .Black) {
            BScoreInt += addScore
            BScore.text = "Score: \(BScoreInt)"
        }
    }
    
    // highlight piece
    func highlightPiece(_ row: Int, _ col: Int) {
        if(kingChecked && pieces[row][col] is King) {
            pieces[row][col].image.backgroundColor = UIColor(hex: "#c71c1cf0")
        }
        else {
            pieces[row][col].image.backgroundColor = UIColor(hex: "#296338f0");
        }
        for r in pieces {
            for p in r {
                if(pieces[row][col].validMove(p.row, p.col, pieces)) {
                    if(pieces[p.row][p.col].team != pieces[row][col].team && pieces[p.row][p.col].team != .Neither) {
                        p.image.backgroundColor = UIColor(hex: "#c71c1cf0")
                    }
                    else {
                        p.image.backgroundColor = UIColor(hex: "#296338f0");
                    }
                }
            }
        }
    }
    
    // unhighlight piece
    func unhighlightPiece(_ row: Int, _ col: Int) {
        if(kingChecked && pieces[row][col] is King) {
            pieces[row][col].image.backgroundColor = UIColor(hex: "#c71c1cf0")
        }
        else {
            pieces[row][col].image.backgroundColor = UIColor(white: 1, alpha: 0.0)
        }
        for r in pieces {
            for p in r {
                if(!(p.row == row && p.col == col)) {
                    p.image.backgroundColor = UIColor(white: 1, alpha: 0.0)
                }
            }
        }
    }
}
