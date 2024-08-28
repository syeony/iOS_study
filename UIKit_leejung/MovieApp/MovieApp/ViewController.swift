//
//  ViewController.swift
//  MovieApp
//
//  Created by ohseungyeon on 8/19/24.
//

import UIKit

class ViewController: UIViewController {

    var movieModel: MovieModel?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var movieTableView: UITableView!
    
    var term = ""
    
    var networkLayer = NetworkLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.keyboardDismissMode = .onDrag
        searchBar.delegate = self
        
        requestMovieAPI()
    }
    
    // 아래껄 NetworkLayer를 이용하여 간단하게 만들었다
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void){
        networkLayer.request(type: .justURL(urlString: urlString)) { data, response, error in
            if let hasData = data{
                completion(UIImage(data:hasData))
                return
            }
            completion(nil)
        }
    }
    
    //escaping 써야한다
//    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void){
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig)
//        
//        if let hasURL = URL(string: urlString){
//            var request = URLRequest(url: hasURL)
//            request.httpMethod = "GET"
//            
//            session.dataTask(with: request) { data, response, error in
//                print((response as! HTTPURLResponse).statusCode)
//                
//                if let hasData = data{
//                    completion(UIImage(data: hasData))
//                    return
//                }
//                
//            }.resume()
//            session.finishTasksAndInvalidate()
//        }
//        
//        completion(nil)
//    }

    // 아래껄 NetworkLayer를 이용하여 간단하게 만들었다
    func requestMovieAPI(){
        let term = URLQueryItem(name: "term", value: term)
        let media = URLQueryItem(name: "media", value: "movie")
        
        let querys = [term, media]
        
        networkLayer.request(type: .searchMovie(querys: querys)) { data, response, error in
            if let hasData = data{
                
                do{
                    //규격에 맞춰 써야함 ituns api는 json타입으로 줌
                    self.movieModel = try JSONDecoder().decode(MovieModel.self, from: hasData)
                    print(self.movieModel ?? "no data")
                    
                    DispatchQueue.main.async{
                        //데이터 갱신
                        self.movieTableView.reloadData()
                    }
                    
                }catch{
                    print(error)
                }
            }
        }
    }
    
    //network 호출해서 뿌려주는 부분!
    //일종의 규격같은 느낌 이렇게들 씁니다
//    func requestMovieAPI(){
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig)
//        
//        // https://itunes.apple.com/search?term=marvel&media=movie
//        var components = URLComponents(string: "https://itunes.apple.com/search")
//        
//        let term = URLQueryItem(name: "term", value: "marvel")
//        let media = URLQueryItem(name: "media", value: "movie")
//        
//        components?.queryItems = [term, media]
//        
//        guard let url = components?.url else{
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        print(request)
//        request.httpMethod = "GET"
//        
//        let task = session.dataTask(with: request) { data, response, error in
//            // 제일 중요한 부분
//            //statusCode
//            //200 - 성공
//            //300 - 다른 주소로 넘어가서 줄수있다(리다이렉션)
//            //400 - 에러(내가 잘못해서)
//            //500 - 서버, 네트워크가 아예 잘못된 경우
//            print((response as! HTTPURLResponse).statusCode)
//            
//            if let hasData = data{
//                
//                do{
//                    //규격에 맞춰 써야함 ituns api는 json타입으로 줌
//                    self.movieModel = try JSONDecoder().decode(MovieModel.self, from: hasData)
//                    print(self.movieModel ?? "no data")
//                    
//                    DispatchQueue.main.async{
//                        //데이터 갱신
//                        self.movieTableView.reloadData()
//                    }
//                    
//                }catch{
//                    print(error)
//                }
//            }
//            
//            
//        }
//        
//        task.resume()
//        session.finishTasksAndInvalidate()
//    }
//
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{ 
    
    //개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieModel?.results.count ?? 0
    }
    
    //눌렀을때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        
        
        detailVC.movieResult = self.movieModel?.results[indexPath.row]
        
        detailVC.modalPresentationStyle = .fullScreen
        
        self.present(detailVC, animated: true){ }
    }
    
    //이미지크기
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MovieCell과 연결
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.titleLabel.text = self.movieModel?.results[indexPath.row].trackName
        cell.descriptionLabel.text = self.movieModel?.results[indexPath.row].shortDescription
        
        let currency = self.movieModel?.results[indexPath.row].currency ?? ""
        let price = self.movieModel?.results[indexPath.row].trackPrice.description ?? ""
        
        cell.priceLabel.text = currency + price
        
        if let hasURL = self.movieModel?.results[indexPath.row].image{
            self.loadImage(urlString: hasURL) { image in
                DispatchQueue.main.async{
                    cell.movieImageView.image = image
                }
                
            }
        }
        
        //날짜를 가져오는데 포맷형식에 맞춰 가져올때
        if let dateString = self.movieModel?.results[indexPath.row].releaseDate{
            //외워걍 iso8601~
            let formatter = ISO8601DateFormatter()
            if let isoDate = formatter.date(from: dateString){
                
                let myFomatter = DateFormatter()
                myFomatter.dateFormat = "yyyy-MM-dd"
                let dateString = myFomatter.string(from: isoDate)
                
                cell.dateLabel.text = dateString
            }
        }
        
        
        
        return cell
    }
    
    
}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let hasText = searchBar.text else{
            return
        }
        term = hasText
        requestMovieAPI()
        self.view.endEditing(true)
    }
}
