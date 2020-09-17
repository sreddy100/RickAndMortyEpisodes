//
//  ViewController.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//

import UIKit
import SystemConfiguration
import CoreData


//MARK:- EpisodesViewController
class EpisodesViewController: UIViewController, Storyboarded {
    private let reachability = SCNetworkReachabilityCreateWithName(nil, Constants.DatabaseKey.website)
    var evm = EpisodesViewModel()
    weak var coordinator : MainCoordinator?
    @IBOutlet weak var tableView: UITableView!
    var offlineEpisodes : [NSManagedObject] = []
    
    //MARK:- View Controller LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.EpisodesPageTitle
        
        //check Internet
        checkReachable() ? getDataFromAPI() : getFromCoreData()
        
        
    }
}

//MARK:- Table View Data Source
extension EpisodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkReachable() ? evm.getArrayCount() : offlineEpisodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell) else{return UITableViewCell()}
        if checkReachable() {
            let episodeObj = evm.getIndexOfArray(indexPath.row)
            cell.textLabel?.text = episodeObj.name
        }else{
            cell.textLabel?.text = offlineEpisodes[indexPath.row].value(forKey: Constants.DatabaseKey.name
                ) as? String
        }
        return cell
    }
}

//MARK:- TableView Delegate

extension EpisodesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //passing data to the next view controller
        if checkReachable() {
            let episodeModel = evm.getIndexOfArray(indexPath.row)
            coordinator?.pushToCharacters(episodeModel)
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        //pagination
        if indexPath.row > evm.getArrayCount() - 2 && checkReachable(){
            self.evm.pageNum += 1
            getDataFromAPI()
        }
    }
    
}

//MARK:- Fetching Functionality & Reachability
extension EpisodesViewController {
    
    func getFromCoreData() {
        let managedContext =
            DatabaseManager.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.DatabaseManager.episodeEntity)
        
        do {
            offlineEpisodes = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getDataFromAPI() {
        evm.getData(self.evm.pageNum, Episodes.self) { (_, _, _) in
            DispatchQueue.main.async {
                //refresh table after retrieving data
                self.tableView.reloadData()
            }
            
        }
    }
    
    private func checkReachable() -> Bool{
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(self.reachability!, &flags)
        if isNetworkReachable(with: flags) {
            return true
        }
        return false
    }
    
    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
}

