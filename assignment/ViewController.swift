//
//  ViewController.swift
//  assignment
//
//  Created by Ayush Varshney on 27/11/17.
//  Copyright © 2017 Ayush Varshney. All rights reserved.

import UIKit
import Foundation


var ImageCache=[URL:UIImage]()
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    final let url = URL(string: "http://www.json-generator.com/api/json/get/bUCKtZvePS?indent=2")
    
    private var actors = [Actor]()
    @IBOutlet var tableView: UITableView!
    
    @IBAction func projectbutton() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.layer.borderWidth = 2.0
        
        
        
        DispatchQueue.global(qos : .userInteractive).async {
            self.downloadJson()
        }
        
        //tableView.tableFooterView = UIView()
    }

    func downloadJson() {
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("something is wrong")
                return
            }
            print("downloaded")
            do
            {
                let decoder = JSONDecoder()
                let downloadedActors = try decoder.decode(Actors.self, from: data)
                self.actors = downloadedActors.actors
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("something wrong after downloaded")
            }
        }.resume()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
      return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActorCell") as? ActorCell else { return UITableViewCell() }
        
       
        
        
        if let imageURL = URL(string: actors[indexPath.row].image) {
            if let image=ImageCache[imageURL]{
                cell.imgView.image=image
            }
            else{
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imgView.image = image
                    }
                    
                }
                }
            }
        }
        cell.nameLbl.text = /*"Name: " +*/ actors[indexPath.row].name
        cell.DOBLbl.text = /*"Description: " +*/ actors[indexPath.row].description
        print("Hello WOrld")
        print(ImageCache)
        
        
        
        return cell
    }
}

