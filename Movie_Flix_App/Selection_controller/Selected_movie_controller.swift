//
//  Selected_movie_controller.swift
//  Movie_Flix_App
//
//  Created by Gokul Gopalakrishnan on 15/12/21.
//

import UIKit

class Selected_movie_controller: UIViewController {

    @IBOutlet weak var Image_Block: UIImageView!
    @IBOutlet weak var Title_Block: UILabel!
    @IBOutlet weak var Release_Date_Block: UILabel!
    @IBOutlet weak var Description_Block: UILabel!
    
    
    var index_path: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        
        Title_Block.text = apicaller.results[index_path!].title
        Release_Date_Block.text = apicaller.results[index_path!].release_date
        Description_Block.text = apicaller.results[index_path!].overview
        
    
        
            let newurl = "https://image.tmdb.org/t/p/w342" + apicaller.results[index_path!].backdrop_path
            

            let link = URL(string: newurl)
            
            DispatchQueue.global().async {
                
                if let imagedata = try? Data(contentsOf: link!)
                {
                    DispatchQueue.main.async {
                        self.Image_Block.image = UIImage(data: imagedata)
                                             }
                }
            }
     
    }
    

}
