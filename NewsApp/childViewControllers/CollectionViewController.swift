//
//  CollectionViewController.swift
//  NewsApp
//
//  Created by Юрий Девятаев on 14.03.2022.
//

import UIKit
import SnapKit

class CollectionViewController: UIViewController {
    
    let imageCache = NSCache<NSString, UIImage>()
    
    let dataService = DataServiceImp()
    
    private var collectionView : UICollectionView?
    var news = [News]()
    var category: String? = nil
    var imageArray = [UIImage]()
    
//    var sizeView = CGSize.zero
        
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        getDate()
    }
    
    private func config(){
        view.backgroundColor = .clear
        configCollectionView()
        configCash()
    }
    
    func configCash() {
        imageCache.countLimit = 100
    }
    
    func getDate() {
        
        guard let category = category else {return}
        
        dataService.receiveData(category: category) {[weak self] news in
            guard let self = self else {return}
            self.news = news.sorted{
                $0.publishedAt.dateFromUTC() < $1.publishedAt.dateFromUTC()
            }
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        } error: { error in
            print(error)
        }
    }
    
    deinit {
//        print("deinit HourlyViewController")
    }
    
    
    
//    func update(withData: WeatherResponse?) {
//        guard let data = withData else {return}
//        self.data = data
//        collectionView?.reloadData()
//    }

    private func configCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(NewsCollectionViewCell.nib(), forCellWithReuseIdentifier: "NewsCollectionViewCell")
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        self.collectionView = collectionView
    }

    private func fill(cell: NewsCollectionViewCell, withContent: News, indexPath: IndexPath) -> UICollectionViewCell {
        
        cell.indexPath = indexPath
        cell.textNews.text = withContent.title
        
        let key = NSString(string: withContent.urlToImage ?? "")
        
        if let cachedImage = imageCache.object(forKey: key) {
            cell.imageNews.image = cachedImage
            
        } else {
            guard let urlToImage = withContent.urlToImage else {
                return cell
            }
            
            dataService.loadImage(url: urlToImage) { [weak self] image in
                guard let self = self else {return}
                
                self.imageCache.setObject(image, forKey: key)
                if cell.indexPath == indexPath {
                    DispatchQueue.main.async {
                        cell.imageNews.image = image
                    }
                }
            } error: { error in
                print(error as Any)
            }
        }
        return cell
    }
    
    private func prepareWebViewController(startLink: String?) -> WebViewController? {
        guard let link = startLink else {return nil}
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller  = storyboard.instantiateViewController(identifier: "WebViewControllerIdent") as? WebViewController {
            controller.modalPresentationStyle = .formSheet
            controller.url = URL(string: link)
            return controller
        } else {
            return nil
        }
    }
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let newsCell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: NewsCollectionViewCell.identifier,
                    for: indexPath) as? NewsCollectionViewCell
        else {return UICollectionViewCell()}
        
        let new = news[indexPath.row]
                
        let cell = fill(cell: newsCell, withContent: new, indexPath: indexPath)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = news[indexPath.row].url
        guard let controller = prepareWebViewController(startLink: url) else {return}
        self.present(controller, animated: true)
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        

        
        let width: CGFloat = collectionView.frame.size.width / 2.5
        let height: CGFloat = collectionView.frame.size.height
        let size = CGSize(width: width, height: height)
        return size
    }
}
