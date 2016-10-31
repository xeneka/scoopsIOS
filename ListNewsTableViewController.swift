//
//  ListNewsTableViewController.swift
//  Scoops
//
//  Created by Antonio Benavente del Moral on 23/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

class ListNewsTableViewController: UITableViewController {

    
    var model = [dataNews]()
    let storage = AzureStorage()
    
    @IBAction internal func ReturnLogin(_ sender: AnyObject){
         present(returnLoginScene(), animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()+
       
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if model.isEmpty {
        
        let azu = dataStackAzure()
        azu.readNewPublished { (data) in
            
            let image = UIImageJPEGRepresentation(UIImage(named: "robot.png")!,0.9)
            
            for each in data as! [Dictionary<String, AnyObject>] {
                
                
                
                let newItem = dataNews(title: each["title"] as! String, text: each["text"] as! String, blob: image!, authors: "Auto", coordenadas: (0,0), typeBlog: .img, urlFromBlob: each["urlPhoto"] as! String, visible: each["visible"] as! Bool, idnew:each["id"] as! String, publicada: each["publicada"] as! Bool)
                self.model.append(newItem)
                
            }
            
            self.tableView.reloadData()
        }
            
   
            
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "readercell", for: indexPath) as! ReaderTableViewCell

        // Configure the cell...

        let data = model[indexPath.row]
        
        cell.titleNew.text = data.title
        
        // Defino una imagen temporal que cambiare cuando se descargue la imagen
        cell.imageNew.image = UIImage(data: data.blob)
        
        // Descargo en segundo plano la image y cuando me la descargo la cambio
        storage.downloadBlobFromStorage(nameFile: data.urlData){ (data: Any) in
            
            
            cell.imageNew.image = UIImage(data: data as! Data)
            
        }
        
        
        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = model[indexPath.row]
        
        
        performSegue(withIdentifier: "detailNew", sender: item)

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
        
        if segue.identifier == "detailNew" {
            
            if sender is dataNews {
                let vc = segue.destination as? detailNewViewController
                vc?.model = sender as! dataNews
            }
            
        
            
            
        }
        
        
        
    }
 

}
