//
//  EpisodesEntity+CoreDataProperties.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//
//

import Foundation
import CoreData


extension EpisodesEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EpisodesEntity> {
        return NSFetchRequest<EpisodesEntity>(entityName: Constants.DatabaseManager.episodeEntity)
    }

    @NSManaged public var airDate: String?
    @NSManaged public var characters: NSObject?
    @NSManaged public var created: String?
    @NSManaged public var episode: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var url: String?

}
