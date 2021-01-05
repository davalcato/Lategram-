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
        
        navigationItem.title = "Camera"
        
        // Change imageView background
        imageView.backgroundColor = .secondarySystemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Button color
        button.backgroundColor = .systemBlue
        button.setTitle("Take Picture", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
    }
    
    @IBAction func didTapTakePicture() {
        
//        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let alertController = UIAlertController(title: nil, message: "Device has no camera.", preferredStyle: .alert)
//
//            let okAction = UIAlertAction(title: "Alright", style: .default, handler: { (alert: UIAlertAction!) in
//            })
//
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//        } else {
//            // Other action
//        }
        
        // Presenting camera here
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        // Assign picker delegate to self
        picker.delegate = self
        present(picker, animated: true)
    }
    
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Picker dismis
        picker.dismiss(animated: true, completion: nil)
        
        
        // Taking a reference of the image
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as?
        UIImage else {
                return
        }
        // Once we have an image
        imageView.image = image
    }
    
    
}














