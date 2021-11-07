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
    
    var isDuece = false
    
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
    
    @IBAction func alphaMinusButtonAction() {
        if alphaScore > 0 {
            alphaScore -= 1
            alphaScoreButton.setTitle(String(alphaScore))
            statusHandler()
        }
    }
    
    @IBAction func betaMinusButtonAction() {
        if betaScore > 0 {
            betaScore -= 1
            betaScoreButton.setTitle(String(betaScore))
            statusHandler()
        }
    }
    
    @IBAction func eraserButton() {
        resetAll()
    }
   
    private func statusHandler() {

        // 点差の絶対値
        let diff: Int = abs(alphaScore - betaScore)
                
        // デュース判定
        if alphaScore >= 10 && betaScore >= 10 && diff == 0 {
            matchStatusLabel.setText("Deuce!🔥")
            alphaScoreButton.setBackgroundColor(UIColor.brown)
            betaScoreButton.setBackgroundColor(UIColor.purple)
            isDuece = true
            
        } else if alphaScore > betaScore && diff == 2 && isDuece {
            alphaWin()
        } else if betaScore > alphaScore && diff == 2 && isDuece {
            betaWin()
        } else if alphaScore == 11 && !isDuece {
            alphaWin()
        } else if betaScore == 11 && !isDuece {
            betaWin()
        } else if alphaScore == 10 && !isDuece || betaScore == 10 && !isDuece || isDuece && diff == 1 {
            matchStatusLabel.setText("Match Point!💥")
        } else {
            matchStatusLabel.setText("🏓")
        }
    }
    
    private func alphaWin() {
        alphaPoint += 1
        alphaPointLabel.setText(String(alphaPoint))
        resetScore()
    }
    
    private func betaWin() {
        betaPoint += 1
        betaPointLabel.setText(String(betaPoint))
        resetScore()
    }
    
    private func resetScore() {
        
        isDuece = false
        matchStatusLabel.setText("🏓")
        
        alphaScore = 0
        alphaScoreButton.setTitle(String(alphaScore))
        
        betaScore = 0
        betaScoreButton.setTitle(String(betaScore))
        
        alphaScoreButton.setBackgroundColor(.orange)
        betaScoreButton.setBackgroundColor(.blue)
    }
    
    private func resetAll() {
        
        resetScore()
        
        alphaPoint = 0
        alphaPointLabel
            .setText(String(alphaPoint))
        
        betaPoint = 0
        betaPointLabel.setText(String(betaPoint))
    }
}
