//
//  ViewController.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var hvm = HomeViewModel()
    var pageNum = 1
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Rick and Morty Episodes"
        
        hvm.getData(pageNum, Episodes.self) { (_, _, _) in
            DispatchQueue.main.async {
                //refresh table after retrieving data
                self.tableView.reloadData()
            }
            
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hvm.getArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
        let obj = hvm.getIndexOfArray(indexPath.row)
        cell.textLabel?.text = obj.name
        
        if hvm.getArrayCount() - 2 < indexPath.row {
            pageNum += 1
            hvm.getData(pageNum, Episodes.self) { (_, _, _) in
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = hvm.getIndexOfArray(indexPath.row)
        guard let vc = storyboard?.instantiateViewController(identifier: "CharacterViewController") as? CharacterViewController else{return}
        
        vc.results = obj
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}

