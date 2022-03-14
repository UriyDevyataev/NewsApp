//
//  ViewController.swift
//  NewsApp
//
//  Created by Юрий Девятаев on 14.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        configTableView()
    }
    
    func configTableView() {
        
        tableView.backgroundColor = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CategoryTableViewCell.nib(),
                           forCellReuseIdentifier: CategoryTableViewCell.identifier)
    }
    
    func fill(cell: CategoryTableViewCell, indexPath: IndexPath) -> CategoryTableViewCell {
        
        let controller = CollectionViewController()
        addChildViewController(container: cell.contentView, controller: controller)
        return cell
    }
    
    func addChildViewController(container: UIView, controller: UIViewController) {
        
        container.subviews.forEach { view in
            view.removeFromSuperview()
            view.findViewController()?.removeFromParent()
        }
        
        addChild(controller)
    
        container.addSubview(controller.view)
        controller.view.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        controller.didMove(toParent: self)
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contentCell = tableView.dequeueReusableCell(
            withIdentifier: CategoryTableViewCell.identifier,
            for: indexPath) as? CategoryTableViewCell else {return UITableViewCell()}
    
        let cell = fill(cell: contentCell, indexPath: indexPath)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}



