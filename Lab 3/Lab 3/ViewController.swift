//
//  ViewController.swift
//  Lab 3
//
//  Created by Michael Tang on 2/27/18.
//  Copyright © 2018 Michael Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let imageName = ["appstore", "watch", "messages", "maps", "chess", "pages"]
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DetailImageCell
        cell.image.image = UIImage(named: imageName[indexPath.row])
        cell.title.text = imageName[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageName.count
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showLargeImage") {
            let indexPath = collectionView?.indexPath(for: sender as! DetailImageCell)
            let vc = segue.destination as! LargeImageViewController
            vc.passedImageName = imageName[(indexPath?.row)!]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

