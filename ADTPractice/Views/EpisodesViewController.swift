//
//  ViewController.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//

import UIKit
import SystemConfiguration

//MARK:- EpisodesViewController
class EpisodesViewController: UIViewController, Storyboarded {
    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")
    var evm = EpisodesViewModel()
    weak var coordinator : MainCoordinator?
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- View Controller LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.EpisodesPageTitle
        //check Internet
        checkReachable()
        //getting initial Data
        getDataFromAPI()
    }
}

//MARK:- Table View Data Source
extension EpisodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evm.getArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell) else{return UITableViewCell()}
        let obj = evm.getIndexOfArray(indexPath.row)
        cell.textLabel?.text = obj.name
        
        return cell
    }
}

//MARK:- TableView Delegate

extension EpisodesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //passing data to the next view controller
        let episodeModel = evm.getIndexOfArray(indexPath.row)
        coordinator?.pushToCharacters(episodeModel)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        //pagination
        if indexPath.row > evm.getArrayCount() - 2{
            self.evm.pageNum += 1
            getDataFromAPI()
        }
    }
    
}

//MARK:- Fetching Functionality & Reachability
extension EpisodesViewController {
    func getDataFromAPI() {
        evm.getData(self.evm.pageNum, Episodes.self) { (_, _, _) in
            DispatchQueue.main.async {
                //refresh table after retrieving data
                self.tableView.reloadData()
            }
            
        }
    }
    
    private func checkReachable() {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(self.reachability!, &flags)
        if isNetworkReachable(with: flags) {
            if flags.contains(.isWWAN){
                self.alert(message: "available via mobile", title: "Reachable!")
                return
            }
            self.alert(message: "available via wifi", title: "Reachable!")
        }else if(!isNetworkReachable(with: flags)) {
            self.alert(message: "Sorry no connection", title: "Unreachable")
            return
        }
    }
    
    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
}

