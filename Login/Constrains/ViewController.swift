//
//  ViewController.swift
//  Constrains
//
//  Created by Eric Rojas Pech on 26/11/23.
//

import UIKit
import Lottie
import Firebase


class ViewController: UIViewController {

    @IBOutlet weak var accederButton: UIButton!
    
    @IBOutlet weak var usuarioField: UITextField!
    
    @IBOutlet weak var contraseñaField: UITextField!
    
    @IBOutlet weak var mostrarContraseña: UIButton!
    
    
    @IBOutlet weak var animationView: UIView!
    
    let apiController = APIController()

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.destination is TableViewController else {return}
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accederButton.isEnabled = false
        animationProfile()
        getData()
        getBatteryInfo()
        
    }
    
 
    @IBAction func usernameTyped(_ sender: Any) {
        validateIfButtonShouldBeEnabled(user: usuarioField.text, password: contraseñaField.text)
    }
    
    @IBAction func contraseñatyped(_ sender: UITextField) {
        validateIfButtonShouldBeEnabled(user: usuarioField.text, password: contraseñaField.text)
    }
    
    func validateIfButtonShouldBeEnabled(user: String?, password: String?) {
        if (usuarioField.text == "" || contraseñaField.text == ""){
            accederButton.isEnabled = false
        }else{
            accederButton.isEnabled = true

        }
    }
    
    
    
    @IBAction func passwordShow(_ sender: UIButton) {
        if contraseñaField.isSecureTextEntry{
            contraseñaField.isSecureTextEntry = false
            sender.setTitle("Ocultar contraseña", for: .normal)
        }else{
            contraseñaField.isSecureTextEntry = true
            sender.setTitle("Mostrar contraseña", for: .normal)
        }
    }

    
    @IBAction func accederPreseed(_ sender: UIButton) {
        let user = apiController.users[0]

        if usuarioField.text == user.login.username && contraseñaField.text == user.login.password {
        }else{
            let alert = UIAlertController(title: "Error", message: "Username or password is incorrect", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert,animated: true)
        }
        
    }
    
    func getData(){
        apiController.getUsers { (error) in
            if let error = error{
                print("Error performing datatask \(error)")
            }
        }
    }
    
    func animationProfile(){
        let subAnimationView = LottieAnimationView(name: "animation_profile")
            subAnimationView.contentMode = .scaleAspectFit
            animationView.addSubview(subAnimationView)
            subAnimationView.frame = animationView.bounds
            subAnimationView.loopMode = .loop
            subAnimationView.play()
    }
    
    func getBatteryInfo(){
        if let localBatteryInfo = BatteryInfoManager.shared.getLocalBatteryInfo() {
                print("Local Battery Info: \(localBatteryInfo)")
            }
    }
    
}

