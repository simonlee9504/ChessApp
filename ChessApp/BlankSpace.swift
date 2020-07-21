//
//  BlankSpace.swift
//  ChessApp
//
//  Copyright © 2020 Simon Lee. All rights reserved.
//

import UIKit
import Foundation

class BlankSpace: Piece {
    init(_ xPos: Int, _ yPos: Int, _ image: UIImageView) {
        super.init("Blank Space", 0, xPos, yPos, .Neither, image)
        self.image.isUserInteractionEnabled = true;
        self.image.image = UIImage(named: "NullImage")
    }
    
    override func validMove(_ row: Int, _ col: Int, _ board: [[Piece]]) -> Bool {
        return false
    }
}
