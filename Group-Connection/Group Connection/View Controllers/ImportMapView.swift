//
//  ImportMapView.swift
//  Group Connection
//
//  Created by Daniel Naranjo on 2/6/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit

class ImportMapView: UIViewController {
    
    @IBOutlet weak var importMap: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let bibbity = Globals.globals.event.importedMap
            importMap.image = bibbity
        }
        catch {
            print("image got messed up. sorry.")
        }
    }
}
