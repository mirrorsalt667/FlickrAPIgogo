//
//  BigImageViewController.swift
//  FlickrAPIgogo
//
//  Created by 黃肇祺 on 2021/5/25.
//

import UIKit

class BigImageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var bigImageView: UIImageView!
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        bigImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
