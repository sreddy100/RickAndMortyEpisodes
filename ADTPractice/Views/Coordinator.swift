//
//  Coordinator.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Coordinated Design Pattern
protocol Coordinator {
    var childCoordinators : [Coordinator] {get set}
    var navigationController : UINavigationController {get set}
    
    func start()
}

//MARK:- Main Coordinator
class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = EpisodesViewController.instantiate()
        vc.coordinator = self
        navigationController.viewControllers = [vc]
    }
    
    func pushToCharacters(_ model: Episodes) {
        let vc = CharacterViewController.instantiate()
        vc.coordinator = self
        vc.results = model
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushToDetails(_ charModel: Characters) {
        let vc = CharacterDetailViewController.instantiate()
        vc.coordinator = self
        vc.character = charModel
        navigationController.pushViewController(vc, animated: true)
    }
}
