//
//  ViewController.swift
//  DojoRx
//
//  Created by Renan Benatti Dias on 05/03/18.
//  Copyright © 2018 Blue Origami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//        "Hiro", "Tadashi"
//        "Edna Mode", "Stitch"
//        "Lilo", "Fix-It Felix, Jr."
    
    let character = [
        DisneyCharacter(image: #imageLiteral(resourceName: "anger"), name: "Anger", description: "That's Anger. He cares very deeply about things being fair."),
        DisneyCharacter(image: #imageLiteral(resourceName: "anna"), name: "Anna of Arendelle", description: "Anna is the most caring, optimistic, and determined person you’ll ever meet."),
        
        DisneyCharacter(image: #imageLiteral(resourceName: "disgust"), name: "Disgust", description: "It's not brightly-colored or shaped like a dinosaur. Hold on, guys... it's broccoli!"),
        DisneyCharacter(image: #imageLiteral(resourceName: "rapunzel"), name: "Rapunzel", description: "Rapunzel is not a typical princess, she carries her magical blonde hair, which is 70 feet long."),
        
        DisneyCharacter(image: #imageLiteral(resourceName: "venellope"), name: "Vanellope von Schweetz", description: "Look, wise guy, I know I'm a racer. I can feel it in my code!"),
        DisneyCharacter(image: #imageLiteral(resourceName: "moana"), name: "Moana of Motunui", description: "Moana is a teenager who dreams of becoming a master wayfinder."),
        
        DisneyCharacter(image: #imageLiteral(resourceName: "joy"), name: "Joy", description: "Joy is the engine. She keeps everyone moving and happy."),
        DisneyCharacter(image: #imageLiteral(resourceName: "ralph"), name: "Ralph", description: "I'm gonna wreck it!"),
        
        DisneyCharacter(image: #imageLiteral(resourceName: "elsa"), name: "Elsa of Arendelle", description: "In the mountains of Arendelle, Elsa learned how to let go and embrace the icy powers that make her special."),
        DisneyCharacter(image: #imageLiteral(resourceName: "fear"), name: "Fear", description: "That's Fear. He's really good at keeping Riley safe."),
        
        DisneyCharacter(image: #imageLiteral(resourceName: "mulan"), name: "Fa Mulan", description: "She is inspired by the legendary Hua Mulan from the Chinese poem The Ballad of Mulan."),
        DisneyCharacter(image: #imageLiteral(resourceName: "sadness"), name: "Sadness", description: "Crying helps me slow down and obsess over the weight of life's problems."),
        
        DisneyCharacter(image: #imageLiteral(resourceName: "buzz"), name: "Buzz Lightyear", description: "Buzz Lightyear's sole mission keeping Andy's toy family together")
    ]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
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
        return character.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DisneyCharacterCell.identifier, for: indexPath) as? DisneyCharacterCell {
            cell.populateWith(viewModel: DisneyCharacterCellViewModel(disneyCharacter: character[indexPath.row]))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
