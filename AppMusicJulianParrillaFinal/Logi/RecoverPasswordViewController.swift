//
//  RecoverPasswordViewController.swift
//  AppMusicJulianParrillaFinal
//
//  Created by alumnos on 8/2/18.
//  Copyright © 2018 julianparrilla. All rights reserved.
//

import UIKit
import TextFieldEffects
import ZAlertView
import Toast_Swift

class RecoverPasswordViewController: UIViewController {
    
    @IBOutlet weak var nameTextRc: UITextField!
    @IBOutlet weak var emailTextRc: UITextField!
    
    //Declaración de un data manager para usar servicios
    var dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func recoverBtn(_ sender: UIButton) {
        if (nameTextRc.text?.isEmpty)! || (emailTextRc.text?.isEmpty)!{
            self.view.makeToast("Es necesario que todos los parametros esten rellenos", duration: 3.0, position: .top)
            
        }else{
            recoverPass(params: ["name": nameTextRc.text!, "email": emailTextRc.text!])
        }
    }
    
    func recoverPass(params: [String: Any]) {
        //Se hace la llamada y se filtran los códigos
        dataManager.getRecoverPass(params: params) { (json) in
            if json.code == 201 {
                UserDefaults.standard.set(json.data["token"] , forKey: "token")
                self.buildAndShowPopUp()
            } else if json.code == 401 || json.code == 419{
                self.view.makeToast(json.message , duration: 3.0, position: .top)
            } else if json.code == 400 || json.code == 500 {
                print(String(describing:json))
            }
            print(String(describing:json))
        }
    }
    
    func buildAndShowPopUp() {
        //Se crea el alert con un estilo y se muestra
        ZAlertView.textFieldBorderColor = #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1)
        ZAlertView.positiveColor = #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1)
        ZAlertView.messageColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        ZAlertView.titleColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        
        let dialog = ZAlertView(title: "Cambiar contraseña", message: "Introduce tu nueva contraseña", isOkButtonLeft: false, okButtonText: "CAMBIAR", cancelButtonText: "CANCELAR", okButtonHandler: { (alert) in
            let pass = alert.getTextFieldWithIdentifier("pass")?.text
            let repeatPass = alert.getTextFieldWithIdentifier("repeatPass")?.text
            
            self.checkPass(pass: pass!, repeatPass: repeatPass!, alert: alert)
            UserDefaults.standard.set(nil , forKey: "token")
        }) { (alert) in
            UserDefaults.standard.set(nil , forKey: "token")
            alert.dismissAlertView()
        }
        
        dialog.addTextField("pass", placeHolder: "Contraseña", isSecured: true)
        let passTF = dialog.getTextFieldWithIdentifier("pass")
        passTF?.backgroundColor = UIColor.clear
        
        dialog.addTextField("repeatPass", placeHolder: "Repetir ontraseña", isSecured: true)
        let passRepeatTF = dialog.getTextFieldWithIdentifier("repeatPass")
        passRepeatTF?.backgroundColor = UIColor.clear
        
        dialog.show()
    }
    
    
    func checkPass(pass: String, repeatPass: String, alert: ZAlertView) {
        //Se comprueban los campos en el alert
        if (pass.count) < 6 {
            alert.view.makeToast("La contraseña debe de tener como mínimo 6 carácteres" , duration: 3.0, position: .top)
        }else if pass != repeatPass {
            alert.view.makeToast("Las contraseñas deben de coincidir" , duration: 3.0, position: .top)
        }else{
            self.updatePass(pass: pass)
            alert.dismissAlertView()
        }
    }
    
    func updatePass(pass: String) {
        //Llamada a la API para actualizar la contraseña
        self.dataManager.postUpdatePass(params: ["pass": pass as Any], completionHandler: { (json) in
            if json.code == 201 {
                self.performSegue(withIdentifier: "goToLogin", sender: nil)
            } else if json.code == 401 || json.code == 419{
                self.view.makeToast(json.message , duration: 3.0, position: .top)
            } else if json.code == 400 || json.code == 500 {
                print(String(describing:json))
            }
            
        })
    }
}

