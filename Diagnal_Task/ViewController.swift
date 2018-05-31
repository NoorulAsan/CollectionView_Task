//
//  ViewController.swift
//  Diagnal_Task
//
//  Created by MacMini on 30/05/18.
//  Copyright © 2018 Noorul. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var lbl_header: UILabel!
    @IBOutlet var collection_View: UICollectionView!
    var arr_dispaly_values:NSMutableArray! = NSMutableArray()
    var isList2Loaded = false
    var isList3Loaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dict_json = (get_json_from_txt_file(fileName: "CONTENTLISTINGPAGE-PAGE1")).object(forKey: "page") as! NSDictionary
        let title_name = dict_json.object(forKey: "title") as! String
        print(title_name)
        lbl_header.text = title_name
        
        arr_dispaly_values = NSMutableArray()
        arr_dispaly_values = ItemsFetchFromJSONFILE(filename: "CONTENTLISTINGPAGE-PAGE1")
        collection_View.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func ItemsFetchFromJSONFILE(filename: String) -> NSMutableArray {
        let dict_json = (get_json_from_txt_file(fileName: filename)).object(forKey: "page") as! NSDictionary
        let arr_values = (dict_json.object(forKey: "content-items") as! NSDictionary).object(forKey: "content") as! NSArray
        let arr_test = arr_values.mutableCopy() as! NSMutableArray
        return arr_test
    }
    
    func LoadMoreContent() {
        var filename_str = "CONTENTLISTINGPAGE-PAGE2"
        if isList2Loaded == true {
            filename_str = "CONTENTLISTINGPAGE-PAGE3"
            isList3Loaded = true
        }
        isList2Loaded = true
        let list_val = ItemsFetchFromJSONFILE(filename: filename_str)
        arr_dispaly_values.addObjects(from: list_val as! [Any])
        print(arr_dispaly_values.count)
        DispatchQueue.main.async {
            self.collection_View.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_dispaly_values.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Movie_CellID, for: indexPath as IndexPath) as! CustomMovieCell
        /*for view in cell.view_Month.subviews {
            view.removeFromSuperview()
        }*/
        
        let dict_Movie = arr_dispaly_values.object(at: indexPath.row) as! NSDictionary
        cell.lbl_MovieName.text = dict_Movie.object(forKey: "name") as? String
        cell.lbl_MovieName.textColor = UIColor.white
        
        let img_name = dict_Movie.object(forKey: "poster-image") as? String
        let image_Show = UIImage(named: img_name!) ?? UIImage(named: "placeholder_for_missing_posters")
        cell.img_MovieName.image = image_Show
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screen_width = collection_View.frame.size.width
        let size_of_box = (screen_width-30) / 3
        if (Int(Window.screenWidth)%320 == 0) {
            return CGSize(width: size_of_box, height: size_of_box+70);
        }
        return CGSize(width: size_of_box, height: size_of_box+70);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastElement = arr_dispaly_values.count - 1
        if indexPath.row == lastElement  && (isList2Loaded == false || isList3Loaded == false) {
            self.LoadMoreContent()
        }
    }
}

