//
//  MovieListViewController.swift
//  
//
//  Created by William Chang on 1/11/16.
//
//

import UIKit

class MovieListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var movieListTableView: UITableView!
    var movies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieListTableView.delegate=self
        self.movieListTableView.dataSource=self
        self.title = "🔝🎞"
        
        let itunesURL = NSURL(string: "https://itunes.apple.com/us/rss/topmovies/limit=100/json")!
        NSURLSession.sharedSession().dataTaskWithRequest(NSURLRequest(URL: itunesURL)) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let moviesArray = json.valueForKeyPath("feed.entry") as? [NSDictionary]
                print("Yay! The Movies Downloaded! 🎉")
                self.movies = moviesArray
                self.movieListTableView.reloadData()
                
            }
            }.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies?.count ?? 0
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath)
        if let movieCell = cell as? MovieTableViewCell{
            movieCell.posterImageView.image=nil;
        }
        return cell
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let movieCell = cell as! MovieTableViewCell
        let titleString = self.titleStringForMovieAtIndex(indexPath.row)
        let directorString = self.directorStringForMovieAtIndex(indexPath.row)
        let summaryString = self.summaryStringForMovieAtIndex(indexPath.row)
        
        movieCell.titleLabel?.text = titleString
        movieCell.directorLabel?.text = directorString
        movieCell.descriptionLabel?.text = summaryString
        
        let posterImageURL = self.posterImageURLForMovieAtIndex(indexPath.row)
        movieCell.posterImageView?.setImageWithURL(posterImageURL)
    }
    
    func titleStringForMovieAtIndex(index: Int) -> String? {
        let movie = self.movies?[index]
        let title = movie?.valueForKeyPath("im:name.label") as? String
        return title
    }
    
    func directorStringForMovieAtIndex(index: Int) -> String? {
        let movie = self.movies?[index]
        let director = movie?.valueForKeyPath("im:artist.label") as? String
        return director
    }
    
    func summaryStringForMovieAtIndex(index: Int) -> String? {
        let movie = self.movies?[index]
        let summary = movie?.valueForKeyPath("summary.label") as? String
        return summary
    }
    
    func posterImageURLForMovieAtIndex(index: Int) -> NSURL {
        let movie = self.movies?[index]
        let posterImageURLArray = movie?.valueForKeyPath("im:image.label") as? [String]
        let posterImageURLString = posterImageURLArray?.last
        let posterImageURL = NSURL(string: posterImageURLString!)!
        return posterImageURL
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        
        if (segue.identifier == "showDetail") {
            let indexPath = self.movieListTableView.indexPathForSelectedRow!
            let viewController = segue.destinationViewController as! DetailMovieViewController
            // your new view controller should have property that will store passed value
            viewController.movie = Movie(titleString: self.titleStringForMovieAtIndex(indexPath.row)!, directorString: self.directorStringForMovieAtIndex(indexPath.row)!, summaryString: self.summaryStringForMovieAtIndex(indexPath.row)!, posterImageURL: self.posterImageURLForMovieAtIndex(indexPath.row))
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
