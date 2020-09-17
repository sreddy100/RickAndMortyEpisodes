//
//  EpisodeViewController.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//

import UIKit

//MARK:- Character View Controller
class CharacterViewController: UIViewController, Storyboarded {
    var results : Episodes?
    let cvm = CharacterViewModel()
    weak var coordinator : MainCoordinator?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    
    //MARK:- ViewController Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = results?.name
        nameLabel.text = results?.airDate
        episodeLabel.text = results?.episode
    }
}

//MARK:- Table View Data Source
extension CharacterViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell) else {return UITableViewCell()}
        getNameFromURL(results?.characters?[indexPath.row], cell)
        return cell
    }
}

//MARK:- Table View Delegate
extension CharacterViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let charModel = cvm.getIndexOfArr(indexPath.row)
        coordinator?.pushToDetails(charModel)
    }
}

//MARK:- Getting API Info
extension CharacterViewController{

    func getNameFromURL(_ urlString: String?,_ cell: UITableViewCell){
        guard let retString = urlString else{return }
        cvm.getCharacters(retString) { (name, _, _) in
            DispatchQueue.main.async {
                cell.textLabel?.text = name as? String ?? Constants.notAvailable
            }
        }
    }
}

