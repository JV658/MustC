//
//  MovieDetailViewController.swift
//  MustC
//
//  Created by Cambrian on 2023-11-22.
//

import UIKit
import CoreData

class MovieDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {



    var container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    var movie: Movies!
    var genres: [Genre] = []
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var directorField: UITextField!
    @IBOutlet weak var releaseDateField: UITextField!
    @IBOutlet weak var genreDropdown: UIButton!
    @IBOutlet weak var genrePicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if movie != nil {
            titleField.text = movie.title
            directorField.text = movie.director
        }
        
        genreDropdown.showsMenuAsPrimaryAction = true
        genreDropdown.changesSelectionAsPrimaryAction = true
        
        // todo: get the genres using a core data fetch
        let genreFetch = NSFetchRequest<Genre>(entityName: "Genre")
        genres = try! container.viewContext.fetch(genreFetch)
        
        // create an array of UIActions based on the results from the prior fetch
        var actionArray: [UIAction] = []
        
        for genre in genres {
            var state: UIMenuElement.State = .off
            if movie.genre == genre {
                state = .on
            }
            
            let newAction = UIAction(title: genre.name!,state: state) { action in
                self.movie.genre = genre
            }
            
            actionArray.append(newAction)
        }
        
        // make sure that the handler using the core data managed objected to save the proper genre to movie
        
        
        // add UIActions to genredropdown
        genreDropdown.menu = UIMenu(children: actionArray)
//
//        let handler = { (action: UIAction) in
//            print(action.title)
//        }
//
//        genreDropdown.menu = UIMenu(children: [
//            UIAction(title: "option 1", state: .on, handler: handler),
//            UIAction(title: "option 2", handler: handler),
//            UIAction(title: "option 3", handler: handler),
//            UIAction(title: "option 4", handler: handler)
//        ])
        
        
        genrePicker.delegate = self
        genrePicker.dataSource = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if titleField.text == "" {
            return
        }
        
        if movie == nil {
            movie = Movies(context: container.viewContext)
        }
        
        // modify newMovie to be consistent with the view
        movie.title = titleField.text!
        movie.director = directorField.text!
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    // MARK: - Picker SetUp
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "test \(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        
        let dst = segue.destination as! GenreTableViewController
        dst.movie = movie
    }

}
