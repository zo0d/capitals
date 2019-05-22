//
//  Capital.swift
//  capitals
//
//  Created by BJ on 2019-05-21.
//  Copyright © 2019 BJ. All rights reserved.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var url: URL
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, url: URL) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.url = url
    }
}
