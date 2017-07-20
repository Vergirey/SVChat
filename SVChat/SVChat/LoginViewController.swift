//
//  LoginViewController.swift
//  SVChat
//
//  Created by Julia Kolbina on 20.07.17.
//  Copyright © 2017 Sergey Volkov. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn:Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        
        // Flip the boolean
        isSignIn = !isSignIn
        
        // Check the bool and set the button and labels
        if isSignIn {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        } else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
        
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        // TODO: Do some from validation on the email and password
        
        if let email = emailTextField.text, let pass = passwordTextField.text {
            
            // Check if it's sign in or regester
            if isSignIn {
                // Sign In the user with Firebase
                FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
                    
                    // Check that user isn't nil
                    if user != nil {
                        // User is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                        
                    } else {
                        // Error: check error and show message
                    }
                })
                
            } else {
                // Regester the user with Firebase
                FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
                    
                    // Check that user isn't nil
                    if user != nil {
                        // User is found? go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                        
                    } else {
                        // Error: check error and show message
                    }
                })
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // dismiss the keybord when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}
