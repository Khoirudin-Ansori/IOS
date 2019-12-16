//
//  user.swift
//  iosapp
//
//  Created by Dwicky Fauza on 11/28/19.
//  Copyright © 2019 IOSLOSS. All rights reserved.
//

import UIKit

class user: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var id: Int = 0
    var nama: String = ""
    var kategori: String = ""
    var stok: Int = 0
    var harga: Double = 0
    
    @IBOutlet weak var tabeluser: UITableView!
    let cellReuseIdentifier = "cell"
    
    var db:DBHelper = DBHelper()
    
    var furnitur:[Furnitur] = []
    
    var selectedFurniture: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tabeluser.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tabeluser.delegate = self
        tabeluser.dataSource = self
        
        furnitur = db.read()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return furnitur.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        
        cell.textLabel?.text =  " " + furnitur[indexPath.row].nama + "  ||  " + "" + furnitur[indexPath.row].kategori + "  ||   " + "" + String(furnitur[indexPath.row].stok) + "  ||  " + String(furnitur[indexPath.row].harga)
        
        return cell
        
    }

}
