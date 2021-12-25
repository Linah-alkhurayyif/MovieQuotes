import UIKit

struct Movie{
    let name: String
    let image: String
    var isSelected: Bool
    let quotes: [String]
    
}

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var movies = [Movie(name: "Call", image: "Call",isSelected: false, quotes:["callQuote1"]),Movie(name: "Forgotten", image: "Forgotten",isSelected: false,quotes:["forgottenQuote1","forgottenQuote2","forgottenQuote3"]),Movie(name: "Pandora", image: "Pandora",isSelected: false,quotes:["pandoraQuote1","pandoraQuote2","pandoraQuote3"]),Movie(name: "Sweet & Sour", image: "Sweet&Sour",isSelected: false,quotes:["sweet&SourQuote1"]),Movie(name: "The Flu", image: "The Flu",isSelected: false,quotes:["theFluQuote1","theFluQuote2"]),Movie(name: "Train to Busan", image: "Train to Busan",isSelected: false,quotes:["trainBusanQuote1","trainBusanQuote2"])]
    
    var selectedMovies = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc(gesture: )))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }

    @objc func swipeFunc(gesture: UISwipeGestureRecognizer){
        if selectedMovies > 0{
            performSegue(withIdentifier: "MovieQuizSegue", sender: self)
        }else{
            let alert = UIAlertController(title: "No movie selected!!", message: "Please select one movie or more to start the quiz", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieQuizViewController = segue.destination as! MovieQuizViewController
        movieQuizViewController.quiz_movies = movies
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCellCollectionViewCell
        cell.movieName.text = movies[indexPath.item].name
        cell.movieImage.image = UIImage(named: movies[indexPath.item].image)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        if( movies[indexPath.item].isSelected){
            movies[indexPath.item].isSelected = false
            cell?.isSelected = false

            
            cell?.layer.borderWidth = 0
            cell?.backgroundColor = UIColor(named: "bg")
            selectedMovies = selectedMovies - 1
        }else{
            movies[indexPath.item].isSelected = true
            cell?.isSelected = true

            cell?.layer.borderColor = UIColor(named: "brown")?.cgColor
            cell?.layer.borderWidth = 2
            cell?.backgroundColor = UIColor(named: "brown")
            selectedMovies = selectedMovies + 1
       
        }
      
    }
  
}
