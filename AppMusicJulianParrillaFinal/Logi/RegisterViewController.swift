//
//  RegisterViewController.swift
//  AppMusicJulianParrillaFinal
//
//  Created by alumnos on 6/3/18.
//  Copyright © 2018 julianparrilla. All rights reserved.
//

import UIKit
import Foundation
import TextFieldEffects

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextReg: UITextField!
    @IBOutlet weak var emailTextReg: UITextField!
    @IBOutlet weak var passTextReg: UITextField!
    @IBOutlet weak var cpassTextReg: UITextField!
    
    @IBAction func regBtn(_ sender: UIButton) {
        if (nameTextReg.text?.isEmpty)! || (passTextReg.text?.isEmpty)! || (emailTextReg.text?.isEmpty)! {
            self.view.makeToast("Es necesario que todos los parametros esten rellenos", duration: 3.0, position: .top)
        }else if (passTextReg.text?.count)! < 6{
            self.view.makeToast("La contraseña debe tener al menos 6 caracteres", duration: 3.0, position: .top)
        }else if passTextReg.text != cpassTextReg.text{
            self.view.makeToast("Las contraseñas deben de coincidir", duration: 3.0, position: .top)
        }else{
            register(parameters: ["name": nameTextReg.text!, "pass": passTextReg.text!, "email": emailTextReg.text!, "rol":2])
        }
    }
    
    //Declaración de un data manager para usar servicios
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func register(parameters: [String: Any]) {
        //Se hace la llamada a la API y se filtran los códigos de respuesta
        dataManager.postCreateUser(params: parameters) { (json) in
            if json.code == 201 {
                self.performSegue(withIdentifier: "home", sender: nil)
            } else if json.code == 401 || json.code == 419{
                self.view.makeToast(json.message , duration: 3.0, position: .top)
            } else if json.code == 400 || json.code == 500 {
                print(String(describing:json))
            }
        }
    }
}

