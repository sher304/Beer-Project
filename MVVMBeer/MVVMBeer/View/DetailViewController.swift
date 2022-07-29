//
//  DetailViewController.swift
//  MVVMBeer
//
//  Created by Шермат Эшеров on 28/7/22.
//

import UIKit
import Kingfisher
import SnapKit

class DetailViewController: UIViewController {
    
    private lazy var detailViewModel: DetailViewModel = {
        return DetailViewModel()
    }()
    
    private lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.bounces = true
        scrollView.contentSize = view.frame.size
        return scrollView
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private lazy var taglineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var descriptionTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        bindDetailViewModel()
    }
}

//  MARK: Set Constraints

extension DetailViewController{
    func setupConstraints(){
        view.backgroundColor = .orange
        
        let elements = [scrollView]
        for element in elements {
            view.addSubview(element)
        }
        
        scrollView.snp.makeConstraints { make in
            make.bottom.top.leading.trailing.equalToSuperview()
        }
        
        let childs = [imageView, titleLabel, taglineLabel, descriptionTitle]
        for child in childs {
            scrollView.addSubview(child)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.width.equalTo(view.frame.width - 30)
            make.top.equalTo(120)
            make.height.equalTo(340)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
        }
        
        taglineLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        descriptionTitle.snp.makeConstraints { make in
            make.top.equalTo(taglineLabel.snp.bottom).offset(40)
            make.leading.equalTo(20)
            make.bottom.equalTo(additionalSafeAreaInsets)
            make.width.equalTo(view.frame.width - 30)
        }
    }
    
    //  MARK: BindwithViewModel
    
    func bindDetailViewModel(){
        detailViewModel.fetchData()
        detailViewModel.items.bind { _ in
            DispatchQueue.main.async { [self] in
                let datas = detailViewModel.items.value
                for data in datas{
                    titleLabel.text = data.name
                    imageView.kf.indicatorType = .activity
                    imageView.kf.setImage(with: URL(string: data.image_url), placeholder: nil, options: nil, completionHandler: nil)
                    taglineLabel.text = data.tagline
                    descriptionTitle.text = data.description
                }
            }
        }
    }
    
    //  MARK: Fetch Id From VC & Set to ViewModel
    func getElementId(id: String){
        detailViewModel.fetchById(id: id)
        bindDetailViewModel()
    }
}


