//
//  InterfaceController.swift
//  PingPongScoreCounter WatchKit Extension
//
//  Created by Takuya Ando on 2021/11/01.
//

import WatchKit
import Foundation
import UIKit

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
    
    @IBAction func alphaScoreButtonAction() {
        alphaScore += 1
        alphaScoreButton.setTitle(String(alphaScore))
        statusHandler()
        WKInterfaceDevice.current().play(.directionUp)
    }
    
    @IBAction func betaScoreButtonAction() {
        betaScore += 1
        betaScoreButton.setTitle(String(betaScore))
        statusHandler()
        WKInterfaceDevice.current().play(.directionUp)
    }
    
    @IBAction func alphaMinusButtonAction() {
        if alphaScore > 0 {
            WKInterfaceDevice.current().play(.directionDown)
            alphaScore -= 1
            alphaScoreButton.setTitle(String(alphaScore))
            statusHandler()
            
            if alphaScore < 10 && betaScore == 10 {
                isDuece = false
                alphaScoreButton.setBackgroundColor(.brunaRed)
                betaScoreButton.setBackgroundColor(.brunaBlue)
            }
        }
    }
    
    @IBAction func betaMinusButtonAction() {
        if betaScore > 0 {
            WKInterfaceDevice.current().play(.directionDown)
            betaScore -= 1
            betaScoreButton.setTitle(String(betaScore))
            statusHandler()
            
            if betaScore < 10 && alphaScore == 10 {
                isDuece = false
                alphaScoreButton.setBackgroundColor(.brunaRed)
                betaScoreButton.setBackgroundColor(.brunaBlue)
            }
        }
    }
    
    @IBAction func eraserButton() {
        WKInterfaceDevice.current().play(.failure)
        resetAll()
    }
   
    private func statusHandler() {
                
        // 点差の絶対値
        let diff: Int = abs(alphaScore - betaScore)
        
        // デュース判定
        if alphaScore >= 10 && betaScore >= 10 && diff == 0 {
            matchStatusLabel.setText("Deuce!🔥")
            alphaScoreButton.setBackgroundColor(.deuceRed)
            betaScoreButton.setBackgroundColor(.deuceBlue)
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
        
        alphaScoreButton.setBackgroundColor(.brunaRed)
        betaScoreButton.setBackgroundColor(.brunaBlue)
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

extension UIColor {
    static let brunaRed = UIColor(red: 234/255, green: 84/255, blue: 21/255, alpha: 1)
    static let brunaBlue = UIColor(red: 0/255, green: 81/255, blue: 146/255, alpha: 1)
    
    static let deuceRed = UIColor(red: 234/255, green: 84/255, blue: 21/255, alpha: 0.5)
    static let deuceBlue = UIColor(red: 0/255, green: 81/255, blue: 146/255, alpha: 0.5)

}
