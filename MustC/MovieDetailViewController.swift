//
//  MovieDetailViewController.swift
//  MustC
//
//  Created by Cambrian on 2023-11-22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var directorField: UITextField!
    @IBOutlet weak var releaseDateField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if titleField.text == "" {
            return
        }
        
        var newMovie = Movies(context: container.viewContext)
        // modify newMovie to be consistent with the view
        newMovie.title = titleField.text!
        newMovie.director = directorField.text!
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
