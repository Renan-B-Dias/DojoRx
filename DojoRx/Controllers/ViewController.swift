//
//  ViewController.swift
//  DojoRx
//
//  Created by Renan Benatti Dias on 05/03/18.
//  Copyright © 2018 Blue Origami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var characters: [DisneyCharacter] = []
    let network = Network()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        characters = network.getCharacters()
    }
    
    private func configureTableView() {
        navigationItem.title = "Disney Characters"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: DisneyCharacterCell.identifier, bundle: nil), forCellReuseIdentifier: DisneyCharacterCell.identifier)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DisneyCharacterCell.identifier, for: indexPath) as? DisneyCharacterCell {
            cell.populateWith(viewModel: DisneyCharacterCellViewModel(disneyCharacter: characters[indexPath.row]))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
