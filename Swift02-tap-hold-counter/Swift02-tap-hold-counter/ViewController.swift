//
//  ViewController.swift
//  Swift02-tap-hold-counter
//
//  Created by shinwood on 5/1/16.
//  Copyright © 2016 guox.in. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var buttonAddCount: UIButton!

    let formatter = NSNumberFormatter()
    var theCounter: Int = 0
    let tapSelector = #selector(tapAddCount(_:))
    let longPressSelector = #selector(longPressAddCount(_:))
    var timer:NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: tapSelector)
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: longPressSelector)
        
        tapGestureRecognizer.numberOfTapsRequired = 1
        longPressGestureRecognizer.numberOfTouchesRequired = 1
        
        buttonAddCount.addGestureRecognizer(tapGestureRecognizer)
        buttonAddCount.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @IBAction func clearCount(sender: UIButton) {
        count.text = "0"
        theCounter = 0
    }
    
    func tapAddCount(gesture: UITapGestureRecognizer){
        theCounter = formatter.numberFromString(count.text!)!.integerValue + 1
        count.text = "\(theCounter)"
    }
    
    func longPressAddCount(gesture: UILongPressGestureRecognizer){
        switch gesture.state {
            case .Began:
                timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector: #selector(tapAddCount), userInfo:nil, repeats: true)
            case .Changed:
                theCounter = formatter.numberFromString(count.text!)!.integerValue + 1
                count.text = "\(theCounter)"
            case .Ended:
                timer.invalidate()
            default: break
        }
    }
}

