//
//  Network.swift
//  DojoRx
//
//  Created by Renan Benatti Dias on 02/04/18.
//  Copyright © 2018 Blue Origami. All rights reserved.
//

import Foundation
import RxSwift

class Network {
    
    private let characters = [
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
    
    func getCharacters() -> Observable<[DisneyCharacter]> {
        return Observable.create { [weak self] (observer) in
            guard let characters = self?.characters else {
                observer.onError(NSError(domain: "Failed to get characters!!", code: -1))
                return Disposables.create()
            }
            
            if characters.isEmpty {
                observer.onError(NSError(domain: "Characters are empty!!", code: -1))
            } else {
                observer.onNext(characters)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func getCharacterOf(name: String) -> Single<DisneyCharacter> {
        return Single.create { [weak self] (observer) in
            guard let characters = self?.characters else {
                observer(.error(NSError(domain: "Failed to get characters!!", code: -1)))
                return Disposables.create()
            }
            
            if let character = characters.first(where: { $0.name == name }) {
                observer(.success(character))
            } else {
                observer(.error(NSError(domain: "Did not find character!!", code: -1)))
            }
            
            return Disposables.create()
        }
    }
}
