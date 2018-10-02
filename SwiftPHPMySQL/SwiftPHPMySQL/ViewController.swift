//
//  ViewController.swift
//  SwiftPHPMySQL
//
//  Created by My Computer on 2018-02-23.
//  Copyright © 2018 My Computer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //URL to our web service
    let URL_SAVE_TEAM = "http://MyWebService/api/createteam.php"
    
    
    //TextFields declarations
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldMember: UITextField!
    
    
    //Button action method
    @IBAction func buttonSave(sender: UIButton) {
        
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //getting values from text fields
        let teamName=textFieldName.text
        let memberCount = textFieldMember.text
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "name="+teamName!+"&member="+memberCount!;
        
        //adding the parameters to request body
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(error)")
                return;
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    
                    //printing the response
                    print(msg)
                    
                }
            } catch {
                print(error)
            }
            
        }
        //executing the task
        task.resume()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

