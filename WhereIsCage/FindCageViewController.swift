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
        self.initCanvas()
        self.canvas.backgroundColor = UIColor.redColor()
        self.view.backgroundColor = UIColor.blackColor()
        self.canvas.contentMode = UIViewContentMode.ScaleAspectFit
        self.canvas.userInteractionEnabled = true
        self.view.addSubview(self.canvas)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)

    }

    //gestures methods
    @IBAction func zoom(sender: UIPinchGestureRecognizer) {
        self.canvas.transform = CGAffineTransformScale(self.canvas.transform, sender.scale, sender.scale)
        sender.scale = 1
    }
    
    @IBAction func find(sender: UITapGestureRecognizer) {
        let selectedPoint = sender.locationInView(self.canvas)
        print("width = \(self.canvas.frame.width) & height= \(self.canvas.frame.height)")
        print(selectedPoint)    }

    @IBAction func move(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(sender.view)
        self.canvas.center = CGPoint(x: canvas.center.x + translation.x, y: canvas.center.y + translation.y)
        sender.setTranslation(CGPointZero, inView: self.view)
    }
    
    @IBAction func reset(sender: UITapGestureRecognizer) {
        self.initCanvas()
    }
    
    func rotated(){
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)
        {
            if self.portrait {
                self.portrait = false
                self.initCanvas()
            }
            
        }
        if UIDevice.currentDevice().orientation == UIDeviceOrientation.Portrait
        {
            if !self.portrait {
                self.portrait = true
                self.initCanvas()
                
            }
        }
    }
    
    private func initCanvas() {
        let width = self.image.size.width
        let height = self.image.size.height
        
        if width > height {
            let ratio = width / self.view.frame.width
            let computedHeight = self.image.size.height / ratio
            let computedY = self.view.frame.height / 2 - computedHeight / 2
            self.canvas.frame = CGRectMake(0, computedY, self.view.frame.width, computedHeight)
        } else {
            let ratio = height / self.view.frame.height
            let computedWidth = self.image.size.width / ratio
            let computedX = self.view.frame.width / 2 - computedWidth / 2
            self.canvas.frame = CGRectMake(computedX, 0, computedWidth, self.view.frame.height)
        }
        
    }

}

