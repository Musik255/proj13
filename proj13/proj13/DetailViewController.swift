//
//  DetailViewController.swift
//  proj13
//
//  Created by Павел Чвыров on 20.12.2023.
//

import UIKit

class DetailViewController: UIViewController, AwesomeDelegate {
    
   
    

    var awesomeDelegate : AwesomeDelegate
    
    func save(data: String) {
        awesomeDelegate.save(data: data)
    }
    
    
    var imagePath : String!
    var imageName : UITextField!

    init(_ awesomeDelegate: AwesomeDelegate) {
        self.awesomeDelegate = awesomeDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    override func loadView() {
//        let namePhoto = UIButton(type: .system)
        
        
        view = UIView()
        view.backgroundColor = .lightGray
        
        let photo = UIImage(contentsOfFile: imagePath)
        let imagePhoto = UIImageView(image: photo)
        let renameButton = UIButton(type: .system)
        
        imagePhoto.translatesAutoresizingMaskIntoConstraints = false
        
        imageName = UITextField()
        imageName.translatesAutoresizingMaskIntoConstraints = false
        imageName.placeholder = "err"
        imageName.textAlignment = .center
        imageName.font = UIFont.systemFont(ofSize: 44)
//        imageName.isUserInteractionEnabled = false
        imageName.borderStyle = .line
        
        
        
        
        
        renameButton.translatesAutoresizingMaskIntoConstraints = false
        renameButton.setTitle("Переименовать", for: .normal)
        renameButton.layer.borderWidth = 1
        renameButton.addTarget(self, action: #selector(renameTapped), for: .touchUpInside)
        
        
        
//        photo.
//        photo.translatesAutoresizingMaskIntoConstraints = false
//        photo.setTitle("ОТПРАВИТЬ", for: .normal)
//        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        view.addSubview(imagePhoto)
        view.addSubview(imageName)
        view.addSubview(renameButton)
        NSLayoutConstraint.activate([
            
            
            imagePhoto.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imagePhoto.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imagePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePhoto.heightAnchor.constraint(equalTo: imagePhoto.widthAnchor),
            
            imageName.bottomAnchor.constraint(equalTo: imagePhoto.topAnchor, constant: -10),
            imageName.widthAnchor.constraint(equalTo:  imagePhoto.widthAnchor, multiplier: 0.8),
            imageName.heightAnchor.constraint(equalToConstant: 80),
            imageName.leadingAnchor.constraint(equalTo: imagePhoto.leadingAnchor),
            renameButton.widthAnchor.constraint(equalTo:  imagePhoto.widthAnchor, multiplier: 0.2),
            renameButton.heightAnchor.constraint(equalTo: imageName.heightAnchor),
            renameButton.bottomAnchor.constraint(equalTo: imageName.bottomAnchor),
            renameButton.trailingAnchor.constraint(equalTo: imagePhoto.trailingAnchor)
        
        ])
    }
    
    @objc func renameTapped(_ sender: UIButton){
        
        guard let renameText = imageName.text else { return }
        if renameText == ""{
            return
        }
        
       
//        print(renameText)
        save(data: renameText)
        
         
//        if let solutionPosition = solutions.firstIndex(of: answerText){
//            
//            solutions[solutionPosition] = ""
//            activatedButtons.removeAll()
//            
//            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
//            splitAnswers?[solutionPosition] = answerText
//            answersLabel.text = splitAnswers?.joined(separator: "\n")
//            
//            imageName.text = ""
//            score += 1
//            
//            
//            for solution in solutions {
//                if solution != ""{
//                     return
//                }
//                
//            }
//            
//            let alertController = UIAlertController(title: "Супер! Все слова отгаданы!", message: "Готовы приступить к следующему уровню?", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Поехали!", style: .default, handler: levelUp))
//            present(alertController, animated: true)
//            
//        }
//        else{
//            let alertController = UIAlertController(title: "Ошибка", message: "Такое слово не было загадано", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Попробовать еще раз", style: .default))
//            imageName.text = ""
//            
//            for button in activatedButtons{
//                button.isHidden = false
//            }
//            activatedButtons.removeAll()
//            score -= 1
//            present(alertController, animated: true)
//        }
//        
    }
}
