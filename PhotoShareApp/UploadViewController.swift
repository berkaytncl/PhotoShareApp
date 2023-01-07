//
//  UploadViewController.swift
//  PhotoShareApp
//
//  Created by Berkay Tuncel on 6.01.2023.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func choseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        let uuidString = UUID().uuidString
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let imageRef = mediaFolder.child("\(uuidString).jpg")
            imageRef.putData(data) { storageMetadata, error in
                
                if let _ = error {
                    self.errorMessage(titleInput: "Error", messageInput: error?.localizedDescription ?? "Could not upload file")
                } else {
                    
                    imageRef.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            print(imageUrl)
                        }
                    }
                    
                }
            }
            
        }
    }
    
    func errorMessage(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
