//
//  ViewController.swift
//  PhotoGalleryApp
//
//  Created by ohseungyeon on 8/17/24.
//
//기능은 단순한데 설정해야할것들이 많다.
//info.plist에 있는 privacy - 추가

import UIKit
import PhotosUI

class ViewController: UIViewController {
    
    var fetchResults: PHFetchResult<PHAsset>?
        @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "photo gallery app"
        makeNavigationItem()
        
        //사진들 어떤식으로 나올지 틀 잡기
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-1)/2, height: 200)
        
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        photoCollectionView.collectionViewLayout = layout
        
        photoCollectionView.dataSource = self
        
    }
    
    func makeNavigationItem() {
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo"), style: .done, target: self, action: #selector(checkPermission))
        
        //오른쪽 아이콘 색 설정
        photoItem.tintColor = .black.withAlphaComponent(0.7)
        
        self.navigationItem.rightBarButtonItem = photoItem
        
        //리프레시 버튼(저화질->고화질)
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refresh))
        refreshItem.tintColor = .black.withAlphaComponent(0.7)
        
        self.navigationItem.leftBarButtonItem = refreshItem
    }
    
    @objc func checkPermission(){
        if PHPhotoLibrary.authorizationStatus() == .authorized || PHPhotoLibrary.authorizationStatus() == .limited{
            DispatchQueue.main.async{
                self.showGallery()
            }
        }else if PHPhotoLibrary.authorizationStatus() == .denied{ //처음설정
            DispatchQueue.main.async{
                self.showAuthorizationDeniedAlert()
            }
        }else if PHPhotoLibrary.authorizationStatus() == .notDetermined{ //한번 선택하면 사라짐
            PHPhotoLibrary.requestAuthorization{status in //info.plist에 추가함
                self.checkPermission()
            }
        }
    }
    
    //경고창 권한
    func showAuthorizationDeniedAlert(){
        let alert = UIAlertController(title: "포토라이브러리 접근 권한을 활성화 해주세요.", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "설정으로 가기", style: .default, handler: {
            action in
            
            //내 앱에 대한 설정으로 가기
            guard let url = URL(string: UIApplication.openSettingsURLString) else{
                return
            }
            
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    @objc func showGallery() {
        let library = PHPhotoLibrary.shared()
        
        var configuration = PHPickerConfiguration(photoLibrary: library)
        configuration.selectionLimit = 10
        
        // 아이폰 갤러리 띄우기
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
        
        
    }
    
    @objc func refresh() {
        self.photoCollectionView.reloadData()
    }


}

//새로고침해서 뿌려준다
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        if let asset = self.fetchResults?[indexPath.row]{
            cell.loadImage(asset: asset)
        }
        
        return cell
    }
    
    
}

//이미지를 가져온다
extension ViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        let identifiers = results.map{
            $0.assetIdentifier ?? ""
        }
        
        self.fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
        
        self.photoCollectionView.reloadData()
        
        //아이폰 갤러리 화면 내리는 기능
        self.dismiss(animated: true)
    }
    
    
}
