import UIKit

struct QuizMovieQuote{
    let movieName: String
    let quote: String
    let image: String
}

class MovieQuizViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var guessMovieTextField: RVS_AutofillTextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var correctGuessImage: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    var quiz_movies = [Movie]()
    var quotes = [QuizMovieQuote]()
    var totalScore = 0
    var currentQuote = 0
    var MoviesNamesDictionary: [String] = [ "Call",
                                                "Forgotten",
                                                "Pandora",
                                                "Sweet & Sour",
                                                "The Flu",
                                                "Train to Busan"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guessMovieTextField?.dataSource = self
        guessMovieTextField?.delegate = self
        setQuiz()
    }
    func setQuiz(){
        for movie in quiz_movies {
            if movie.isSelected{
                for quote in movie.quotes{
                    quotes.append(QuizMovieQuote(movieName: movie.name, quote: quote,image: movie.image))
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
                totalScore = totalScore + 1
                scoreLabel.text = "Score: \(totalScore)"
                guessMovieTextField.text = ""
                guessMovieTextField.isHidden = true
                scoreLabel.isHidden = true
                guessButton.isHidden = true
                quoteLabel.isHidden = true
               
                correctGuessImage.image = UIImage(named: quotes[currentQuote].image)
                
                correctGuessImage.isHidden = false
                nextButton.isHidden = false
             
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
    
    @IBAction func nextButton(_ sender: UIButton) {
        guessMovieTextField.isHidden = false
        scoreLabel.isHidden = false
        guessButton.isHidden = false
        quoteLabel.isHidden = false
       
        
        correctGuessImage.isHidden = true
        nextButton.isHidden = true
        nextMovie()
    }
    
}
extension MovieQuizViewController: RVS_AutofillTextFieldDataSource {
    /* ################################################################## */
    /**
     This is an Array of structs, that are the searchable data collection for the text field.
     If this is empty, then no searches will return any results.
     */
    var textDictionary: [RVS_AutofillTextFieldDataSourceType] {
        var index = 0
        
        let ret: [RVS_AutofillTextFieldDataSourceType] = MoviesNamesDictionary.compactMap {
            let currentStr = $0.trimmingCharacters(in: .whitespacesAndNewlines)
            if !currentStr.isEmpty {
                defer { index += 1 }
                return RVS_AutofillTextFieldDataSourceType(value: currentStr, refCon: index)
            }
            
            return nil
        }
        
        return ret
    }
}


extension MovieQuizViewController: RVS_AutofillTextFieldDelegate {
    /* ################################################################## */
    /**
     This is called when the user selects one of the autofill choices.
     In this app, all we do is print to the debug console.
     - parameter inAutofillTextField: The text field instance that the user affected.
     - parameter selectionWasMade: The data item, with the string and the refCon.
     */
    func autoFillTextField(_ inAutofillTextField: RVS_AutofillTextField, selectionWasMade inSelectedItem: RVS_AutofillTextFieldDataSourceType) {
        print("The user selected this: \(inSelectedItem.debugDescription)")
    }
}
