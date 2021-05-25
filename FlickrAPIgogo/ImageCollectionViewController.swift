//
//  ImageCollectionViewController.swift
//  FlickrAPIgogo
//
//  Created on 2021/5/24.
//

import UIKit

//private let reuseIdentifier = "imageCell"

class ImageCollectionViewController: UICollectionViewController {

    var itemArrays:[redomImageResponse] = []
    
    var bigImageArrays = [URL]()
    
    //var url
    let urlStr = "https://www.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&id=139239354@N02"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = data {
                    do {
                        let imageRespomseData = try decoder.decode(imageResponse.self, from: data)
                        self.itemArrays = imageRespomseData.items

                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                            print("reload")
                        }
                    } catch {
                        print(error)
                    }
                } else {
                    //show error
                }
            }.resume()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return itemArrays.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        
        let item = itemArrays[indexPath.item]
        let dateStr = "\(item.published)"
        let end = dateStr.index(dateStr.startIndex, offsetBy: 10)
        cell.dateLabel.text = "\(dateStr[dateStr.startIndex...end])"
        //cell.imageView.image = UIImage(systemName: "questionmark.circle")
        //加入上碼產生一個問題，所有圖片讀取後自動變成正方形，且把Label推到可是範圍外
        
        //turnBigImage
        func turnBig() {
            DispatchQueue.global().async {
                for i in 0...self.itemArrays.count {
                    let lastPathComponent = self.itemArrays[i].media.m.lastPathComponent.replacingOccurrences(of: "m", with: "b")
                    let bigImageUrl = self.itemArrays[i].media.m.deletingLastPathComponent().appendingPathComponent(lastPathComponent)
                    self.bigImageArrays.insert(bigImageUrl, at: i)
                }
                
            }
        }
        
        func load() {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: self.itemArrays[indexPath.item].media.m) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.imageView.image = image
                        }
                    }
                }
            }
        }
        load()
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? BigImageViewController {
           //collectionView.indexpathForSelectedItems 型別為 [indexpath]
            let row = collectionView.indexPathsForSelectedItems
            DispatchQueue.global().async {
                for i in 0...self.itemArrays.count {
                    if  row == [IndexPath(item: i, section: 0)] {
                        let lastPathComponent = self.itemArrays[i].media.m.lastPathComponent.replacingOccurrences(of: "m", with: "b")
                        let bigImageUrl = self.itemArrays[i].media.m.deletingLastPathComponent().appendingPathComponent(lastPathComponent)
                        if let data = try? Data(contentsOf: bigImageUrl) {
                            if let image = UIImage(data: data) {
                                
                                DispatchQueue.main.async {
                                    controller.bigImageView.image = image
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    



    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
     }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
     }
    */

}
