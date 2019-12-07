//
//  QuizzViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 03/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class QuizzViewController: UIViewController {
//    let progress = Progress(totalUnitCount: 5)
 
    @IBOutlet weak var questionOneButtons: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        progress.completedUnitCount = 0
//        scrollView.isPagingEnabled = true

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension QuizzViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = (scrollView.contentOffset.x/pageWidth)
        progressView.setProgress(Float(pageFraction/5+0.2), animated: false)

//        pageControl.currentPage = Int((round(pageFraction)))
    }
}
