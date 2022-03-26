//
//  ViewController.swift
//  Canvas-Drawing
//
//  Created by BSP Macbook on 3/24/22.
//


import UIKit

class ViewController: UIViewController {
    
    let canvas = Canvas(coordinate: [
        Point(x1: 150, y1: 380, x2: 270, y2: 370),
        Point(x1: 200, y1: 380, x2: 160, y2: 530),
        Point(x1: 105, y1: 540, x2: 325, y2: 540),
        Point(x1: 140, y1: 455, x2: 241, y2: 520)
    ])
    
    // Add something
    // End
    
    override func loadView() {
        self.view = canvas
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        canvas.backgroundColor = .white
        canvas.frame = view.frame
        
        let catImage = UIImage(named: "numberFive.png")
        
        let myImageView:UIImageView = UIImageView()
        myImageView.contentMode = UIView.ContentMode.scaleAspectFit
        myImageView.frame.size.width = 300
        myImageView.frame.size.height = 300
        myImageView.center = self.view.center
        myImageView.alpha = 0.2
        
        canvas.addSubview(myImageView)
        myImageView.image = catImage
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        myImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        myImageView.centerXAnchor.constraint(lessThanOrEqualTo: canvas.centerXAnchor).isActive = true
        myImageView.centerYAnchor.constraint(lessThanOrEqualTo: canvas.centerYAnchor).isActive = true
        

        
        // Set value for word view
        // End setting
    }
}

