//
//  AutorsTableViewController.swift
//  Scoops
//
//  Created by Antonio Benavente del Moral on 23/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

class AutorsTableViewController: UITableViewController {

    
    var model = [dataNews]()
    let azureApi = dataStackAzure()
    let storage = AzureStorage()
    
    
    let image = UIImageJPEGRepresentation(UIImage(named: "robot.png")!,0.9)
    
    @IBAction func ReturnLogin(_ sender: AnyObject) {
        
        present(returnLoginScene(), animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        azureApi.login(provider: "facebook", controller: self){ (user: Any?, error:Any?) in
            
           
            
            if let _ = error  {
                
                print("Error")
                return
            }
            
            
            let registerUser = user as! MSUser
            
            
             self.loadNews()
            
        }
       
        
        
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellnews", for: indexPath) as! NewsTableViewCell

        // Configure the cell...
        
        let data = model[indexPath.row]

        cell.textNew.text = data.title
        
        
        // Defino una imagen temporal que cambiare cuando se descargue la imagen
        cell.ImageNew.image = UIImage(data: data.blob)
        
        // Descargo en segundo plano la image y cuando me la descargo la cambio
        storage.downloadBlobFromStorage(nameFile: data.urlData){ (data: Any) in
            
            
            cell.ImageNew.image = UIImage(data: data as! Data)
            
        }

        
        cell.changeSituacionValue.tag = indexPath.row
        cell.changeSituacionValue.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        
        
        
        if data.publicada {
            cell.situacionNew.text = "Publicada"
        }else{
            cell.situacionNew.text = "No publicada"
        }
        
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destination as? NoteViewController
        
        vc?.azureApi = self.azureApi
        
    }
 

}


extension AutorsTableViewController {
    
    func loadNews(){
        
        var data = azureApi.readAllItemsInTable{ (data: Any) in
         
            
            
            for each in data as! [Dictionary<String, AnyObject>] {
                
                
                
                let newItem = dataNews(title: each["title"] as! String, text: each["text"] as! String, blob: self.image!, authors: "Auto", coordenadas: (0,0), typeBlog: .img, urlFromBlob: each["urlPhoto"] as! String, visible: each["visible"] as! Bool, idnew:each["id"] as! String, publicada: each["publicada"] as! Bool)
                self.model.append(newItem)
                
            }
            
            self.tableView.reloadData()
            
        }
        
        
        
    }
    
    func buttonClicked(sender:UIButton) {
        
        let buttonRow = sender.tag
        
        
        azureApi.publishNew(idnew: self.model[buttonRow].idnew! )
        
        // OJO Meter clouser para informar que ha ido bien. Luego notificacion para cambiar la celda.
        
        
    }    
       
    
}
