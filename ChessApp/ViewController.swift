//
//  ViewController.swift
//  ChessApp
//
//  Copyright © 2020 Simon Lee. All rights reserved.
//

import UIKit

var chessGame: Game = Game()

class ViewController: UIViewController {
    
    // Resign buttons
    @IBOutlet weak var WResign: UIButton!
    @IBOutlet weak var BResign: UIButton!
    
    // Start buttons
    @IBOutlet weak var WStart: UIButton!
    @IBOutlet weak var BStart: UIButton!
    
    // Turn labels
    @IBOutlet weak var WTurn: UILabel!
    @IBOutlet weak var BTurn: UILabel!
    
    // Score labels
    @IBOutlet weak var WScore: UILabel!
    @IBOutlet weak var BScore: UILabel!
    
    // Board grid imageviews
    @IBOutlet weak var board00: UIImageView!
    @IBOutlet weak var board01: UIImageView!
    @IBOutlet weak var board02: UIImageView!
    @IBOutlet weak var board03: UIImageView!
    @IBOutlet weak var board04: UIImageView!
    @IBOutlet weak var board05: UIImageView!
    @IBOutlet weak var board06: UIImageView!
    @IBOutlet weak var board07: UIImageView!
    @IBOutlet weak var board10: UIImageView!
    @IBOutlet weak var board11: UIImageView!
    @IBOutlet weak var board12: UIImageView!
    @IBOutlet weak var board13: UIImageView!
    @IBOutlet weak var board14: UIImageView!
    @IBOutlet weak var board15: UIImageView!
    @IBOutlet weak var board16: UIImageView!
    @IBOutlet weak var board17: UIImageView!
    @IBOutlet weak var board20: UIImageView!
    @IBOutlet weak var board21: UIImageView!
    @IBOutlet weak var board22: UIImageView!
    @IBOutlet weak var board23: UIImageView!
    @IBOutlet weak var board24: UIImageView!
    @IBOutlet weak var board25: UIImageView!
    @IBOutlet weak var board26: UIImageView!
    @IBOutlet weak var board27: UIImageView!
    @IBOutlet weak var board30: UIImageView!
    @IBOutlet weak var board31: UIImageView!
    @IBOutlet weak var board32: UIImageView!
    @IBOutlet weak var board33: UIImageView!
    @IBOutlet weak var board34: UIImageView!
    @IBOutlet weak var board35: UIImageView!
    @IBOutlet weak var board36: UIImageView!
    @IBOutlet weak var board37: UIImageView!
    @IBOutlet weak var board40: UIImageView!
    @IBOutlet weak var board41: UIImageView!
    @IBOutlet weak var board42: UIImageView!
    @IBOutlet weak var board43: UIImageView!
    @IBOutlet weak var board44: UIImageView!
    @IBOutlet weak var board45: UIImageView!
    @IBOutlet weak var board46: UIImageView!
    @IBOutlet weak var board47: UIImageView!
    @IBOutlet weak var board50: UIImageView!
    @IBOutlet weak var board51: UIImageView!
    @IBOutlet weak var board52: UIImageView!
    @IBOutlet weak var board53: UIImageView!
    @IBOutlet weak var board54: UIImageView!
    @IBOutlet weak var board55: UIImageView!
    @IBOutlet weak var board56: UIImageView!
    @IBOutlet weak var board57: UIImageView!
    @IBOutlet weak var board60: UIImageView!
    @IBOutlet weak var board61: UIImageView!
    @IBOutlet weak var board62: UIImageView!
    @IBOutlet weak var board63: UIImageView!
    @IBOutlet weak var board64: UIImageView!
    @IBOutlet weak var board65: UIImageView!
    @IBOutlet weak var board66: UIImageView!
    @IBOutlet weak var board67: UIImageView!
    @IBOutlet weak var board70: UIImageView!
    @IBOutlet weak var board71: UIImageView!
    @IBOutlet weak var board72: UIImageView!
    @IBOutlet weak var board73: UIImageView!
    @IBOutlet weak var board74: UIImageView!
    @IBOutlet weak var board75: UIImageView!
    @IBOutlet weak var board76: UIImageView!
    @IBOutlet weak var board77: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let imageArray:[[UIImageView]] =
                            [[board00, board01, board02, board03, board04, board05, board06, board07],
                             [board10, board11, board12, board13, board14, board15, board16, board17],
                             [board20, board21, board22, board23, board24, board25, board26, board27],
                             [board30, board31, board32, board33, board34, board35, board36, board37],
                             [board40, board41, board42, board43, board44, board45, board46, board47],
                             [board50, board51, board52, board53, board54, board55, board56, board57],
                             [board60, board61, board62, board63, board64, board65, board66, board67],
                             [board70, board71, board72, board73, board74, board75, board76, board77]]

