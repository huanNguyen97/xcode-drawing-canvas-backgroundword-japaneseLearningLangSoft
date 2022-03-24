//
//  ViewController.swift
//  Canvas-Drawing
//
//  Created by BSP Macbook on 3/24/22.
//


import UIKit

class ViewController: UIViewController {
    
    let canvas = Canvas(x1: 110, y1: 110, x2: 200, y2: 200)
    
    override func loadView() {
        self.view = canvas
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        view.addSubview(canvas)
        canvas.backgroundColor = .white
        canvas.frame = view.frame
    }
}

