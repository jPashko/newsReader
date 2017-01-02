//
//  ViewController.swift
//  newsReaderJson
//
//  Created by Yulia Pashko on 05.12.16.
//  Copyright © 2016 Yulia Pashko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Articale]? = []
     var source = "techcrunch"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        fetchArticles(fromSource: source)
    }
    
    func fetchArticles(fromSource provider: String){
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v1/articles?source=\(provider)&sortBy=top&apiKey=ef271701b7894141a4b7e0ef31fe6b18")!)
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            
            if error != nil{
                print(error)
                return
                }
            self.articles = [Articale]()
                
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let articlesFromJson = json["articles"] as? [[String: AnyObject]]{
                    for articleFromJson in articlesFromJson{
                        let article = Articale()
                        if let title = articleFromJson["title"] as? String,
                           let author = articleFromJson["author"] as? String,
                           let desc = articleFromJson["description"] as? String,
                           let url = articleFromJson["url"] as? String,
                           let urlToImage = articleFromJson["urlToImage"] as? String{
                            
                            article.author = author
                            article.desc = desc
                            article.headline = title
                            article.url = url
                            article.imageUrl = urlToImage
                        }
                        self.articles?.append(article)
                    }
                }
                DispatchQueue.main.async {
                  self.tableView.reloadData()
                }
                
            }catch let error{
                print(error)
            }
            
           }
        task.resume()
    
        }
        
        
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableCell
        
        cell.title.text = self.articles?[indexPath.item].headline
        cell.textDesc.text = self.articles?[indexPath.item].desc
        cell.author.text = self.articles?[indexPath.item].author
        cell.imgView.downloadImage(from: (self.articles?[indexPath.item].imageUrl!)!)
        
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewViewController
        
        webVC.url = self.articles?[indexPath.item].url
        
        self.present(webVC, animated: true, completion: nil)
    }
    
    let menuManager = MenuManager()
    
    @IBAction func menuPressed(_ sender: UIBarButtonItem) {
        
        menuManager.openMenu()
        menuManager.mainVC = self
        
    }

  }


extension UIImageView{
    
    func downloadImage(from url: String){
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            if error != nil{
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}
    


