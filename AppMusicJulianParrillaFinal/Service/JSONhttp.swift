//
//  JSONhttp.swift
//  AppMusicJulianParrillaFinal
//
//  Created by alumnos on 8/2/18.
//  Copyright © 2018 julianparrilla. All rights reserved.
//

import UIKit

class JSONhttp: NSObject {
    var code: Int = 0
    var message: String = ""
    var data: [String: Any] = [:]
    override init() {
        //Solo se inicializa el objeto
    }
    
    init(json: [String: Any]) {
        //Se inicializa un objeto recibiendo un diccionario json
        code = json["code"] as! Int
        message = json["message"] as! String
        data = json["data"] as? [String: Any] ?? [:]
    }
    
    init(code: Int, message: String, data: [String: Any]) {
        //Se inicializa el objeto con los parametros del objeto
        self.code = code
        self.message = message
        self.data = data
    }
    
}
