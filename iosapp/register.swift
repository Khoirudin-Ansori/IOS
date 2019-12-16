//
//  register.swift
//  iosapp
//
//  Created by Dwicky Fauza on 12/10/19.
//  Copyright © 2019 IOSLOSS. All rights reserved.
//

import UIKit

class register: UIViewController{
    @IBOutlet weak var usernametext: UITextField!
    @IBOutlet weak var passwordtext: UITextField!
    
    var db:DBHelper = DBHelper() //inisialisasi db
    var users:[Admins] = [] //memanggil table users

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnKembali(_ sender: Any) {
          dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        let username: String = usernametext.text!
        let password: String = passwordtext.text!
        
        db.insertAdmin(username: username, password: password)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vcregister: admin = segue.destination as! admin
    }
}
