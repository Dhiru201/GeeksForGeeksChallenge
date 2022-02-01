//
//  ViewController.swift
//  GeeksForGeeksChallenge
//
//  Created by Dhirendra Verma on 01/02/22.
//

import UIKit

class ViewController: UIViewController {

    private var newsListTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.clipsToBounds = true
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableHeaderView = UIView(frame: .zero)
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    lazy var viewModel: NewsFeedViewModel = {
        return NewsFeedViewModel()
    }()
    
    private let refreshControl = UIRefreshControl()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init the static view
        initView()
        // init view model
        initVM()
    }

    //Mark: Setup View Methods
    func initView() {
        self.view.addSubview(newsListTable)
        //
        let safeLayoutGuide = view.safeAreaLayoutGuide
        newsListTable.leadingAnchor.constraint(equalTo: safeLayoutGuide.leadingAnchor).isActive = true
        newsListTable.trailingAnchor.constraint(equalTo: safeLayoutGuide.trailingAnchor).isActive = true
        newsListTable.topAnchor.constraint(equalTo: safeLayoutGuide.topAnchor).isActive = true
        newsListTable.bottomAnchor.constraint(equalTo: safeLayoutGuide.bottomAnchor).isActive = true
        //
        newsListTable.dataSource = self
        // Register cells
        newsListTable.register(UINib(nibName: Cells.newsFeedTableCellId, bundle: nil), forCellReuseIdentifier: Cells.newsFeedTableCellId)
        newsListTable.register(UINib(nibName: Cells.topNewsFeedTableCellId, bundle: nil),
                               forCellReuseIdentifier: Cells.topNewsFeedTableCellId)
        newsListTable.backgroundColor = UIColor(hex: "#C5C5C5")
        newsListTable.separatorStyle = .none
        //
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        newsListTable.addSubview(refreshControl)
        newsListTable.sendSubviewToBack(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        viewModel.initFetch()
    }
    
    func initVM() {
        
        // Naive binding
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                }else {
                    self?.activityIndicator.stopAnimating()
                    self?.newsListTable.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.newsListTable.reloadData()
            }
        }
        
        viewModel.initFetch()
        
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: Strings.alertTitle, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.topNewsFeedTableCellId , for: indexPath) as? TopNewsFeedTableCell else {
                fatalError("Cell not exists")
            }
            let cellVM = viewModel.getCellViewModel( at: indexPath )
            cell.newsTitleLbl.text = cellVM.titleText
            cell.newsDateLbl.text = cellVM.dateText
            if let imageUrl = cellVM.largeImageUrl, let index = imageUrl.firstIndex(of: "?") {
                let urlString = String(imageUrl[..<index])
                cell.configureWith(urlString: urlString)
            }
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.newsFeedTableCellId , for: indexPath) as? NewsFeedTableCell else {
                fatalError("Cell not exists")
            }
            let cellVM = viewModel.getCellViewModel( at: indexPath )
            cell.newsTitleLbl.text = cellVM.titleText
            cell.newsDateLbl.text = cellVM.dateText
            if let imageUrl = cellVM.imageUrl, let index = imageUrl.firstIndex(of: "?") {
                let urlString = String(imageUrl[..<index])
                cell.configureWith(urlString: urlString)
            }
            return cell
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
