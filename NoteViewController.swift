//
//  NoteViewController.swift
//  Scoops
//
//  Created by Antonio Benavente del Moral on 23/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    
    var noteView:AutorsViewModel? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
      
        
        
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var photoImage: UIImageView!

    
    @IBOutlet weak var titleNews: UITextField!
    
    @IBOutlet weak var textNews: UITextView!
    
    @IBAction func saveNote(_ sender: AnyObject) {
        

        
        
        noteView = AutorsViewModel(title: titleNews.text!,Author: "Autor1", Image: photoImage.image!, text: textNews.text  )
        noteView?.saveNews()
        
        
    }
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        
        // Crear una instancia de UIImagePicker
        let picker = UIImagePickerController()
        
        // Configurarlo
        if UIImagePickerController.isCameraDeviceAvailable(.rear){
            picker.sourceType = .camera
        }else{
            // me conformo con el carrete
            picker.sourceType = .photoLibrary
        }
        
        
        picker.delegate = self
        
        // Mostrarlo de forma modal
        self.present(picker, animated: true) {
            // Por si quieres hacer algo nada más
            // mostrarse el picker
        }
        

        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension NoteViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let size = CGSize(width: 600, height: 600);
        
        let photo = info[UIImagePickerControllerOriginalImage] as! UIImage?
        
        
        photoImage.image = photo?.ResizeImage(targetSize: size)
        
        //photoImage.image = info[UIImagePickerControllerOriginalImage] as! UIImage?
        
        
      
        self.dismiss(animated: true) {
            //
        }
        
    }
    
    
    
}




