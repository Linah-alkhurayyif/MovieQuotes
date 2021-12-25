import UIKit

struct QuizMovieQuote{
    let movieName: String
    let quote: String
}

class MovieQuizViewController: UIViewController {
    

    @IBOutlet weak var guessMovieTextField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var quoteLabel: UILabel!
    
    var quiz_movies = [Movie]()
    var quotes = [QuizMovieQuote]()
    var totalScore = 0
    var currentQuote = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setQuiz()
    }
    func setQuiz(){
        for movie in quiz_movies {
            if movie.isSelected{
                for quote in movie.quotes{
                    quotes.append(QuizMovieQuote(movieName: movie.name, quote: quote))
                }
            }
           
        }
        quotes.shuffle()
        quoteLabel.text = quotes[currentQuote].quote
    }

    @IBAction func goHome(_ sender: UIButton) {
        let alert = UIAlertController(title: "Quit Quiz!!", message: "Are you sure you want to end quiz?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "End", style: .default, handler: {action in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func guessMovie(_ sender: UIButton) {
        if guessMovieTextField.text == ""{
            let alert = UIAlertController(title: "Empty field!!", message: "Guess must be filled out?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            if guessMovieTextField.text?.lowercased() == quotes[currentQuote].movieName.lowercased(){
                totalScore = totalScore + 10
                scoreLabel.text = "Score: \(totalScore)"
                guessMovieTextField.text = ""
                nextMovie()
            }else{
                let alert = UIAlertController(title: "Wrong Guess!!", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{action in
                    self.nextMovie()
                }))
                self.present(alert, animated: true, completion: nil)
                guessMovieTextField.text = ""
            }
          
        }
       
    }
    func nextMovie(){
        if currentQuote < quotes.count-1{
            currentQuote = currentQuote + 1
            quoteLabel.text = quotes[currentQuote].quote
        }else{
            print("hii")
            let alert = UIAlertController(title: "Quiz Over", message: "You have guessed \(totalScore) out of \(quotes.count) movies quotes correctly", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
