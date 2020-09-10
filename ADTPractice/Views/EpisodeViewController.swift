//
//  EpisodeViewController.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    var results : Episodes?
    let evm = CharacterViewModel()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


}

extension CharacterViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
        
        evm.getCharacters(results?.characters?[indexPath.row] ?? "") { (_, _, _) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        cell.textLabel?.text = evm.getIndexOfArr(indexPath.row).
        
        return cell
    }
    
    
}
