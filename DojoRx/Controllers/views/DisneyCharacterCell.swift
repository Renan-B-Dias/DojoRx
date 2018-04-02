//
//  DisneyCharacterCell.swift
//  DojoRx
//
//  Created by Renan Benatti Dias on 05/03/18.
//  Copyright © 2018 Blue Origami. All rights reserved.
//

import UIKit

protocol DisneyCharacterCellProtocol {
    var image: UIImage { get }
    var name: String { get }
    var description: String { get }
}

class DisneyCharacterCellViewModel: DisneyCharacterCellProtocol {
    let disneyCharacter: DisneyCharacter
    
    init(disneyCharacter: DisneyCharacter) {
        self.disneyCharacter = disneyCharacter
    }
    
    var image: UIImage {
        return disneyCharacter.image
    }
    
    var name: String {
        return disneyCharacter.name
    }
    
    var description: String {
        return disneyCharacter.description
    }
}

class DisneyCharacterCell: UITableViewCell {
    static let identifier = String(describing: DisneyCharacterCell.self)
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

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
    
    func populateWith(viewModel: DisneyCharacterCellProtocol) {
        self.characterImageView.image = viewModel.image
        self.nameLabel.text = viewModel.name
        self.descriptionLabel.text = viewModel.description
    }
}
