//
//  DetailViewController.swift
//  proj13
//
//  Created by Павел Чвыров on 20.12.2023.
//

import UIKit

class DetailViewController: UIViewController, AwesomeDelegate {
    
    var awesomeDelegate : AwesomeDelegate
    var imagePath : String!
    var person : Person
    var imageName : String
    var textField : UITextField!
    
    
    init(awesomeDelegate: AwesomeDelegate, person: Person) {
        self.awesomeDelegate = awesomeDelegate
        self.person = person
        
        
//        let imagePath = getDocumentDirectory().appendingPathComponent(person.imagePath)
//        detail.imagePath = imagePath.path
//        self.imagePath = person.imagePath
        
        self.imageName = person.name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    
    
    override func loadView() {

        let imageURL = getDocumentDirectory().appendingPathComponent(person.imagePath)
        imagePath = imageURL.path
        
        view = UIView()
        view.backgroundColor = .lightGray
        
        let photo = UIImage(contentsOfFile: imagePath)
        let imagePhoto = UIImageView(image: photo)
        let renameButton = UIButton(type: .system)
        
        imagePhoto.translatesAutoresizingMaskIntoConstraints = false
        
        textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = imageName
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 44)
//        imageName.isUserInteractionEnabled = false
        textField.borderStyle = .line
        
        
        
        
        
        renameButton.translatesAutoresizingMaskIntoConstraints = false
        renameButton.setTitle("Переименовать", for: .normal)
        renameButton.layer.borderWidth = 1
        renameButton.addTarget(self, action: #selector(renameTapped), for: .touchUpInside)
        
        
        
//        photo.
//        photo.translatesAutoresizingMaskIntoConstraints = false
//        photo.setTitle("ОТПРАВИТЬ", for: .normal)
//        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        view.addSubview(imagePhoto)
        view.addSubview(textField)
        view.addSubview(renameButton)
        NSLayoutConstraint.activate([
            
            
            imagePhoto.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imagePhoto.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imagePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePhoto.heightAnchor.constraint(equalTo: imagePhoto.widthAnchor),
            
            textField.bottomAnchor.constraint(equalTo: imagePhoto.topAnchor, constant: -10),
            textField.widthAnchor.constraint(equalTo:  imagePhoto.widthAnchor, multiplier: 0.8),
            textField.heightAnchor.constraint(equalToConstant: 80),
            textField.leadingAnchor.constraint(equalTo: imagePhoto.leadingAnchor),
            renameButton.widthAnchor.constraint(equalTo:  imagePhoto.widthAnchor, multiplier: 0.2),
            renameButton.heightAnchor.constraint(equalTo: textField.heightAnchor),
            renameButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            renameButton.trailingAnchor.constraint(equalTo: imagePhoto.trailingAnchor)
        
        ])
    }
    
    @objc func renameTapped(_ sender: UIButton){
        
        guard let rename = textField.text else { return }
        if rename == ""{
            return
        }
        renamePerson(imagePath: person.imagePath, newImageName: rename)
        
    }
    
    func renamePerson(imagePath : String, newImageName : String) {
        awesomeDelegate.renamePerson(imagePath: imagePath, newImageName: newImageName)
    }
    
    func getDocumentDirectory() -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    
}
