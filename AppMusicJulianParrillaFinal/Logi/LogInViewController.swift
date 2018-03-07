//
//  LogInViewController.swift
//  AppMusicJulianParrillaFinal
//
//  Created by alumnos on 8/2/18.
//  Copyright © 2018 julianparrilla. All rights reserved.
//

import UIKit
import Toast_Swift
import TextFieldEffects

class LogInViewController: UIViewController {
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var passInput: UITextField!
    var toastStyle = ToastStyle() //Estilo del toast
    
    //Declaración de un data manager para usar servicios
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Se define el estilo de los toast
        toastStyle.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.8235294118, blue: 0.981543839, alpha: 1)
        toastStyle.messageColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        toastStyle.messageFont = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        ToastManager.shared.style = toastStyle
    }
    
    @IBAction func logBtn(_ sender: UIButton) {
        //Se coimprueban que los campos sean válidos y se hace una llamada a la API
        if (nameInput.text?.isEmpty)! || (passInput.text?.isEmpty)!{
            self.view.makeToast("Es necesario que todos los parametros esten rellenos", duration: 3.0, position: .top)
        }else if(passInput.text?.count)! < 4{
            self.view.makeToast("La contraseña debe tener al menos 4 caracteres", duration: 3.0, position: .top)
        }else{
            login(parameters: ["name": nameInput.text!, "pass": passInput.text!])
        }
    }
    
    func login(parameters: [String: Any]){
        //Se hace la llamada a la API y se filtran los códigos de respuesta
        dataManager.getLogin(params: parameters) { (json) in
            if json.code == 201 {
                UserDefaults.standard.set(json.data["token"] , forKey: "token")
                self.view.makeToast(json.message , duration: 3.0, position: .top)
                self.performSegue(withIdentifier: "mainscreenID", sender: nil)
            } else if json.code == 401 || json.code == 419{
                self.view.makeToast(json.message , duration: 3.0, position: .top)
            } else if json.code == 400 || json.code == 500 {
                print(String(describing:json))
            }
        }
    }
}
