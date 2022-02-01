//
//  TopNewsFeedTableCell.swift
//  GeeksForGeeksChallenge
//
//  Created by Dhirendra Verma on 01/02/22.
//

import UIKit

class TopNewsFeedTableCell: UITableViewCell {

    @IBOutlet weak var newsContainerView: UIView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsDateLbl: UILabel!
    @IBOutlet weak var newsTitleLbl: UILabel!
    @IBOutlet weak var separatorView: UIView!
    private var task: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        task = nil
        newsTitleLbl.text = nil
        newsDateLbl.text = nil
        newsImageView.image = nil
    }

    
     func configureWith(urlString: String) {
         if task == nil {
             // Ignore calls when reloading
             task = newsImageView.downloadImage(from: urlString)
         }
     }
    
    
    // MARK:- Helpers
    private func prepareView() {
        // Add container stack view
        newsContainerView.layer.cornerRadius = 12
        newsContainerView.layer.masksToBounds = true
        newsContainerView.backgroundColor = .white
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        newsTitleLbl.font = UIFont.boldSystemFont(ofSize: 28)
        newsTitleLbl.numberOfLines = 0
        newsTitleLbl.textColor = UIColor(hex: "#4b730e")
        newsDateLbl.numberOfLines = 1
        newsDateLbl.font = UIFont.boldSystemFont(ofSize: 14)
        newsDateLbl.textColor = UIColor(hex:"#818181")
        separatorView.backgroundColor = UIColor(hex:"#d0d0d0")
    }
    
}



