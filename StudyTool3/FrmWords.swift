//
//  FrmWords.swift
//  StudyTool3
//
//  Created by 陈为 on 9/19/15.
//  Copyright © 2015 David Chen. All rights reserved.
//

import UIKit
import Parse
import AVFoundation

class FrmWords: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lbWord: UILabel!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lbStatus: UILabel!

    // MARK: - Vars & Lets
    struct word {
        var word: String = "", translation: String = ""
    }
    var wordlist: [word] = [], word_count: Int = 0, cur_word: Int = 0
    let synth = AVSpeechSynthesizer()
    var speechUtterance = AVSpeechUtterance(string: "")
    
    
    // MARK: - Functions
    func read (str: String) {
        speechUtterance = AVSpeechUtterance(string: str)
        speechUtterance.rate = 0.4
        speechUtterance.pitchMultiplier = 0.25
        speechUtterance.volume = 0.75
        
        synth.speakUtterance(speechUtterance)
    }
    
    func refresh_state () {
        word_count = wordlist.count
        btnPrev.enabled = (cur_word > 0)
        btnNext.enabled = (cur_word < word_count - 1)
        do {
            try! lbWord.text = wordlist[cur_word].word
        } catch {
            
        }
        lbStatus.text = "\(cur_word + 1) / \(word_count)"
        read(lbWord.text!)
    }
    // MARK: - Actions
    @IBAction func btnPrevTapped(sender: AnyObject) {
        --cur_word
        refresh_state()
    }
    @IBAction func btnNextTapped(sender: AnyObject) {
        ++cur_word
        refresh_state()
    }
    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        let query = PFQuery(className: "words").whereKey("group", equalTo: self.title!).whereKey("username", equalTo: me.username)
        do {
            let objects = try! query.findObjects()
            self.wordlist.removeAll()
            for object in objects {
                var new_word = word()
                new_word.word = object["word"] as! String
                new_word.translation = object["translation"] as! String
                wordlist.append(new_word)
            }
            refresh_state()
        } catch let error as NSError {
            ShowAlertMessage(self, title: "Error!", message: String(error))
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
