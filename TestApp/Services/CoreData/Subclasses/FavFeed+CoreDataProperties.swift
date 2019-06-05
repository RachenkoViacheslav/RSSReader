//
//  FavFeed+CoreDataProperties.swift
//  TestApp
//
//  Created by Вячеслав on 6/4/19.
//  Copyright © 2019 Вячеслав. All rights reserved.
//
//

import Foundation
import CoreData


extension FavFeed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavFeed> {
        return NSFetchRequest<FavFeed>(entityName: "FavFeed")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var pubDate: String?
    @NSManaged public var link: String?

}
