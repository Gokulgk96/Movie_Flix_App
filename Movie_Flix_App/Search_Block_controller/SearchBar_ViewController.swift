//
//  SearchBar_ViewController.swift
//  Movie_Flix_App
//
//  Created by Gokul Gopalakrishnan on 15/12/21.
//

import UIKit

class SearchBar_ViewController: UIViewController {
    @IBOutlet weak var Search_Bar_field: UITextField!
    @IBOutlet weak var Collection_view: UICollectionView!
    
    var query = ""
    var text_value = ""
    var filtered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    


}

extension SearchBar_ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate
{
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        search_detail.removeAll()
        
        if let text = Search_Bar_field.text
        {
           text_value = text
           if (string == "")
           {
            query = text+string
            query.removeLast()
           }
           else
           {
           query = text+string
           }
            
            filtered = true
        }
        
    
        for (i,strings) in apicaller.results.enumerated()
        {
            if(strings.title.uppercased().starts(with: query.uppercased()) )
            {
                search_detail.append(articles(index_path: i, title: strings.title, image: strings.poster_path))
            }
        }
 
        print(search_detail)
        
        Collection_view.reloadData()
        
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let vc2 = storyboard?.instantiateViewController(identifier: "Selected_VC") as? Selected_movie_controller
        
           if(!filtered)
                {
                    vc2?.index_path = indexPath.row
                }
                else
                {
                    vc2?.index_path = search_detail[indexPath.row].index_path
                }
     
       
       
       self.navigationController?.pushViewController(vc2!, animated: true)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
        if(!filtered)
        {
            return apicaller.results.count
        }
        else
        {
            return search_detail.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Search_Cell", for: indexPath) as! Search_CollectionViewCell
       
        
        cell.layer.borderWidth = 2
       
        cell.layer.cornerRadius = 50
        
        cell.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
      
        
        if(!filtered)
        {
            cell.set_search_panel(image: apicaller.results[indexPath.row].poster_path, label: apicaller.results[indexPath.row].title)
    
        }else
        {
            cell.set_search_panel(image: search_detail[indexPath.row].image, label: search_detail[indexPath.row].title)
        }
        
        
        
        
        return cell
        
    }
    
    
}
