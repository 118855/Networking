//
//  UploadImageViewController.swift
//  Practice_Networking
//
//  Created by admin on 17.07.2021.
//  Copyright © 2021 NIX Solitions. All rights reserved.
//

import UIKit

class UploadImageViewController: UIViewController {
    
    @IBOutlet private weak var selectedImageView: UIImageView!
    
    @IBOutlet private weak var selectImageButton: UIButton!
    @IBOutlet private weak var uploadImageButton: UIButton!
    
    @IBOutlet private weak var urlTextView: UITextView!
    
    private var selectedImage: UIImage!
    private var imagePicker = UIImagePickerController()
    
    let CLIENT_ID = "5af4a79c42ea7df"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func selectImageButtonAction(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: UserMessagesAndTitles.alertTitle,
                                            message:"",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: UserMessagesAndTitles.changePhotoTitle,
                                            style: .default,
                                            handler:{ (action) in
                                                self.showImagePickerController(sourceType: .photoLibrary)} ))
        actionSheet.addAction(UIAlertAction(title: UserMessagesAndTitles.chooseCameraTitle,
                                            style: .default,
                                            handler:{ (action) in
                                                if UIImagePickerController.isSourceTypeAvailable(.camera){
                                                    self.showImagePickerController(sourceType: .camera) }
                                                else {
                                                    let alertController = UIAlertController(title: nil,
                                                                                            message: UserMessagesAndTitles.deviceHasNoCameraTitle,
                                                                                            preferredStyle: .alert)
                                                    
                                                    let okAction = UIAlertAction(title: UserMessagesAndTitles.alrightTitle,
                                                                                 style: .default, handler: nil)
                                                    
                                                    alertController.addAction(okAction)
                                                    self.present(alertController, animated: true, completion: nil)
                                                }
                                            }))
        actionSheet.addAction(UIAlertAction(title: UserMessagesAndTitles.cancelTitle,
                                            style: .cancel,
                                            handler:nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
        @IBAction func uploadImageButtonAction(_ sender: UIButton) {
            uploadImageToImgur(image: selectedImage )
        }
    func uploadImageToImgur(image: UIImage) {
        guard let imageData: Data = selectedImageView.image?.jpegData(compressionQuality: 1) else {return}
        
        let session = URLSession.shared
        let url = URL(string: "https://api.imgur.com/3/image")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Client-ID \(self.CLIENT_ID)", forHTTPHeaderField: "Authorization")
        request.httpBody = imageData
        
        session.dataTask(with: request) { (data, responce, error) in
            guard let responce = responce,
                  let data = data else {return}
            print(responce)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension UploadImageViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            selectedImage = pickedImage
            selectedImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

