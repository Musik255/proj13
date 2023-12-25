//
//  ViewController.swift
//  proj13
//
//  Created by Павел Чвыров on 20.12.2023.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AwesomeDelegate {
    func renamePerson(imagePath: String, newImageName: String) {
        for person in people {
            if person.imagePath == imagePath{
                person.name = newImageName
                
                save()
                tableView.reloadData()
                
                return
            }
        }
    }
    

    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        
        let defaults = UserDefaults.standard

        if let savedPeople = defaults.object(forKey: "people") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                people = try jsonDecoder.decode([Person].self, from: savedPeople)
            } catch {
                print("Failed to load people")
            }
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ////////
        
        let person = people[indexPath.item]
        let detail = DetailViewController(awesomeDelegate: self, person: person)
        
        
//        let imagePath = getDocumentDirectory().appendingPathComponent(person.imagePath)
//        detail.imagePath = imagePath.path
        
//        present(detail, animated: true)
        navigationController?.pushViewController(detail, animated: true)
        
    }
    
    
    
    
    
    @objc func addButton(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for:  indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = people[indexPath.item].name
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageUUID = UUID().uuidString
        let imagePath = getDocumentDirectory().appendingPathComponent(imageUUID)
//        let imagePath = Bundle.documentsDirectory.appending(path: imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            try? jpegData.write(to: imagePath)
        }
        let person = Person(name: "Unknown", imagePath: imageUUID)
        people.append(person)
        save()
        tableView.reloadData()
        
        dismiss(animated: true)
    }
    
    
    
    
    
    func getDocumentDirectory() -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save(){
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(people){
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        }
        else{
            print("Failed to save people.")
        }
    }
}

