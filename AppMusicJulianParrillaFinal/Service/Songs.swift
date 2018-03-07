//
//  Songs.swift
//  AppMusicJulianParrillaFinal
//
//  Created by alumnos on 7/3/18.
//  Copyright © 2018 julianparrilla. All rights reserved.
//

import UIKit

class Songs{
    var id: String = ""
    var nameArtist: String = ""
    var nameSong: String = ""
    var playsCount: String = ""
    var urlSong: String = ""
    
    init(song: [String: Any]) {
        id = song["id"] as! String
        nameArtist = song["nameArtist"] as! String
        nameSong = song["nameSong"] as! String
        playsCount = song["playsCount"] as! String
        urlSong = song["urlSong"] as! String
    }
    /*
    init(id: Int, nameArtist: String, nameSong: String, playsCount: Int, urlSong: String) {
        self.id = id
        self.nameArtist = nameArtist
        self.nameSong = nameSong
        self.playsCount = playsCount
        self.urlSong = urlSong
    }
    */
}

