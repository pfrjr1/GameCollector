//
//  ViewController.swift
//  GameCollector
//
//  Created by Peter Rooney on 5/1/17.
//  Copyright © 2017 Peter Rooney. All rights reserved.
//

import UIKit

class ViewController:
UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var games : [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    
    }
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
        do {
        
            games = try context.fetch(Game.fetchRequest())
            print(games)
        }catch {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let game = games[IndexPath.row]
        cell.textLabel?.text = game.title
        return cell
    }

}

