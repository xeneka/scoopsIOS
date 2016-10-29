//
//  ViewController.swift
//  Scoops
//
//  Created by Antonio Benavente del Moral on 22/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func AutorOption(_ sender: AnyObject) {
        
        
        
        let AutorStoryBoards = UIStoryboard(name: "Autors", bundle: Bundle.main)
        let vc = AutorStoryBoards.instantiateViewController(withIdentifier: "AutorScene")
        
       
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func ReaderOption(_ sender: AnyObject) {
        
        let AutorStoryBoards = UIStoryboard(name: "Readers", bundle: Bundle.main)
        let vc = AutorStoryBoards.instantiateViewController(withIdentifier: "ReadersScene")
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

