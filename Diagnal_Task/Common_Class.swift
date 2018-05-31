//
//  Common_Class.swift
//  Diagnal_Task
//
//  Created by MacMini on 30/05/18.
//  Copyright © 2018 Noorul. All rights reserved.
//

import Foundation
import UIKit

let Movie_CellID = "MovieCellIdentifer"

struct Window {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}

func get_json_from_txt_file(fileName: String) -> NSDictionary {
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        do {
            let str_file_contents = try String(contentsOfFile: path, encoding: .utf8)
            let jsonData = str_file_contents.data(using: .utf8)!
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
            return json
        }
        catch {
            print(error)
        }
    }
    let dict = NSDictionary()
    return dict
}
