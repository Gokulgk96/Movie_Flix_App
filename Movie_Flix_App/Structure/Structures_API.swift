//
//  Structures_API.swift
//  Movie_Flix_App
//
//  Created by Gokul Gopalakrishnan on 14/12/21.
//

import Foundation

struct movie_details : Codable
{
    
    var results : [Results]
}


struct Results : Codable
{
    var backdrop_path: String
    var original_title: String
    var overview: String
    var poster_path: String
    var release_date: String
    var title: String
    var vote_average: Double
 
}

 
var search_detail = [articles]()

struct articles
{
    var index_path: Int
    var title: String
    var image: String
    
    init(index_path: Int, title:String, image: String)
    {
        self.index_path = index_path
        self.title = title
        self.image = image
    }
}

 
