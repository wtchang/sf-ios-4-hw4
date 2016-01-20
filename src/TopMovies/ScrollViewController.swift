//
//  ScrollViewController.swift
//  TopMovies
//
//  Created by William Chang on 1/19/16.
//  Copyright © 2016 GA Student. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageScrollView: UIScrollView!
    var posterImageURL: NSURL!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.imageScrollView.delegate = self
      
        let screenSize = UIScreen.mainScreen().bounds
        let posterImageView = UIImageView(frame:CGRectMake(0, 0, screenSize.size.width, screenSize.size.height))
        posterImageView.contentMode = UIViewContentMode.ScaleToFill
        posterImageView.setImageWithURL(posterImageURL)
        self.imageScrollView.addSubview(posterImageView)
        self.imageScrollView.contentSize = posterImageView.frame.size
        self.imageScrollView.maximumZoomScale = 2.0
        self.imageScrollView.minimumZoomScale = 0.1
        self.imageScrollView.zoomScale = 1.0
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first
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
