//
//  CameraViewController.swift
//  Lategram
//
//  Created by Daval Cato on 12/1/20.
//

import AVFoundation
import UIKit

class CameraViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var button: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Button color
        button.backgroundColor = .systemBlue
        button.setTitle("Take Picture", for: .normal)
        
    }
    
    @IBAction func didTapTakePicture() {
        
        
    }
   

}
