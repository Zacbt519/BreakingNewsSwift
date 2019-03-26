//
//  NewsHelper.swift
//  BreakingNews
//
//  Created by student01 on 2019-03-15.
//  Copyright © 2019 student01. All rights reserved.
//

import Foundation
import Alamofire
import DocumentClassifier

class NewsHelper{
  
  func getArticles(returnArticles: @escaping([Article]) -> Void){
    Alamofire.request("https://newsapi.org/v2/top-headlines?country=us&apiKey=YourKey").responseJSON{
      
      (response)
      in
      if let json = response.result.value as?
        [String:Any]{
        if let jsonArticles = json["articles"] as?
          [[String:Any]]{
          var articles = [Article]()
          for jsonArticle in jsonArticles{
            guard let title = jsonArticle["title"] as?
            String,
            let urlToImage = jsonArticle["urlToImage"]
            as? String,
            let url = jsonArticle["url"] as? String,
            let description = jsonArticle["description"]
            as? String
              else{
                continue
            }
            let article = Article()
            article.title = title;
            article.urlToImage = urlToImage
            article.url = url
            article.description = description
            
            guard let classification = DocumentClassifier().classify(title + description) else{
              return
            }
            
            switch(classification.prediction.category){
            case .business: article.category = .business
              article.categoryColor = UIColor(red: 0.298, green: 0.882, blue: 0.949, alpha: 1.00)
            case .entertainment: article.category = .entertainment
              article.categoryColor = UIColor.green
            case .sports: article.category = .sports
              article.categoryColor = UIColor.orange
            case .politics: article.category = .politics
              article.categoryColor = UIColor(red: 0.949, green: 0.396, blue: 0.220, alpha:1.00)
            case .technology: article.category = .technology
              article.categoryColor = UIColor.yellow
            }
            
            articles.append(article)
            
          }
            returnArticles(articles)
        }
      }
    }
  }
  
}

class Article{
  var title = ""
  var urlToImage = ""
  var url = ""
  var description = ""
  var category : NewsCategory = .business
  var categoryColor = UIColor.white
}
enum NewsCategory: String{
  case business = "💼 Business"
  case entertainment = "🎬 Entertainment"
  case politics = "🗣 Politics"
  case sports = "⚽️ Sports"
  case technology = "📱 Technology"
}
