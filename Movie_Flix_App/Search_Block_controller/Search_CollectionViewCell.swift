//
//  Search_CollectionViewCell.swift
//  Movie_Flix_App
//
//  Created by Gokul Gopalakrishnan on 15/12/21.
//

import UIKit

class Search_CollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var Search_Image_Block: UIImageView!
    
    @IBOutlet weak var Search_Label_Block: UILabel!
    
    func set_search_panel(image: String, label: String)
    {
        Search_Image_Block.image = UIImage(named: "Loading_image")
        
        let newurl = "https://image.tmdb.org/t/p/w342" + image
        
        let link = URL(string: newurl)
        
        DispatchQueue.global().async {
            
            if let imagedata = try? Data(contentsOf: link!)
            {
                DispatchQueue.main.async {
                    self.Search_Image_Block.image = UIImage(data: imagedata)
                                         }
            }
        }

        
        
        Search_Label_Block.text = label
        
    }
}
