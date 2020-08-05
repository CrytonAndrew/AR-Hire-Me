//
//  LoginViewController.swift
//  AR HIreApp
//
//  Created by Cryton Sibanda on 2020/07/31.
//  Copyright © 2020 Cryton Sibanda. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
      @IBOutlet weak var emailTextField: UITextField!
        
        @IBOutlet weak var passwordTextField: UITextField!
        
        @IBOutlet weak var loginButton: UIButton!
        
        @IBOutlet weak var errorText: UILabel!
        
        enum Tabs: Int {
            case Dashboard
            case Middle
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationController?.setNavigationBarHidden(false, animated: true)
            setupPage()
        }
        
        func setupPage() {
            errorText.alpha = 0
            
            Utilities.styleFilledButton(loginButton)
            Utilities.styleTextField(emailTextField)
            Utilities.styleTextField(passwordTextField)
        }
        
        
        @IBAction func loginPressed(_ sender: UIButton) {
            let error = validateUserInput()
            
            if error != nil {
                printErrorMessage(message: error!)
            }
            else {
                let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                
                Auth.auth().signIn(withEmail: email!, password: password!) { (result, err) in
                    if err != nil {
                        self.printErrorMessage(message: "Incorrect fields")
                    }
                    else {
                        self.navigateHome()
                    }
                }
            }
            
        }
        
        func navigateHome() {
            let mainTabController = storyboard?.instantiateViewController(identifier: "MainTabBarController") as! MainTabBarController
            mainTabController.selectedViewController = mainTabController.viewControllers?[0]
            mainTabController.modalPresentationStyle = .fullScreen
            present(mainTabController, animated: true, completion: nil)
        }
        
        func validateUserInput() -> String? {
            let email  = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if email == "" || password == ""{
                return "Please fill in all fields"
            }
            
            return nil
        }
        
        func printErrorMessage(message: String) {
            errorText.alpha = 1
            errorText.text = "\(message)"
        }

        
    }
