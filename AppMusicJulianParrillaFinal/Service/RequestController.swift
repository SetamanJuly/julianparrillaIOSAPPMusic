//
//  RequestController.swift
//  AppMusicJulianParrillaFinal
//
//  Created by alumnos on 8/2/18.
//  Copyright © 2018 julianparrilla. All rights reserved.
//

import UIKit
import Alamofire

class RequestController: NSObject {
    
    //Petición get estandarizada, necesita recibir url en formato URL, parametros como [String: Any] y headers como [String: String]
    func makeGetRequest(url: URL, params: Parameters, headers: HTTPHeaders, completionHandler: @escaping (_ json: JSONhttp) -> Void){
        Alamofire.request(url ,method: .get ,parameters: params, headers: headers).responseJSON(completionHandler: { (resp: DataResponse<Any>) in
            var requestResponse: JSONhttp = JSONhttp()

            if resp.result.value != nil{
                //Se parsea la respuesta en caso de que se pueda acceder al servidor y se devuelve
                let json = resp.result.value as! NSDictionary
                requestResponse = JSONhttp(json: json as! [String : Any])
                completionHandler(requestResponse)
            }else{
                //En caso de que la llamada no funcione se devuelve un mensaje estandarizado
                completionHandler(JSONhttp(code: 419, message: "No se ha podido conectar con el servidor, pruebe mas tarde", data: [:]) )
            }
        })
    }
    
    //Petición post estandarizada, necesita recibir url en formato URL, parametros como [String: Any] y headers como [String: String]
    func makePostRequest(url: URL, params: Parameters, headers: HTTPHeaders, completionHandler: @escaping (_ json: JSONhttp) -> Void){
        Alamofire.request(url ,method: .post ,parameters: params, headers: headers).responseJSON(completionHandler: { (resp: DataResponse<Any>) in
            var requestResponse: JSONhttp = JSONhttp()
            
            if resp.result.value != nil{
                //Se parsea la respuesta en caso de que se pueda acceder al servidor y se devuelve
                let json = resp.result.value as! NSDictionary
                requestResponse = JSONhttp(json: json as! [String : Any])
                completionHandler(requestResponse)
            }else{
                //En caso de que la llamada no funcione se devuelve un mensaje estandarizado
                completionHandler(JSONhttp(code: 419, message: "No se ha podido conectar con el servidor, pruebe mas tarde", data: [:]) )
            }
        })
    }
}
