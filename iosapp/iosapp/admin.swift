//
//  admin.swift
//  iosapp
//
//  Created by Dwicky Fauza on 11/28/19.
//  Copyright © 2019 IOSLOSS. All rights reserved.
//

import UIKit

class admin: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var id: Int!
    var nama: String!
    var kategori: String!
    var stok: Int!
    var harga: Double!
    
    @IBOutlet weak var tabelfurnitur: UITableView!
    let cellReuseIdentifier = "cell"
    
    var db:DBHelper = DBHelper()
    
    var furnitur:[Furnitur] = []
    
    var selectedFurniture: Int = 1
    override func viewDidLoad() {
        
        super.viewDidLoad()
            tabelfurnitur.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tabelfurnitur.delegate = self
        tabelfurnitur.dataSource = self
        
        furnitur = db.read()
        db.read()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Masukkan Data", message: nil, preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Tambah", style: .default) { (_) in
            
            //getting the input values from user
            let id = alertController.textFields?[0].text!
            let nama = alertController.textFields?[1].text!
            let kategori = alertController.textFields?[2].text!
            let stok = alertController.textFields?[3].text!
            let harga = alertController.textFields?[4].text!
            
            self.db.insert(id: Int(id!)!, nama: nama!, kategori: kategori!, stok: Int(stok!)!, harga: Double(harga!)!)
            self.viewDidLoad()
            self.viewDidLoad()
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Id "
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Nama Barang"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Kategori"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Stok"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Harga"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showEditDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Masukkan Data", message: nil, preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Edit", style: .default) { (_) in
            
            //getting the input values from user
            let id = alertController.textFields?[0].text!
            let nama = alertController.textFields?[1].text!
            let kategori = alertController.textFields?[2].text!
            let stok = alertController.textFields?[3].text!
            let harga = alertController.textFields?[4].text!
            
            self.db.editData(nama: nama!, kategori: kategori!, stok: Int(stok!)!, harga: Double(harga!)!, id: Int(id!)!)
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.text = String(self.id)
        }
        alertController.addTextField { (textField) in
            textField.text = self.nama
        }
        alertController.addTextField { (textField) in
            textField.text = self.kategori
        }
        alertController.addTextField { (textField) in
            textField.text = String(self.stok)
        }
        alertController.addTextField { (textField) in
            textField.text = String(self.harga)
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func tambahButton(_ sender: Any) {
        showInputDialog()
    }
    
    @IBAction func hapusButton(_ sender: Any) {
        let id = self.id
        self.db.deleteByID(id: Int(id!))
    }
    
    @IBAction func editButton(_ sender: Any) {
        showEditDialog()
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
        
        cell.textLabel?.text = "  " + String(furnitur[indexPath.row].id) + "   ||   " + "" + furnitur[indexPath.row].nama + "  ||  " + "" + furnitur[indexPath.row].kategori + "  ||   " + "" + String(furnitur[indexPath.row].stok) + "  || " + String(furnitur[indexPath.row].harga)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        id = furnitur[indexPath.row].id
        nama = String(furnitur[indexPath.row].nama)
        kategori = String(furnitur[indexPath.row].kategori)
        stok = furnitur[indexPath.row].stok
        harga = furnitur[indexPath.row].harga
        
        selectedFurniture = indexPath.row
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        viewDidLoad()
    }
}
