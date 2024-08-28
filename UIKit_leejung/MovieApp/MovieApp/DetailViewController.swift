//
//  DetailViewController.swift
//  MovieApp
//
//  Created by ohseungyeon on 8/27/24.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {
    
    var movieResult: MovieResult?{
        didSet{
            
            
            
        }
    }
    
    var player: AVPlayer?
    
    @IBOutlet weak var movieContainer: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.font=UIFont.systemFont(ofSize: 24, weight: .medium)
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movieResult?.trackName
        descriptionLabel.text = movieResult?.longDescription
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let hasURL = movieResult?.previewUrl{
            makePlayerAndPlay(urlString: hasURL)
        }
    }
    
    func makePlayerAndPlay(urlString: String){
        if let hasUrl = URL(string: urlString){
            self.player = AVPlayer(url:hasUrl)
            let playerLayer = AVPlayerLayer(player: player)
            
            movieContainer.layer.addSublayer(playerLayer)
            
            playerLayer.frame = movieContainer.bounds
            
            self.player?.play()
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func play(_ sender: Any) {
        self.player?.play()
    }
    
    @IBAction func stop(_ sender: Any) {
        self.player?.pause()
    }
    
}
