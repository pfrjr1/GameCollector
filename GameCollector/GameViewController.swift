//
//  GameViewController.swift
//  GameCollector
//
//  Created by Peter Rooney on 5/2/17.
//  Copyright © 2017 Peter Rooney. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var deletebutton: UIButton!
    @IBOutlet weak var addupdatebutton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var gameImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var game : Game? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if game != nil {
            gameImageView.image = UIImage(data: game!.image as! Data)
            titleTextField.text = game!.title
            
            addupdatebutton.setTitle("Update", for: .normal)
        }else{
            deletebutton.isHidden = true
        }
    }

    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as!
        UIImage
        
        gameImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if game != nil {
            game!.title = titleTextField.text
            game!.image = (UIImagePNGRepresentation(gameImageView.image!)! as NSData)
            
        } else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let game = Game(context: context)
            game.title = titleTextField.text
            game.image = (UIImagePNGRepresentation(gameImageView.image!)! as NSData)
            
            
        }
        
        
        (UIApplication.shared.delegate as!
        AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(game!)
        
        (UIApplication.shared.delegate as!
            AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
}
