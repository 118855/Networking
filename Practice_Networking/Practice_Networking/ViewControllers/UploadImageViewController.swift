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
    
    var backgroundTaskIdentifier:UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    
    private var selectedImage: UIImage!
    private var imagePicker = UIImagePickerController()
    
    let CLIENT_ID = "5af4a79c42ea7df"
    
    let url = URL(string: "https://api.imgur.com/3/image")!
    
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
        
        guard let imageData: Data = selectedImageView.image?.jpegData(compressionQuality: 1),
              let url = URL(string: Hosts.postImage) else {return}

        DispatchQueue.global().async {
            self.backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(withName: "backgroundTask") {
                UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier)
                self.backgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid }
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Client-ID \(self.CLIENT_ID)", forHTTPHeaderField: "Authorization")
        request.httpBody = imageData
        
        NetworkManager.session.dataTask(with: request) { (data, responce, error) in
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
        
        UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier)
        self.backgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    }
}
extension UploadImageViewController: URLSessionDelegate {
func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
    DispatchQueue.main.async {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let backgroundCompletionHandler =
            appDelegate.backgroundCompletionHandler else {
                return
        }
        backgroundCompletionHandler()
    }
}
}
extension UploadImageViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
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

