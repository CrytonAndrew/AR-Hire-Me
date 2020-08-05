//
//  RegisterViewController.swift
//  AR HIreApp
//
//  Created by Cryton Sibanda on 2020/07/31.
//  Copyright © 2020 Cryton Sibanda. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

      @IBOutlet weak var firstNameTextField: UITextField!
        
        @IBOutlet weak var lastNameTextField: UITextField!
        
        @IBOutlet weak var emailTextField: UITextField!
        
        @IBOutlet weak var passwordTextField: UITextField!
        
        @IBOutlet weak var registerButton: UIButton!
        
        @IBOutlet weak var errorText: UILabel!
        
        enum Tabs:Int {
            case Dashboard
            case Middle
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            navigationController?.setNavigationBarHidden(false, animated: true)
            setupPage()
        }
        
        func setupPage() {
            errorText.alpha = 0;
            
            Utilities.styleTextField(firstNameTextField)
            Utilities.styleTextField(lastNameTextField)
            Utilities.styleTextField(emailTextField)
            Utilities.styleTextField(passwordTextField)
            
            Utilities.styleFilledButton(registerButton)
        }
        

        
        
        @IBAction func registerPressed(_ sender: UIButton) {
            let error = validateFields()
            
            if error != nil {
                printErrorMessage(error!)
            }
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName  = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.printErrorMessage("User already exists")
                }
                else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["first_name": firstName, "last_name": lastName, "uid": result!.user.uid]) {
                        (error) in
                        if error != nil {
                            self.printErrorMessage("Failed to adding to database")
                        }
                    }
                    self.navigateToHome()
                }
            }
            
        }
        
        
        func navigateToHome() {
            let mainTabController = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
                 mainTabController.selectedViewController = mainTabController.viewControllers?[0]
                 mainTabController.modalPresentationStyle = .fullScreen
                 present(mainTabController, animated: true, completion: nil)
        }
        
        func printErrorMessage(_ error: String){
               errorText.alpha = 1
               errorText.text = error
           }
        
        func validateFields() -> String? {
            //Check all feilds filled
            let name = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let surname = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            if name == "" || surname == "" || email == "" || password == "" {
                return "Please fill in all fields"
            }
            
            //Check if password is valid
            if Utilities.isPasswordValid(password!) == false{
                return "Please make sure password is atleast 8 characters and comtains any special characters and numerics"
            }
            
            return nil
        }
        

    }
