//
//  MovieCell.swift
//  MovieApp
//
//  Created by ohseungyeon on 8/19/24.
//

import UIKit

class MovieCell: UITableViewCell{
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        }
    }
    @IBOutlet weak var dateLabel: UILabel!{
        didSet{
            dateLabel.font = .systemFont(ofSize: 13, weight: .light)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
        }
    }
    @IBOutlet weak var priceLabel: UILabel!{
        didSet{
            priceLabel.font = .systemFont(ofSize: 14, weight: .bold)
        }
    }
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    
}
