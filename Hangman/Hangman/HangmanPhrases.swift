//
//  HangmanPhrases.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import Foundation

class HangmanPhrases {
    
    var phrases : NSArray!
    var status: String = "_"
    var guessed: String = "Incorrect Guesses: "
    var correct: Bool = true
    var youWon: Bool = false
    var youLost: Bool = false
    
    // Initialize HangmanPhrase with an array of all possible phrases of the Hangman game
    init() {
        let path = Bundle.main.path(forResource: "phrases", ofType: "plist")
        phrases = NSArray.init(contentsOfFile: path!)
    }
    
    // Get random phrase from all available phrases
    func getRandomPhrase() -> String {
        let index = Int(arc4random_uniform(UInt32(phrases.count)))
        return phrases.object(at: index) as! String
    }
    
    func update(buttonTitle:String, phrase:String){
        let old:String = status
        if (phrase.contains(buttonTitle)){
            correct = true
            for index in 0...phrase.characters.count-1{
                if (phrase.substring(atIndex: index)==buttonTitle){
                    if (index==0){
                        status = buttonTitle
                    }else{status += buttonTitle}
                }else if (old.substring(atIndex:index)=="_"){
                    if (index==0){
                        status = "_"
                    }else{status += "_"}
                }else{
                    if (index==0){
                        status = old.substring(atIndex:index)
                    }else{status += old.substring(atIndex:index)}
                }
            }
        }else{
            correct = false
            guessed += buttonTitle
        }
    }
    
    func Won(phrase: String) -> Bool{
        for index in 0...phrase.characters.count{
            if (phrase.substring(atIndex: index) != status.substring(atIndex: index)){
                return false
            }
        }
        return true
    }
    
}
