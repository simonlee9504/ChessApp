//
//  Game.swift
//  ChessApp
//
//  Copyright © 2020 Simon Lee. All rights reserved.
//

import UIKit
import Foundation

enum Team: String {
    case White
    case Black
    case Neither
}

class Game {
    var gameBoard: Board
    
    init() {
        gameBoard = Board()
    }
    
    func startGame(_ startingPlayer: Team, _ imageArray: [[UIImageView]], _ WResign: UIButton, _ BResign: UIButton, _ WTurn: UILabel, _ BTurn: UILabel, _ WScore: UILabel, _ BScore: UILabel, _ WStart: UIButton, _ BStart: UIButton) {
        gameBoard = Board(startingPlayer, imageArray, WResign, BResign, WTurn, BTurn, WScore, BScore, WStart, BStart)
    }
    
}

