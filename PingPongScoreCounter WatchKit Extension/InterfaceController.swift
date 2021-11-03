//
//  InterfaceController.swift
//  PingPongScoreCounter WatchKit Extension
//
//  Created by Takuya Ando on 2021/11/01.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var matchStatusLabel: WKInterfaceLabel!
    @IBOutlet weak var alphaPoint: WKInterfaceLabel!
    @IBOutlet weak var betaPoint: WKInterfaceLabel!
    @IBOutlet weak var alphaScoreButton: WKInterfaceButton!
    @IBOutlet weak var betaScoreButton: WKInterfaceButton!
    
    var alphaScore: Int = 0
    var betaScore: Int = 0
    
    override func awake(withContext context: Any?) {
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

    @IBAction func alphaScoreButtonAction() {
        alphaScore += 1
        alphaScoreButton.setTitle(String(alphaScore))
        statusHandler()
    }
    
    @IBAction func betaScoreButtonAction() {
        betaScore += 1
        betaScoreButton.setTitle(String(betaScore))
        statusHandler()
    }
    
    @IBAction func eraserButton() {
    }
    
    @IBAction func undoButton() {
    }
   
    private func statusHandler() {
        // デュース判定
        if alphaScore == 10 && betaScore == 10 {
            matchStatusLabel.setText("Deuce!🔥")
            matchStatusLabel.setTextColor(UIColor.red)
            alphaScoreButton.setBackgroundColor(UIColor.brown)
            betaScoreButton.setBackgroundColor(UIColor.purple)
        }
    }
}
