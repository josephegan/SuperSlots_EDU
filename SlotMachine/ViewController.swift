//
//  ViewController.swift
//  SlotMachine
//
//  Created by JoeE on 10/23/14.
//  Copyright (c) 2014 JoeE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var forthContainer: UIView!
    var titleLabel: UILabel!
    
    let kNumberOfContainers = 3
    let kNumberOfSlots = 3
    let kThird:CGFloat = 1.0/3.0
    let kMarginForSlots:CGFloat = 1.0
    
    let kMarginForView:CGFloat = 6.0
    let kSixth:CGFloat = 1.0/6.0
    
    
    let kHalf:CGFloat = 1.0/2.0
    let kEight:CGFloat = 1.0/8.0
    
    //Information Labels
    var creditLabel:UILabel!
    var betLabel:UILabel!
    var winnerPaidLabel:UILabel!
    var creditsTitleLabel:UILabel!
    var betTitleLabel:UILabel!
    var winnerPaidTitleLabel:UILabel!
    
    //Buttons in forth Container
    var resetButton:UIButton!
    var betOneButton:UIButton!
    var betMaxButton:UIButton!
    var spinButton:UIButton!

    var slots:[[Slot]] = []
    
    var credits = 0
    var currentBet = 0
    var winnings = 0;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpContainerViews()
       
        setupFirstContainer(firstContainer)
          hardReset()
        setUpThirdContainerView(thirdContainer)
        setUpForthContainer(forthContainer)
        
       
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func resetButtonPressed(button:UIButton)
    {
          hardReset()
         updateMainView()
    }
    
    func betOnePressed(button:UIButton)
    {
        if credits <= 0 {
            showAlertWithText(header: "No More Credits", message: "Reset Game")
        } else  {
           
            if currentBet < 5
            {
                currentBet += 1
                credits -= 1
                updateMainView()
            } else
            {
                showAlertWithText( message: "You can only bet 5 credits at a time")
            }
        }
    }
    
    func betMaxPressed(button:UIButton)
    {
        if credits <= 5 {
            showAlertWithText(header: "No enough Credits", message: "Reset Game")
        } else  {
            
            if currentBet < 5
        {
            credits -= 5 - currentBet
            currentBet = 5
          
            updateMainView()
        } else
        {
            showAlertWithText( message: "You can only bet 5 credits at a time")
        }
        updateMainView()
        }
    }
    
    func spinPressed(button:UIButton)
    {
        if currentBet != 0 {
        slots = Factory.createSlots();
        removeOldImageViews()
        setUpSecondContainerView(self.secondContainer)
        var winningsMultiplier = SlotBrain.computeWinnings(slots)
            
            if winningsMultiplier > 0 {
                println(winningsMultiplier)
                
        winnings =  winningsMultiplier * currentBet
        credits += winnings
                println(winnings)
            }
        currentBet = 0;
        updateMainView()
        } else {
            showAlertWithText(message: "Please bet before spinning")
        }
        
    }
    
    func setUpContainerViews()
    {
        //self.view.backgroundColor = UIColor.whiteColor()
        
        self.firstContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: self.view.bounds.origin.y, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        self.firstContainer.backgroundColor = UIColor(red: 0xC5/255, green: 0xE0/255, blue: 0xDC/255, alpha: 1.0)
        self.view.addSubview(self.firstContainer)
        
        
        self.secondContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * (3 * kSixth)))
        
    self.secondContainer.backgroundColor = UIColor(red: 0xff/255, green: 0xff/255, blue: 0xff/255, alpha: 1.0)
        self.view.addSubview(self.secondContainer)
    
    self.thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + secondContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        
        self.thirdContainer.backgroundColor =  UIColor(red: 0xC5/255, green: 0xE0/255, blue: 0xDC/255, alpha: 1.0)
        self.view.addSubview(thirdContainer)
        
        self.forthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        
        self.forthContainer.backgroundColor = UIColor(red: 0xE0/255, green: 0x8e/255, blue: 0x79/255, alpha: 1.0)
        self.view.addSubview(forthContainer)
        
    }
    
    func setupFirstContainer(containerView: UIView)
    {
        
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slots"
        self.titleLabel.textColor = UIColor(red: 0x77/255, green: 0x4F/255, blue: 0x38/255, alpha: 1.0)
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = containerView.center
        containerView.addSubview(self.titleLabel)
        
        
    }
    
    func setUpSecondContainerView(containerView: UIView)
    {
        var containerCount = 0
       
        
        for var containerNumber = 0; containerNumber < kNumberOfContainers; containerNumber++
        {
            for var slotNumber = 0; slotNumber < kNumberOfSlots; slotNumber++
            {
                var slotImageView = UIImageView()
                
                var slot:Slot
                
                if slots.count != 0
                {
                  
                    let slotContainer = self.slots[containerNumber]
                   
                   
                    slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image
                }else
                {
                    slotImageView.image = UIImage(named: "Ace")
                }
                
                
                slotImageView.backgroundColor = UIColor(red: 0xEC/255, green: 0xE5/255, blue: 0xCE/255, alpha: 1.0)
                
                slotImageView.frame = CGRect(x: containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(containerNumber) * kThird), y: containerView.bounds.origin.y  + (containerView.bounds.size.height * CGFloat(slotNumber) * kThird), width: containerView.bounds.width * kThird - kMarginForSlots, height: containerView.bounds.height * kThird - kMarginForSlots)
                
                containerView.addSubview(slotImageView)
            }
            
        }
      }
    
        
        func setUpThirdContainerView(containerView: UIView)
        {
            
            self.creditLabel = UILabel()
            self.creditLabel.text = "\(credits)"
            self.creditLabel.textColor = UIColor(red: 0x77/255, green: 0x4F/255, blue: 0x38/255, alpha: 1.0)
            self.creditLabel.font = UIFont(name: "Menlo-Bold", size: 16)
            self.creditLabel.sizeToFit()
            self.creditLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird)
            self.creditLabel.textAlignment = NSTextAlignment.Center
          //  self.creditLabel.backgroundColor = UIColor.darkGrayColor()
            
            containerView.addSubview(self.creditLabel)
            
            self.betLabel = UILabel()
            self.betLabel.text = "\(currentBet)"
            self.betLabel.textColor = UIColor(red: 0x77/255, green: 0x4F/255, blue: 0x38/255, alpha: 1.0)
            self.betLabel.font = UIFont(name: "Menlo-Bold", size: 16)
            self.betLabel.sizeToFit()
            self.betLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird)
            self.betLabel.textAlignment = NSTextAlignment.Center
          //  self.betLabel.backgroundColor = UIColor.darkGrayColor()
            
            containerView.addSubview(self.betLabel)
            
            self.winnerPaidLabel = UILabel()
            self.winnerPaidLabel.text = "00"
            self.winnerPaidLabel.textColor  = UIColor(red: 0x77/255, green: 0x4F/255, blue: 0x38/255, alpha: 1.0)
            self.winnerPaidLabel.font = UIFont(name: "Menlo-Bold", size: 16)
            self.winnerPaidLabel.sizeToFit()
            self.winnerPaidLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird)
            self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
           // self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
            
            containerView.addSubview(self.winnerPaidLabel)
            
            self.creditsTitleLabel = UILabel()
            self.creditsTitleLabel.text = "Credits"
            self.creditsTitleLabel.textColor = UIColor(red: 0x77/255, green: 0x4F/255, blue: 0x38/255, alpha: 1.0)
            self.creditsTitleLabel.font = UIFont(name: "AmericanTypeWriter", size: 14)
            self.creditsTitleLabel.sizeToFit()
            self.creditsTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird * 2)
            
            containerView.addSubview(self.creditsTitleLabel)
            
            self.betTitleLabel = UILabel()
            self.betTitleLabel.text = "Bet"
            self.betTitleLabel.textColor = UIColor(red: 0x77/255, green: 0x4F/255, blue: 0x38/255, alpha: 1.0)
            self.betTitleLabel.font = UIFont(name: "AmericanTypeWriter", size: 14)
            self.betTitleLabel.sizeToFit()
            self.betTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird * 2)
            
            containerView.addSubview(betTitleLabel)
            
            self.winnerPaidTitleLabel = UILabel()
            self.winnerPaidTitleLabel.text = "Winnings Paid"
            self.winnerPaidTitleLabel.textColor = UIColor(red: 0x77/255, green: 0x4F/255, blue: 0x38/255, alpha: 1.0)
            self.winnerPaidTitleLabel.font = UIFont(name: "AmericanTypeWriter", size: 14)
            self.winnerPaidTitleLabel.sizeToFit()
            self.winnerPaidTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird * 2)
            
            containerView.addSubview(self.winnerPaidTitleLabel)
            
            
        }
    
    
    func setUpForthContainer(containerView:UIView)
    {
     
        self.resetButton = UIButton()
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
        self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        
        self.resetButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        self.resetButton.titleLabel?.font = UIFont(name:"SuperClarendon-Bold" , size: 12)
        self.resetButton.sizeToFit()
        self.resetButton.backgroundColor = UIColor.lightGrayColor()
        self.resetButton.center = CGPoint(x: containerView.frame.width * kEight, y: containerView.frame.height * kHalf )
        
        self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        containerView.addSubview(self.resetButton);
        
        
        self.betOneButton = UIButton()
        self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        self.betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
         self.betOneButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        self.betOneButton.titleLabel?.font = UIFont(name:"SuperClarendon-Bold" , size: 12)
        self.betOneButton.backgroundColor = UIColor.lightGrayColor()
        self.betOneButton.sizeToFit()
        self.betOneButton.center = CGPoint(x: containerView.frame.width * kEight * 3, y: containerView.frame.height * kHalf)
        self.betOneButton.addTarget(self, action: "betOnePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        containerView.addSubview(self.betOneButton)
        
        self.betMaxButton = UIButton()
        self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
         self.betMaxButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        self.betMaxButton.titleLabel?.font = UIFont(name:"SuperClarendon-Bold" , size: 12)
        self.betMaxButton.backgroundColor = UIColor.lightGrayColor()
        self.betMaxButton.sizeToFit()
        self.betMaxButton.center = CGPoint(x: containerView.frame.width * kEight * 5, y: containerView.frame.height * kHalf)
        
        self.betMaxButton.addTarget(self, action: "betMaxPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betMaxButton)
        
        self.spinButton = UIButton()
        self.spinButton.setTitle("Spin", forState: UIControlState.Normal)
        self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
         self.spinButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        self.spinButton.titleLabel?.font = UIFont(name:"SuperClarendon-Bold" , size: 12)
        self.spinButton.backgroundColor = UIColor.lightGrayColor()
        self.spinButton.sizeToFit()
        self.spinButton.center = CGPoint(x: containerView.frame.width * kEight * 7, y: containerView.frame.height * kHalf)
        
        self.spinButton.addTarget(self, action: "spinPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.spinButton)
        
        
    }
            
    func removeOldImageViews()
    {
        if self.secondContainer != nil{
            let container:UIView? = self.secondContainer
            let subViews:Array? = container!.subviews
            
            for view in subViews!
            {
                view.removeFromSuperview()
            }
        }
    }
    
    func hardReset()
    {
        removeOldImageViews()
        slots.removeAll(keepCapacity: true)
        self.setUpSecondContainerView(secondContainer)
        credits = 50;
        winnings = 0;
        currentBet = 0;
       
        
    }
    
    func updateMainView () {
     
        self.creditLabel.text = "\(credits)"
        self.betLabel.text = "\(currentBet)"
        self.winnerPaidLabel.text = "\(winnings)"
        winnings = 0
    }
    
    func showAlertWithText(header: String = "Warning", message:String)
    {
     
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    

}