        for row in imageArray {
            for image in row {
                let gesture = UITapGestureRecognizer(target: self, action: #selector(pieceTapped(_:)))
                gesture.numberOfTapsRequired = 1
                image.addGestureRecognizer(gesture)
            }
        }
        
        WTurn.isHidden = true
        BTurn.isHidden = true
        WScore.isHidden = true
        BScore.isHidden = true
        BResign.isHidden = true
        WResign.isHidden = true
    }
    
    @objc func pieceTapped(_ gesture:UITapGestureRecognizer) {
        let imageArray:[[UIImageView]] =
        [[board00, board01, board02, board03, board04, board05, board06, board07],
         [board10, board11, board12, board13, board14, board15, board16, board17],
         [board20, board21, board22, board23, board24, board25, board26, board27],
         [board30, board31, board32, board33, board34, board35, board36, board37],
         [board40, board41, board42, board43, board44, board45, board46, board47],
         [board50, board51, board52, board53, board54, board55, board56, board57],
         [board60, board61, board62, board63, board64, board65, board66, board67],
         [board70, board71, board72, board73, board74, board75, board76, board77]]

        let imageView = gesture.view
        for r in 0...7 {
            for c in 0...7 {
                if(imageView == imageArray[r][c]) {
                    chessGame.gameBoard.pieceTapRC(r, c)
                    return
                }
            }
        }
    }
    
    @IBAction func whiteStart(_ sender: Any) {
        BResign.isHidden = true;
        WResign.isHidden = false;
        WStart.isHidden = true;
        BStart.isHidden = true;
        let imageArray: [[UIImageView]] =
            [[board00, board01, board02, board03, board04, board05, board06, board07],
             [board10, board11, board12, board13, board14, board15, board16, board17],
             [board20, board21, board22, board23, board24, board25, board26, board27],
             [board30, board31, board32, board33, board34, board35, board36, board37],
             [board40, board41, board42, board43, board44, board45, board46, board47],
             [board50, board51, board52, board53, board54, board55, board56, board57],
             [board60, board61, board62, board63, board64, board65, board66, board67],
             [board70, board71, board72, board73, board74, board75, board76, board77]]
        
        WTurn.text = "White's Turn"
        BTurn.text = ""
        WTurn.isHidden = false
        BTurn.isHidden = false
        WScore.isHidden = false
        BScore.isHidden = false
        chessGame.startGame(.White, imageArray, WResign, BResign, WTurn, BTurn, WScore, BScore, WStart, BStart)
    }
    
    @IBAction func blackStart(_ sender: Any) {
        BResign.isHidden = false;
        WResign.isHidden = true;
        WStart.isHidden = true;
        BStart.isHidden = true;
        let imageArray: [[UIImageView]] =
            [[board00, board01, board02, board03, board04, board05, board06, board07],
             [board10, board11, board12, board13, board14, board15, board16, board17],
             [board20, board21, board22, board23, board24, board25, board26, board27],
             [board30, board31, board32, board33, board34, board35, board36, board37],
             [board40, board41, board42, board43, board44, board45, board46, board47],
             [board50, board51, board52, board53, board54, board55, board56, board57],
             [board60, board61, board62, board63, board64, board65, board66, board67],
             [board70, board71, board72, board73, board74, board75, board76, board77]]
        
        BTurn.text = "Black's Turn"
        WTurn.text = ""
        WTurn.isHidden = false
        BTurn.isHidden = false
        WScore.isHidden = false
        BScore.isHidden = false
        chessGame.startGame(.Black, imageArray, WResign, BResign, WTurn, BTurn, WScore, BScore, WStart, BStart)
    }
    
    @IBAction func WResignTap(_ sender: Any) {
        print("White resigned.")
        print("Black wins!")
        BResign.isHidden = true;
        WResign.isHidden = true;
        WStart.isHidden = false;
        BStart.isHidden = false;
        for row in chessGame.gameBoard.pieces {
            for p in row {
                p.image.isUserInteractionEnabled = false
            }
        }
    }
    @IBAction func BResignTap(_ sender: Any) {
        print("Black resigned.")
        print("White wins!")
        BResign.isHidden = true;
        WResign.isHidden = true;
        WStart.isHidden = false;
        BStart.isHidden = false;
        for row in chessGame.gameBoard.pieces {
            for p in row {
                p.image.isUserInteractionEnabled = false
            }
        }
    }
}

