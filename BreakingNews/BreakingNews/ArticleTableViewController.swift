
//
//  ArticleTableViewController.swift
//  BreakingNews
//
//  Created by student01 on 2019-03-15.
//  Copyright © 2019 student01. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleTableViewController: UITableViewController {
  
  var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
      
     getArticles()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

  
  
  func getArticles(){
    NewsHelper().getArticles{ (articles) in
      self.articles = articles
      self.tableView.reloadData()
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return articles.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // identifier for our prototype cell
    if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell {
      let article = articles[indexPath.row]
      cell.titleLabel.text = article.title
      cell.categoryLabel.text = article.category.rawValue
      cell.categoryLabel.backgroundColor = article.categoryColor
      
      //bring image downloaded from internet - use Kingfisher (kf)
      
      //set up image assets
      
      let url = URL(string: article.urlToImage)
      cell.articleImageView.kf.setImage(with: url, placeholder: UIImage(named:"Icon-App-29x29"), options: nil, progressBlock:nil, completionHandler: nil)
      //if images won't display we'll need
      //tp set up plist
      
      return cell
    }
    //in case the if let fails - do the below
    //so some sort of cell is returned
    
    return UITableViewCell()
  }
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 260
  }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let article = articles[indexPath.row]
    performSegue(withIdentifier: "goToUrl", sender: article)
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToUrl" {
      if let article = sender as? Article {
        if let webVC = segue.destination as? ArticleWebViewController {
          webVC.article = article
        }
      }
    }
  }
  
  @IBAction func reloadTapped(_ sender: Any) {
    getArticles()
  }
  
  
  
  
  
  
 

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}


class ArticleCell: UITableViewCell{
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var articleImageView: UIImageView!
  
  @IBOutlet weak var categoryLabel: UILabel!
}
