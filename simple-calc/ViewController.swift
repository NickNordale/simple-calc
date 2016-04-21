//
//  ViewController.swift
//  simple-calc
//
//  Created by Nick Nordale on 4/20/16.
//  Copyright © 2016 Nick Nordale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var op = ""
    var num = ""
    var intArr = [Int]()
    var newEq = true

    @IBOutlet weak var ans: UILabel!

    @IBAction func numberButton(sender: UIButton) {
        if newEq {
            num = ""
            newEq = false
        }
        num += sender.currentTitle!
        ans.text = num
    }
    
    @IBAction func operatorButton(sender: UIButton) {
        if op != "" && op != sender.currentTitle! {
            ans.text = "ERROR: mismatch operations"
        } else {
            intArr.append(Int(num)!)
            num = ""
            ans.text = sender.currentTitle!
            op = sender.currentTitle!
        }
    }
    
    @IBAction func eq(sender: UIButton) {
        if num != "" {
            intArr.append(Int(num)!)
        }
        if sender.currentTitle == "fact" {
            if intArr.count > 1 {
                ans.text = "ERROR: fact only accepts one number"
            } else if intArr[0] > 20 {
                ans.text = "ERROR: answer too large"
            } else {
                var out = 1
                var i = intArr[0]
                while i > 1 {
                    out = out * i
                    i -= 1
                }
                ans.text = "\(out)"
            }
        } else {
            switch op {
            case "+":
                ans.text = "\(intArr[0] + intArr[1])"
            case "-":
                ans.text = "\(intArr[0] - intArr[1])"
            case "*":
                ans.text = "\(intArr[0] * intArr[1])"
            case "/":
                ans.text = "\(intArr[0] / intArr[1])"
            case "%":
                ans.text = "\(intArr[0] % intArr[1])"
            case "count":
                ans.text = "\(intArr.count)"
            case "avg":
                ans.text = "\(intArr.reduce(0, combine: +)/intArr.count)"
            default:
                ans.text = "error"
            }
        }
        newEq = true
        num = ans.text!
        op = ""
        intArr.removeAll()
    }
    
    @IBAction func clearButton(sender: UIButton) {
        op = ""
        num = ""
        intArr.removeAll()
        newEq = true
        ans.text = "0"
    }
}

