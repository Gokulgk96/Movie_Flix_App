//
//  Popular_Category.swift
//  Movie_Flix_App
//
//  Created by Gokul Gopalakrishnan on 15/12/21.
//

import UIKit



protocol Popular_Category_delegate: AnyObject
{
    func did_tap_button(with index: Int)
}


class Popular_Category: UICollectionViewCell {
    
    weak var delegate : Popular_Category_delegate?
    
    @IBOutlet weak var Popular_Image: UIImageView!
    
    @IBOutlet weak var Popular_Button: UIButton!
   
    private let imagecache = NSCache<AnyObject, UIImage>()
    
    private var index_path_work: Int = 0
    
    @IBAction func Popular_Button_Action(_ sender: Any) {
         
        delegate?.did_tap_button(with: index_path_work)

    }
    
    
    func Popular_Set(images: String, index_path: Int)
    {
        
        self.Popular_Image.image = UIImage(named: "Loading_image")
        self.index_path_work = index_path
        
        Popular_Image.layer.cornerRadius = 20

        let newurl = "https://image.tmdb.org/t/p/w342" + images
        
        
        
   //caching the images from the local for popular and unpopular
        
        if let cachedImages = self.imagecache.object(forKey: newurl as AnyObject)
        {
            print("from cached images")
            self.Popular_Image.image = cachedImages
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
                    self.Popular_Image.image = UIImage(data: imagedata)
                                         }
                }
            }
        }
        
      
    }
    
}
