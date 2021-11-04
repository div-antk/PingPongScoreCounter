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
    @IBOutlet weak var alphaPointLabel: WKInterfaceLabel!
    @IBOutlet weak var betaPointLabel: WKInterfaceLabel!
    @IBOutlet weak var alphaScoreButton: WKInterfaceButton!
    @IBOutlet weak var betaScoreButton: WKInterfaceButton!
    
    var alphaScore: Int = 0
    var betaScore: Int = 0
    
    var alphaPoint: Int = 0
    var betaPoint: Int = 0
    
    override func awake(withContext context: Any?) {
        resetScore()
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

        // 点差の絶対値
        let diff: Int = abs(alphaScore - betaScore)

        // デュース判定
        if alphaScore == 10 && betaScore == 10 {
            matchStatusLabel.setText("Deuce!🔥")
            matchStatusLabel.setTextColor(UIColor.red)
            alphaScoreButton.setBackgroundColor(UIColor.brown)
            betaScoreButton.setBackgroundColor(UIColor.purple)
        } else if alphaScore > 10 && diff == 2 {
            alphaPoint += 1
            alphaPointLabel.setText(String(alphaPoint))
            resetScore()
            
        } else if betaScore > 10 && diff == 2 {
            betaPoint += 1
            betaPointLabel.setText(String(betaPoint))
            resetScore()
        }
    }
    
    private func resetScore() {
        
        matchStatusLabel.setText("🏓")
        
        alphaScore = 0
        alphaScoreButton.setTitle(String(alphaScore))
        
        betaScore = 0
        betaScoreButton.setTitle(String(betaScore))
        
        alphaScoreButton.setBackgroundColor(.orange)
        betaScoreButton.setBackgroundColor(.blue)        
    }
}
