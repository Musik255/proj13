//
//  ViewController.swift
//  proj13
//
//  Created by Павел Чвыров on 20.12.2023.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AwesomeDelegate {
    func save(data: String) {
        print(data)
    }
    

    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        
        
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ////////
        let detail = DetailViewController(self)
        let person = people[indexPath.item]
        
        
        
        let imagePath = getDocumentDirectory().appendingPathComponent(person.image)
        detail.imagePath = imagePath.path
        
//        present(detail, animated: true)
        navigationController?.pushViewController(detail, animated: true)
        
    }
    
    
    
    
    
    @objc func addButton(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for:  indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "cell\(indexPath.row)"
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)
//        let imagePath = Bundle.documentsDirectory.appending(path: imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            try? jpegData.write(to: imagePath)
        }
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        tableView.reloadData()
//        save()
        dismiss(animated: true)
    }
    
    
    
    func getDocumentDirectory() -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    

}	

