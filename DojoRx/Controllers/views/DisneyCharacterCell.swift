//
//  DisneyCharacterCell.swift
//  DojoRx
//
//  Created by Renan Benatti Dias on 05/03/18.
//  Copyright © 2018 Blue Origami. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol DisneyCharacterCellProtocol {
    var imageObservable: Observable<UIImage> { get }
    var nameObservable: Observable<String> { get }
    var descriptionObservable: Observable<String> { get }
}

class DisneyCharacterCellViewModel: DisneyCharacterCellProtocol {
    private let disneyCharacter: DisneyCharacter
    
    private let imageVariable: Variable<UIImage>
    private let nameVariable: Variable<String>
    private let descriptionVariable: BehaviorRelay<String>
    
    init(disneyCharacter: DisneyCharacter) {
        self.disneyCharacter = disneyCharacter
        self.imageVariable = Variable(disneyCharacter.image)
        self.nameVariable = Variable(disneyCharacter.name)
        self.descriptionVariable = BehaviorRelay(value: disneyCharacter.description)
    }
    
    var imageObservable: Observable<UIImage> {
        return imageVariable.asObservable()
    }
    
    var nameObservable: Observable<String> {
        return nameVariable.asObservable()
    }
    
    var descriptionObservable: Observable<String> {
        return descriptionVariable.asObservable()
    }
}

class DisneyCharacterCell: UITableViewCell {
    static let identifier = String(describing: DisneyCharacterCell.self)
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var disposeBag: DisposeBag!
    var viewModel: DisneyCharacterCellProtocol? {
        didSet { bind() }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    private func applyLayout() {
        characterImageView.layer.cornerRadius = 10.0
        characterImageView.clipsToBounds = true
        
        descriptionLabel.numberOfLines = 0
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    private func bind() {
        disposeBag = DisposeBag()
        
        guard let viewModel = viewModel else { return }
        
        viewModel.nameObservable
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.descriptionObservable
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.imageObservable
            .bind(to: characterImageView.rx.image)
            .disposed(by: disposeBag)
    }
}
