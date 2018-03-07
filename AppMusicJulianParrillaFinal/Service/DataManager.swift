//
//  DataManager.swift
//  AppMusicJulianParrillaFinal
//
//  Created by alumnos on 8/2/18.
//  Copyright © 2018 julianparrilla. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    //Se hace una llamada a la API con el endpoint del Login y se devuelve la respuesta parseada desde json,
    //necesita secibir los parametros en formato de [String: Any]
    func getLogin(params: [String: Any], completionHandler: @escaping (_ json: JSONhttp) -> Void){
        let requestController = RequestController()
        
        let url: URL = URL(string:"http://h2744356.stratoserver.net/julian/julianparrillaRep/public/index.php/users/login.json")!
        
        requestController.makeGetRequest(url: url, params: params, headers: [:]) { (json) in
            completionHandler(json)
        }
    }
    
    func getSongs(params: [String: Any], completionHandler: @escaping (_ json: JSONhttp) -> Void){
        let requestController = RequestController()
        
        let url: URL = URL(string:"http://h2744356.stratoserver.net/julian/julianparrillaRep/public/index.php/canciones/songs.json")!
        
        requestController.makeGetRequest(url: url, params: [:], headers: [:]) { (json) in
            completionHandler(json)
        }
    }
    
    //Se hace una llamada a la API con el endpoint de la creación de usuario y se devuelve la respuesta parseada desde json,
    //necesita secibir los parametros en formato de [String: Any]
    func postCreateUser(params: [String: Any], completionHandler: @escaping (_ json: JSONhttp) -> Void){
        let requestController = RequestController()
        
        let url: URL = URL(string:"http://h2744356.stratoserver.net/julian/julianparrillaRep/public/index.php/users/create.json")!
        let headers: [String: String] = ["Content-Type": "application/x-www-form-urlencoded"]
        
        requestController.makePostRequest(url: url, params: params, headers: headers, completionHandler: {(json) in
                    completionHandler(json)
            })
    }
    
    //Se hace una llamada a la API con el endpoint de recuperar la contraseña y se devuelve la respuesta parseada desde json,
    //necesita secibir los parametros en formato de [String: Any]
    func getRecoverPass(params: [String: Any], completionHandler: @escaping (_ json: JSONhttp) -> Void){
        let requestController = RequestController()
        
        let url: URL = URL(string:"http://h2744356.stratoserver.net/julian/julianparrillaRep/public/index.php/users/recoverPass.json")!
        
        requestController.makeGetRequest(url: url, params: params, headers: [:]) { (json) in
            completionHandler(json)
        }
    }
    
    //Se hace una llamada a la API con el endpoint de actualizar contraseña y se devuelve la respuesta parseada desde json,
    //necesita secibir los parametros en formato de [String: Any]
    func postUpdatePass(params: [String: Any], completionHandler: @escaping (_ json: JSONhttp) -> Void){
        let requestController = RequestController()
        
        let url: URL = URL(string:"http://h2744356.stratoserver.net/julian/julianparrillaRep/public/index.php/users/modify.json")!
        let headers: [String: String] = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": UserDefaults.standard.value(forKey: "token") as! String]
        
        requestController.makePostRequest(url: url, params: params, headers: headers, completionHandler: {(json) in
            completionHandler(json)
        })
    }
    
}
