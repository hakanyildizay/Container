//
//  MenuViewController.swift
//  INGContainer
//
//  Created by Hakan Yildizay [Mobil Yazilim  Servisi] on 10/02/17.
//  Copyright © 2017 ING BANK. All rights reserved.
//

import UIKit

private let reuseIdentifier = "menuCell"

class MenuViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let numberOfColumns : Int = 2
    var applications = [[JSON]]()
    var itemSize = [[CGSize]]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let singleArrayOfApplications = self.getApplications()
        let columnCount = singleArrayOfApplications.count / numberOfColumns
        var doubleArray = Array<Array<JSON>>.init(repeating: Array<JSON>.init(), count: columnCount)
        var sizes = Array<Array<CGSize>>.init(repeating: Array<CGSize>.init(), count: columnCount)
        
        for i in 0..<columnCount {
            /*
            var singleRow = [JSON]()
            singleRow.append(singleArrayOfApplications[numberOfColumns * i])
            singleRow.append(singleArrayOfApplications[(numberOfColumns * i)+1])
            singleRow.append(singleArrayOfApplications[(numberOfColumns * i)+2])
            doubleArray[i] = singleRow
            */
            
            var singleRow = [JSON]()
            
            for columnIndex in 0..<numberOfColumns{
                singleRow.append(singleArrayOfApplications[(numberOfColumns * i) + columnIndex])
            }
            
            doubleArray[i] = singleRow
            
        }
        
        var leftIndex = singleArrayOfApplications.count - (columnCount * numberOfColumns)
        
        if leftIndex > 0
        {
            
            leftIndex = leftIndex * (columnCount * numberOfColumns)
            var leftArray = [JSON]()
            for j in  leftIndex..<singleArrayOfApplications.count {
                leftArray.append(singleArrayOfApplications[j])
            }
            
            doubleArray.append(leftArray)
            
        }
        
        var rowIndex = 0
        for singleRow in doubleArray {
            let itemWidth = self.collectionView!.frame.size.width / CGFloat(singleRow.count)
            let size = CGSize.init(width: itemWidth, height: itemWidth)
            sizes[rowIndex] = Array<CGSize>(repeating: size, count: singleRow.count)
            rowIndex = rowIndex + 1
        }
        
        self.applications = doubleArray
        self.itemSize = sizes
        let flowLayout = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 10.0
        self.collectionView!.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return self.applications.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.applications[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuCollectionViewCell
        
        // Configure the cell
        cell.titleLabel.text = "\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.itemSize[indexPath.section][indexPath.row]
    }
    
    
    func getApplications() -> [JSON] {
        
        if let path = Bundle.main.path(forResource: "applications", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    
                    let applicationList = jsonObj["applications"].arrayValue
                    return applicationList
                    
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                    return [JSON]()
                }
            } catch let error {
                print(error.localizedDescription)
                return [JSON]()
            }
        } else {
            print("Invalid filename/path.")
            return [JSON]()
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



