//
//  ViewController.swift
//  HomeTest-iOS
//
//  Created by KTC on 8/29/18.
//  Copyright © 2018 KTC. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    // MARK: - Variable
    @IBOutlet weak var hotKeyCollectionView: UICollectionView!
    @IBOutlet weak var recentKeyCollectionView: UICollectionView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var recentSearchView: UIView!
    
    var hotKeys : Array<HotKeyModel> = Array()
    var recentKeys : Array<RecentKeyModel> = Array()
    var arrayColor : Array<UIColor> = Array()
    
    // MARK: - Life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
        self.registerCollectionViewCell()
        self.getHotKeyData()
        self.hotKeyCollectionView.reloadData()
        self.recentKeyCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - PRIVATE FUNCTION
    private func configView(){
        self.hotKeyCollectionView.delegate = self
        self.hotKeyCollectionView.dataSource = self
        self.recentKeyCollectionView.dataSource = self
        self.recentKeyCollectionView.delegate = self
        
        if let flowLayout = hotKeyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 100 * AppUtil.displayScale,height: 200 * AppUtil.displayScale)
            flowLayout.scrollDirection = .horizontal
        }
        if let flowLayout2 = recentKeyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout2.estimatedItemSize = CGSize(width: 100 * AppUtil.displayScale,height: 70 * AppUtil.displayScale)
            flowLayout2.scrollDirection = .horizontal
        }
        self.arrayColor = [AppUtil.hexStringToUIColor(hex: "#16702e"),
        AppUtil.hexStringToUIColor(hex: "#005a51"),
        AppUtil.hexStringToUIColor(hex: "#996c00"),
        AppUtil.hexStringToUIColor(hex: "#5c0a6b"),
        AppUtil.hexStringToUIColor(hex: "#006d90"),
        AppUtil.hexStringToUIColor(hex: "#974e06"),
        AppUtil.hexStringToUIColor(hex: "#99272e"),
        AppUtil.hexStringToUIColor(hex: "#89221f"),
        AppUtil.hexStringToUIColor(hex: "#00345d"),]
    }
    private func registerCollectionViewCell() {
        self.hotKeyCollectionView.register(UINib.init(nibName: HotKeyCollectionViewCell.HOT_KEY_NIB_NAME, bundle: nil), forCellWithReuseIdentifier: HotKeyCollectionViewCell.HOT_KEY_IDENTIFIER)
        self.recentKeyCollectionView.register(UINib.init(nibName: RecentKeyCollectionViewCell.RECENT_KEY_NIB_NAME, bundle: nil), forCellWithReuseIdentifier: RecentKeyCollectionViewCell.RECENT_KEY_IDENTIFIER)
    }
    
    private func getHotKeyData() {
        //creating a NSURL
        let url = NSURL(string: "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com/ios/keywords.json")
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                if let hotKeyArray = jsonObj!.value(forKey: "keywords") as? NSArray {
                    //looping through all the elements
                    for hotKey in hotKeyArray{

                        //converting the element to a dictionary
                        if let hotKeyDict = hotKey as? NSDictionary {
                            let hotKeyObj : HotKeyModel = HotKeyModel(dict: hotKeyDict)
                            
                            //adding the object to the array
                            self.hotKeys.append(hotKeyObj)
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    self.hotKeyCollectionView.reloadData()
                })
            }
        }).resume()

    }
    
    // MARK: - ACTION
    @IBAction func searchButtonTouchUpInside(_ sender: UIButton) {
        let inputSearchString = self.searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if inputSearchString != "" {
            if self.recentSearchView.isHidden == true{
                self.recentSearchView.isHidden = false
            }
            
            // remove duplicate keyword
            for recentKey in self.recentKeys{
                if recentKey.keyWord == inputSearchString {
                    self.recentKeys.remove(at: self.recentKeys.index(of: recentKey)!)
                }
            }
            // append new keyword
            let recentKeyModel : RecentKeyModel = RecentKeyModel(keyword: inputSearchString!, searchTime: Date())
            self.recentKeys.append(recentKeyModel)
            
            self.recentKeyCollectionView.reloadData()
        }
    }
    
    @IBAction func removeAllTouchUpInside(_ sender: UIButton) {
        self.recentKeys.removeAll()
        self.recentKeyCollectionView.reloadData()
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.hotKeyCollectionView {
            return self.hotKeys.count
        }
        else {
            return self.recentKeys.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.hotKeyCollectionView {
            if self.hotKeys.indices.contains(indexPath.row) {
                let hotKeyModel = self.hotKeys[indexPath.row]
                let hotKeycell:HotKeyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HotKeyCollectionViewCell.HOT_KEY_IDENTIFIER, for: indexPath) as! HotKeyCollectionViewCell
                    hotKeycell.updateViewCell(model: hotKeyModel, keywordColor: self.arrayColor[indexPath.row%(self.arrayColor.count - 1)])
                
                return hotKeycell
            }
        }
        else {
            if self.recentKeys.indices.contains(self.recentKeys.count - indexPath.row - 1) {
                let recentKeyModel = self.recentKeys[self.recentKeys.count - indexPath.row - 1]
                let recentCell:RecentKeyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentKeyCollectionViewCell.RECENT_KEY_IDENTIFIER, for: indexPath) as! RecentKeyCollectionViewCell
                
                recentCell.updateViewCell(model: recentKeyModel, keywordBackgroundColor: self.arrayColor[indexPath.row%(self.arrayColor.count - 1)])
                
                return recentCell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // CLICK HOT KEY OR RECENT KEY
    }
}
