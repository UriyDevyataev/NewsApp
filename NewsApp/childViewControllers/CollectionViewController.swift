//
//  CollectionViewController.swift
//  NewsApp
//
//  Created by Юрий Девятаев on 14.03.2022.
//

import UIKit
import SnapKit

class CollectionViewController: UIViewController {
    
    private var collectionView : UICollectionView?
    var data: News?
//    var sizeView = CGSize.zero
        
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    deinit {
//        print("deinit HourlyViewController")
    }
    
    private func config(){
        view.backgroundColor = .clear
        configCollectionView()
    }
    
//    func update(withData: WeatherResponse?) {
//        guard let data = withData else {return}
//        self.data = data
//        collectionView?.reloadData()
//    }

    private func configCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(
            UINib(nibName: "HourCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "HourCollectionViewCellIdent")
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        self.collectionView = collectionView
    }

    private func fill(cell: NewsCollectionViewCell, withContent: News, index: Int) -> UICollectionViewCell {
        
        cell.imageNews.image = nil
        cell.textNews.text = ""

        return cell
    }
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let newsCell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: NewsCollectionViewCell.identifier,
                    for: indexPath) as? NewsCollectionViewCell
        else {return UICollectionViewCell()}
        
        guard let data = data else {return newsCell}
        
        let cell = fill(cell: newsCell, withContent: data, index: indexPath.row)

        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let width = sizeView.width / 6
//        let height = sizeView.height
        
        let width = 100
        let height = 100
        return CGSize(width: width, height: height)
    }
}
