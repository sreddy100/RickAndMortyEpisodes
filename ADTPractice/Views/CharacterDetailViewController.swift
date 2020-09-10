//
//  CharacterDetailViewController.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//

import UIKit
import SDWebImage

//MARK:- Character Detail View Controller
class CharacterDetailViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    weak var coordinator : MainCoordinator?

    var character : Characters?
    
    //MARK:- View Controller LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setCharacterValues()
        
    }
    
    func setCharacterValues() {
        characterName.text = character?.name
        genderLabel.text = character?.gender
        speciesLabel.text = character?.species
        statusLabel.text = character?.status
        
        if let urlImage = character?.image {
            characterImageView.sd_setImage(with: URL(string: urlImage), placeholderImage: UIImage(named: Constants.placeholder))
            
        }
        
        
    }
}
