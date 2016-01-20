//
//  Movie.swift
//  TopMovies
//
//  Created by William Chang on 1/18/16.
//  Copyright © 2016 GA Student. All rights reserved.
//

import UIKit

class Movie{
    var titleString: String!
    var directorString: String!
    var summaryString: String!
    var posterImageURL: NSURL!
    
    init(titleString:String, directorString:String, summaryString:String, posterImageURL:NSURL){
        self.titleString = titleString
        self.directorString = directorString
        self.summaryString = summaryString
        self.posterImageURL = posterImageURL
    }
}
