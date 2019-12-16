//
//  login.swift
//  iosapp
//
//  Created by Dwicky Fauza on 11/28/19.
//  Copyright © 2019 IOSLOSS. All rights reserved.
//

import UIKit

class login: UIViewController {

@IBOutlet weak var usename: UITextField!
    @IBOutlet weak var password: UITextField!
    var db:DBHelper = DBHelper() //inisialisasi db
    var users:[Admins] = [] //memanggil table users
    override func viewDidLoad() {
        super.viewDidLoad()
        db.readadmin()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func register(_ sender: UIButton) {
        performSegue(withIdentifier: "Register", sender: nil)

    }
    
    @IBAction func login(_ sender: UIButton) {
        
        let user: String = usename.text!
        let pass: String = password.text!
        
        if user.isEmpty || pass.isEmpty {
            showAlert(Title: "Peringatan", Message: "Mohon untuk diisi Nama dan Katasandi")
        }
        
        let masuk = db.readadmin(username: user, password: pass)
        if masuk.count > 0 {
            performSegue(withIdentifier: "Admin", sender: self)
        }else {
            showAlert(Title: "Peringatan", Message: "Nama dan Katasandi salah")
        }
            //let user: String = usename.text!
//            let pass: String = password.text!
//            
//            if user.isEmpty || pass.isEmpty{
//                showAlert(Title: "Peringatan", Message: "Mohon untuk diisi keduanya ")
//            }
//            
//            if user == "Admin" && pass == "123"{
//                performSegue(withIdentifier: "adminSegue", sender: self)
//            }
//            else{
//                showAlert(Title: "Informasi", Message: "Username atau password salah")
//        }
    }
    func showAlert(Title title: String, Message message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        present(alertController, animated: true , completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Admin" {
            let _: admin = segue.destination as! admin
        }else if segue.identifier == "Register" {
            let _: register = segue.destination as! register
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
