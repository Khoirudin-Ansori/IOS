//
//  Furnitur.swift
//  iosapp
//
//  Created by Dwicky Fauza on 11/28/19.
//  Copyright © 2019 IOSLOSS. All rights reserved.
//

import Foundation
class Furnitur{
    var id:Int = 0
    var nama: String = ""
    var kategori: String = ""
    var stok : Int = 0
    var harga : Double = 0
    var username: String = ""
    var password: String = ""
    var iduser:Int = 0
    
    init(id:Int, nama:String, kategori:String, stok:Int, harga:Double) {
        self.id = id
        self.nama = nama
        self.kategori = kategori
        self.stok = stok
        self.harga = harga
    }
}
