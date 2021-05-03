//
//  BannerTableViewCell.swift
//  Media_final_project
//
//  Created by TTN on 03/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    var movieInfo = [movieData]()
    
    static let identifier = "BannerTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BannerTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bannerCollectionView.register(BannerCollectionViewCell.nib(), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        
        startTimer()
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(_ data: BindedData){
        movieInfo = data.genreMovies
        bannerCollectionView.reloadData()
    }
    
    func startTimer() {
        
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
        
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        
        for cell in bannerCollectionView.visibleCells {
            let indexPath: IndexPath = bannerCollectionView.indexPath(for: cell)!
            if (indexPath.row < (movieInfo.count ) - 1){
                let indexPath1 = IndexPath.init(row: indexPath.row + 1, section: indexPath.section)
                bannerCollectionView.scrollToItem(at: indexPath1, at: .left, animated: true)
            } else {
                self.bannerCollectionView.setContentOffset(.zero, animated: true)
            }
            
        }
    }
    
}


extension BannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieInfo.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
        cell.configure(movieInfo[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = bannerCollectionView.frame.width - 50
        return CGSize(width: width, height: width*(9/16))
    }
}
