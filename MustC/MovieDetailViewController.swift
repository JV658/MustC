//
//  MovieDetailViewController.swift
//  MustC
//
//  Created by Cambrian on 2023-11-22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    var movie: Movies!
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var directorField: UITextField!
    @IBOutlet weak var releaseDateField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if movie != nil {
            titleField.text = movie.title
            directorField.text = movie.director
        }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
