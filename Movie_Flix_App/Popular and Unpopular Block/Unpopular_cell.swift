//
//  Unpopular_cell.swift
//  Movie_Flix_App
//
//  Created by Gokul Gopalakrishnan on 15/12/21.
//

import UIKit



protocol UnPopular_Category_delegate: AnyObject
{
    func did_tapping_button(with index: Int)
}


class Unpopular_cell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var Unpopular_image: UIImageView!
    
    @IBOutlet weak var Title_Label: UILabel!
    
    @IBOutlet weak var Description_Label: UILabel!
    
    @IBOutlet weak var UnPopular_button: UIButton!
    
    var delegates: UnPopular_Category_delegate!
    private var index_path_work: Int = 0
    
    private let imagecache = NSCache<AnyObject, UIImage>()
    
    @IBAction func Unpopular_button_Tap(_ sender: Any) {
        
        delegates?.did_tapping_button(with: index_path_work)
    }
    
    
    func Unpopular_Set(images: String, title: String, Description: String, index: Int)
    {
        self.Unpopular_image.image = UIImage(named: "Loading_image")

        self.index_path_work = index
        
        Title_Label.text = title
        Description_Label.text = Description
        
        Unpopular_image.layer.cornerRadius = 20
        
        let newurl = "https://image.tmdb.org/t/p/w342" + images
        
        
        //caching the images from the local for popular and unpopular
        
        if let cachedImages = self.imagecache.object(forKey: newurl as AnyObject)
        {
            print("from cached images")
            self.Unpopular_image.image = cachedImages
            return
        }
        
        
        
        let link = URL(string: newurl)
        
        DispatchQueue.global().async {
            
            if let imagedata = try? Data(contentsOf: link!)
            {
                if let images = UIImage(data: imagedata)
                {
                
                DispatchQueue.main.async {
                    self.imagecache.setObject(images, forKey: newurl as AnyObject)
                    self.Unpopular_image.image = UIImage(data: imagedata)
                                        }
                }
            }
        }
        
    }
    
}


