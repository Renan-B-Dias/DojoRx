//
//  DisneyDetailsViewController.swift
//  DojoRx
//
//  Created by Renan Benatti Dias on 09/05/18.
//  Copyright © 2018 Blue Origami. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol DisneyDetailsViewControllerInterface {
    var image: Observable<UIImage> { get }
    var name: Observable<String> { get }
    var description: Observable<String> { get }
}

class DisneyDetailsViewControllerViewModel: DisneyDetailsViewControllerInterface {
    
    let imageVariable: BehaviorRelay<UIImage>   // BehaviorRelay == 'old' Variable
    let nameVariable: BehaviorRelay<String>
    let descriptionVariable: BehaviorRelay<String>
    
    init(character: DisneyCharacter) {
        imageVariable = BehaviorRelay(value: character.image)
        nameVariable = BehaviorRelay(value: character.name)
        descriptionVariable = BehaviorRelay(value: character.description)
    }
    
    var image: Observable<UIImage> {
        return imageVariable.asObservable()
    }
    
    var name: Observable<String> {
        return nameVariable.asObservable()
    }
    
    var description: Observable<String> {
        return descriptionVariable.asObservable()
    }
}

class DisneyDetailsViewController: UIViewController {
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    var characterViewModel: DisneyDetailsViewControllerInterface? {
        didSet { bind() } // For when we need to change the view while it is presenting
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyLayout()
        applyTexts()
        bind()  // Actual call that works while presenting view
        
        let closeButton = UIBarButtonItem(title: "X", style: .done, target: self, action: #selector(close))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc func close() {
        self.dismiss(animated: true)
    }
    
    private func applyLayout() {
        characterImage.clipsToBounds = true
        
        nameLabel.numberOfLines = 1
        characterNameLabel.numberOfLines = 1
        
        descriptionLabel.numberOfLines = 1
        characterDescriptionLabel.numberOfLines = 0
    }
    
    private func applyTexts() {
        nameLabel.text = "Name"
        descriptionLabel.text = "Description"
    }
    
    private func bind() {
        guard isViewLoaded else { return }
        
        guard let characterViewModel = characterViewModel else { return }
        
        characterViewModel.image
            .bind(to: characterImage.rx.image)
            .disposed(by: disposeBag)
        
        characterViewModel.name
            .bind(to: characterNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        characterViewModel.description
            .bind(to: characterDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
