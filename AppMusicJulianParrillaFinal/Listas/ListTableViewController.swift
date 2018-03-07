//
//  ListTableViewController.swift
//  AppMusicJulianParrillaFinal
//
//  Created by alumnos on 7/3/18.
//  Copyright © 2018 julianparrilla. All rights reserved.
//

import UIKit
import Toast_Swift
import TextFieldEffects

class ListTableViewController: UITableViewController{
    
    let dataManager = DataManager()
    var songs = NSArray()
    var songsParsed = [Songs]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var toastStyle = ToastStyle() //Estilo del toast
        obtainSongs(parameters: ["data": "nil"])
        
        //Se define el estilo de los toast
        toastStyle.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.8235294118, blue: 0.981543839, alpha: 1)
        toastStyle.messageColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        toastStyle.messageFont = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        ToastManager.shared.style = toastStyle
    }
    
    func obtainSongs(parameters: [String: Any]){
        //Se hace la llamada a la API y se filtran los códigos de respuesta
        dataManager.getSongs(params: parameters) { (json) in
            if json.code == 200 {
                self.songs = json.data["songs"] as! NSArray
                
                for songR in json.data["songs"] as! [[String : Any]]{
                    self.songsParsed.append(Songs(song:songR))
                }
                
                self.tableView.reloadData()
                self.view.makeToast(json.message , duration: 3.0, position: .top)
            } else if json.code == 401 || json.code == 419{
                self.view.makeToast(json.message , duration: 3.0, position: .top)
            } else if json.code == 400 || json.code == 500 {
                print(String(describing:json))
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
        return self.songsParsed.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DataInTableViewCell = tableView.dequeueReusableCell(withIdentifier: "filaSong", for: indexPath) as! DataInTableViewCell
        
        cell.songName.text = self.songsParsed[indexPath.item].nameSong
        cell.artistName.text = self.songsParsed[indexPath.item].nameArtist
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(songsParsed[indexPath.item].urlSong)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
