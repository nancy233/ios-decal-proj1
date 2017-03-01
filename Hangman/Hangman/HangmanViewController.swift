//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    var hangmanPhrases = HangmanPhrases()
    
    var copyPhrase:String?
    
    @IBOutlet var letterButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Generate a random phrase for the user to guess
        hangmanPhrases = HangmanPhrases()
        let phrase: String = hangmanPhrases.getRandomPhrase()
        copyPhrase = phrase
        for index in 1 ... phrase.characters.count-1{
            if (phrase.substring(atIndex:index)==" "){
                hangmanPhrases.status += " "
            }else{
                hangmanPhrases.status += "_"
            }
        }
        phraseStatus.text = hangmanPhrases.status
        print(phrase)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var phraseStatus: UILabel!
    @IBOutlet weak var incorrect: UILabel!
    
    @IBAction func guess(_ sender: UIButton) {
        if (hangmanPhrases.youWon || hangmanPhrases.youLost){
        }else{
            hangmanPhrases.update(buttonTitle: sender.currentTitle!, phrase: copyPhrase!)
            phraseStatus.text = hangmanPhrases.status
            incorrect.text = hangmanPhrases.guessed
            sender.setTitleColor(UIColor.red, for: .normal)
            sender.isEnabled = false
        
        
        
            // wrong guess?
            if (!hangmanPhrases.correct){
                if (hangmanImage.image == UIImage(named: "hangman1")){
                    hangmanImage.image = UIImage(named: "hangman2")
                }else if(hangmanImage.image == UIImage(named: "hangman2")){
                    hangmanImage.image = UIImage(named: "hangman3")
                }else if(hangmanImage.image == UIImage(named: "hangman3")){
                    hangmanImage.image = UIImage(named: "hangman4")
                }else if(hangmanImage.image == UIImage(named: "hangman4")){
                    hangmanImage.image = UIImage(named: "hangman5")
                }else if(hangmanImage.image == UIImage(named: "hangman5")){
                    hangmanImage.image = UIImage(named: "hangman6")
                }else if(hangmanImage.image == UIImage(named: "hangman6")){
                    hangmanImage.image = UIImage(named: "hangman7")
                
                    hangmanPhrases.youLost = true
                    // alert Lose
                    let alert = UIAlertController(title: "Lost", message: "Sorry, you lost.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                
                }
            }else{
                // won the game
                if (hangmanPhrases.Won(phrase: copyPhrase!)){
                    hangmanPhrases.youWon = true
                    // alert Won
                    let alert = UIAlertController(title: "Won", message: "Yay! You won!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                
                }
            }
        }
    }
    
    @IBAction func restart(_ sender: UIButton) {
        hangmanPhrases = HangmanPhrases()
        viewDidLoad()
        for button in letterButtons as [UIButton]{
            button.setTitleColor(UIColor.blue, for: .normal)
            button.isEnabled = true
        }
        hangmanImage.image = UIImage(named: "hangman1")
        
    }

}
