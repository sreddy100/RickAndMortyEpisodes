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
    let cvm = CharacterViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var episodeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = results?.name
        nameLabel.text = results?.airDate
        episodeLabel.text = results?.episode
        
    }
    


}

extension CharacterViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
        let obj = results?.characters?[indexPath.row] ?? ""
        cvm.getCharacters(obj) { (_, _, _) in
            DispatchQueue.main.async {
//                cell.textLabel?.text = self.cvm.getIndexOfArr(indexPath.row).name
                self.tableView.reloadData()
            }
        }
        
        cell.textLabel?.text =  obj
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "CharacterDetailViewController") as? CharacterDetailViewController else {return}
        
        vc.character = cvm.getIndexOfArr(indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
