//
//  ViewController.swift
//  WhereIsCage
//
//  Created by Mathieu Vandeginste on 16/02/2016.
//  Copyright © 2016 Mathieu Vandeginste. All rights reserved.
//

import UIKit

class FindCageViewController: UIViewController {
    
    var canvas = UIImageView()
    var portrait: Bool = true
    var image: UIImage = UIImage(named: "0")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canvas.image = image
        
        self.canvas.frame = self.view.frame
        self.view.backgroundColor = UIColor.blackColor()
        self.canvas.contentMode = UI
        self.canvas.frame = CGRectMake(0, 0, self.image.size.width, self.image.size.height)
        self.canvas.userInteractionEnabled = true
        self.view.addSubview(self.canvas)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)

    }

    @IBAction func zoom(sender: UIPinchGestureRecognizer) {
        self.canvas.transform = CGAffineTransformScale(self.canvas.transform, sender.scale, sender.scale)
        sender.scale = 1
    }
    
    @IBAction func findCage(sender: UILongPressGestureRecognizer) {
        
    }
    
    @IBAction func find(sender: UITapGestureRecognizer) {
        var selectedPoint = sender.locationInView(self.canvas)
        print("width = \(self.canvas.frame.width) & height= \(self.canvas.frame.height)")
        print(selectedPoint)
        selectedPoint.x = selectedPoint.x / self.canvas.frame.width * 100
        selectedPoint.y = selectedPoint.y / self.canvas.frame.height * 100
        print(selectedPoint)
    }
    
   

    @IBAction func move(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(sender.view)
        self.canvas.center = CGPoint(x: canvas.center.x + translation.x, y: canvas.center.y + translation.y)
        sender.setTranslation(CGPointZero, inView: self.view)
    }
    
    @IBAction func reset(sender: UITapGestureRecognizer) {
        self.reset()
    }
    
    func rotated(){
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)
        {
            if self.portrait {
                self.portrait = false
                self.reset()
            }
            
        }
        if UIDevice.currentDevice().orientation == UIDeviceOrientation.Portrait
        {
            if !self.portrait {
                self.portrait = true
                self.reset()
                
            }
        }
    }
    
    private func reset() {
        self.canvas.frame = self.view.frame
    }

}

