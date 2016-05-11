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
    
    var rpn = false;
    
    var op = ""
    var num = ""
    var numArr = [Double]()
    var newEq = true

    @IBOutlet weak var ans: UILabel!
    
    @IBAction func toggleRPN(sender: UIButton) {
        rpn = !rpn
        op = ""
        num = ""
        numArr.removeAll()
        newEq = true
        if rpn {
            ans.text = "RPN is on"
        } else {
            ans.text = "RPN is off"
        }
    }
    
    @IBAction func enterNumber(sender: UIButton) {
        if rpn {
            if num != "" {
                numArr.append(Double(num)!)
                ans.text = num + " entered"
                num = ""
            }
            
        } else {
            ans.text = "ERROR: RPN is off"
        }
    }

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
            if num != "" {
                numArr.append(Double(num)!)
            }
            num = ""
            ans.text = sender.currentTitle!
            op = sender.currentTitle!
        }
        
        if rpn {
            eq(sender)
        }
    }
    
    @IBAction func eq(sender: UIButton) {
        if num != "" {
            numArr.append(Double(num)!)
        }
        if sender.currentTitle == "fact" {
            if numArr.count > 1 {
                ans.text = "ERROR: fact only accepts one number"
            } else if numArr[0] > 20 {
                ans.text = "ERROR: answer too large"
            } else {
                var out = 1.0
                var i = numArr[0]
                while i > 1 {
                    out = out * i
                    i -= 1
                }
                ans.text = "\(out)"
            }
        } else {
            switch op {
            case "+":
                if numArr.count != 2 {
                    ans.text = "ERROR: (+) operator takes 2 numbers"
                } else {
                    ans.text = "\(numArr[0] + numArr[1])"
                }
            case "-":
                if numArr.count != 2 {
                    ans.text = "ERROR: (-) operator takes 2 numbers"
                } else {
                    ans.text = "\(numArr[0] - numArr[1])"
                }
            case "*":
                if numArr.count != 2 {
                    ans.text = "ERROR: (*) operator takes 2 numbers"
                } else {
                    ans.text = "\(numArr[0] * numArr[1])"
                }
            case "/":
                if numArr.count != 2 {
                    ans.text = "ERROR: (/) operator takes 2 numbers"
                } else {
                    ans.text = "\(numArr[0] / numArr[1])"
                }
            case "%":
                if numArr.count != 2 {
                    ans.text = "ERROR: (%) operator takes 2 numbers"
                } else {
                    ans.text = "\(numArr[0] % numArr[1])"
                }
            case "count":
                ans.text = "\(numArr.count)"
            case "avg":
                ans.text = "\(numArr.reduce(0, combine: +)/(Double(numArr.count)))"
            default:
                ans.text = "error"
            }
        }
        newEq = true
        num = ans.text!
        op = ""
        numArr.removeAll()
    }
    
    @IBAction func clearButton(sender: UIButton) {
        op = ""
        num = ""
        numArr.removeAll()
        newEq = true
        ans.text = "0"
    }
}

