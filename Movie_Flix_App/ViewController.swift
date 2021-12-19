//
//  ViewController.swift
//  Movie_Flix_App
//
//  Created by Gokul Gopalakrishnan on 14/12/21.
//

import UIKit

 
var apicaller: movie_details = movie_details.init(results: [])


class ViewController: UIViewController {

    @IBOutlet weak var Search_icon: UIBarButtonItem!
    
    @IBOutlet weak var Collection_view: UICollectionView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie Flix"
        
        Search_icon.tintColor = .systemRed
        
        Collection_view.isEditing = true
        
        JsonDownloader{
             
            self.Collection_view.reloadData()
          
         }
        
        
       
       
    }

    
    func JsonDownloader(completed: @escaping () -> ())
    {
            
    let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!


      let task = URLSession.shared.dataTask(with: url)
                {
                    data, response, error in
                    
                    if let data = data
                    {
                        do
                        {
                            apicaller = try JSONDecoder().decode(movie_details.self, from: data)
                            
                            DispatchQueue.main.async {
                
                                completed()
                            }
                        }catch
                        {
                            print("Error")
                            print(error.localizedDescription)
                        }
                    }
                }
            
                task.resume()
       
    
            
    }
    


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        apicaller.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let Popularcell = collectionView.dequeueReusableCell(withReuseIdentifier: "popular", for: indexPath) as! Popular_Category
        
        let Unpopularcell = collectionView.dequeueReusableCell(withReuseIdentifier: "unpopular", for: indexPath) as! Unpopular_cell
        
        
        if ( apicaller.results[indexPath.row].vote_average >= 7.0)
        {
            
            
            Popularcell.Popular_Set(images: apicaller.results[indexPath.row].backdrop_path, index_path: indexPath.row)
            
            Popularcell.delegate = self
           
            return Popularcell
            
            
        }else
        {
            
            Unpopularcell.Unpopular_Set(images: apicaller.results[indexPath.row].poster_path, title: apicaller.results[indexPath.row].title, Description: apicaller.results[indexPath.row].overview, index: indexPath.row)
            
            Unpopularcell.delegates = self
            
            return Unpopularcell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
      
        
        
         let vc2 = storyboard?.instantiateViewController(identifier: "Selected_VC") as? Selected_movie_controller
        vc2?.index_path = indexPath.row
        
        
        self.navigationController?.pushViewController(vc2!, animated: true)
   

    
    }
    
}


extension ViewController: Popular_Category_delegate, UnPopular_Category_delegate
{
    func did_tap_button(with index: Int) {
        
       
        apicaller.results.remove(at: index)
        
        Collection_view.reloadData()
        
         
        
    }
    
    func did_tapping_button(with index: Int) {
        
        apicaller.results.remove(at: index)
        
        Collection_view.reloadData()
    }
    
    
}
