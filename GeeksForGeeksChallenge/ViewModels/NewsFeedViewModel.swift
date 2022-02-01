//
//  NewsFeedViewModel.swift
//  GeeksForGeeksChallenge
//
//  Created by Dhirendra Verma on 01/02/22.
//

import Foundation
import UIKit

struct NewsCellViewModel {
    let titleText: String?
    let dateText: String?
    let imageUrl: String?
    let largeImageUrl:String?
}

class NewsFeedViewModel {
    
    let apiService: APIServiceProtocol
    
    private var newsItems: [NewsItem] = [NewsItem]()
    
    private var newsListViewModel: [NewsCellViewModel] = [NewsCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return newsListViewModel.count
    }
    
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true
        //
        Task {
            do {
                let results = try await apiService.fetchNewsFeeds()
                self.processFetchedTopStories(newsItems: results)
                self.isLoading = false
            } catch {
                print("Request failed with error: \(error)")
            }
            
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> NewsCellViewModel {
        return newsListViewModel[indexPath.row]
    }
    
    func createCellViewModel( newsItem: NewsItem ) -> NewsCellViewModel {
        let title = newsItem.title
        let pubDate = newsItem.pubDate?.formattedEndDate()
        let imageUrl = newsItem.thumbnail
        let largeImageUrl = newsItem.enclosure?.link
        return NewsCellViewModel(titleText:title , dateText: pubDate, imageUrl: imageUrl, largeImageUrl: largeImageUrl)
    }
    
    private func processFetchedTopStories( newsItems: [NewsItem]? ) {
        guard let newsData = newsItems else {return}
        self.newsItems = newsData
        var newsListCellViewModel = [NewsCellViewModel]()
        for newsItem in newsData {
            newsListCellViewModel.append( createCellViewModel(newsItem: newsItem) )
        }
        self.newsListViewModel = newsListCellViewModel
    }
    
}
