//
//  PhotoCell.swift
//  PhotoGalleryApp
//
//  Created by ohseungyeon on 8/17/24.
//

import UIKit
import PhotosUI

class PhotoCell: UICollectionViewCell{
    
    
    func loadImage(asset: PHAsset) {
        let imageManager = PHImageManager()
        let scale = UIScreen.main.scale
        let imageSize = CGSize(width: 20*scale, height: 20*scale)
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic
        
        self.photoImageView.image = nil
        
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: nil){image, info in
//            if (info?[PHImageResultIsDegradedKey] as? Bool) == true{
//                //저화질
//                self.photoImageView.image = image
//            }else{
//                //고화질
//            }
            
            //바로 고화질
            self.photoImageView.image = image
        }
    }
    @IBOutlet weak var photoImageView: UIImageView!{
        didSet{
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    
    
}
