//
//  detailNewViewController.swift
//  Scoops
//
//  Created by Antonio Benavente del Moral on 30/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

class detailNewViewController: UIViewController {

    var model: dataNews?
    var stack = dataStackAzure()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        titleNew.text = model?.title
        imageNew.image = UIImage(data: (model?.blob)!)
        detailTextNew.text = model?.text
        
    }
    
    @IBOutlet weak var titleNew: UILabel!
    
    @IBOutlet weak var imageNew: UIImageView!
    
    @IBOutlet weak var detailTextNew: UITextView!
    
    @IBAction func votoPositivo(_ sender: AnyObject) {
        stack.voteNew(idNew: (model?.idnew)!, vote: 1)
    }
    
    @IBAction func VotoNegativo(_ sender: AnyObject) {
        stack.voteNew(idNew: (model?.idnew)!, vote: -1)
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
