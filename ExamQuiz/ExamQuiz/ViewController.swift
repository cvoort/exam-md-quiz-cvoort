//
//  ViewController.swift
//  ExamQuiz
//
//  Created by SD on 13/05/2026.
//

import UIKit

import SwiftyJSON

enum State {
    case category
    case question
    case answer
    case score
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var RedButton: UIButton!
    @IBOutlet weak var BlueButton: UIButton!
    @IBOutlet weak var OrangeButton: UIButton!
    @IBOutlet weak var YellowButton: UIButton!
    @IBOutlet weak var GreenButton: UIButton!
    
    @IBOutlet weak var HideAnswerButton: UIButton!
    @IBOutlet weak var NextQuestionButton: UIButton!
    
    @IBOutlet weak var HideCategoryButton: UIButton!
    @IBOutlet weak var ShowCategoryButton: UIButton!
    
    @IBOutlet weak var AnswerField: UILabel!
    @IBOutlet weak var AnswerLabel: UILabel!
    @IBOutlet weak var QuestionField: UILabel!
    
    @IBOutlet weak var AnswerInput: UITextField!
    
    var quizQuestions: Array<[String: Any]> = []
    var categoryQuestions: Array<[String: Any]> = []
    var currentCategory: String = ""
    var questionCounter: Int = 0
    var isAnswerHidden: Bool = false
    
    var answerIsCorrect: Bool = false
    var correctAnswerCount: Int = 0
    var player: String = "Player"
    var playerScore: [String:Int] = ["red":0,"blue":0,"orange":0,"yellow":0,"green":0]
    var scoreBoard: [String: [String: Int]] = ["red":[:],"blue":[:],"orange":[:],"yellow":[:],"green":[:]]
    
    var state: State = .category
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupJsonData()
        self.updateUI()
    }

    @IBAction func DidTapYellowController(_ sender: UIButton) {
        self.switchCategory(newCategory: "yellow")
        self.setCategoryClasses()
        self.updateUI()
        self.showQuestion()
    }
    
    @IBAction func DidTapRedController(_ sender: UIButton) {
        self.switchCategory(newCategory: "red")
        self.setCategoryClasses()
        self.updateUI()
        self.showQuestion()
    }
    
    @IBAction func DidTapBlueController(_ sender: UIButton) {
        self.switchCategory(newCategory: "blue")
        self.setCategoryClasses()
        self.updateUI()
        self.showQuestion()
    }
    
    @IBAction func DidTapOrangeController(_ sender: UIButton) {
        self.switchCategory(newCategory: "orange")
        self.setCategoryClasses()
        self.updateUI()
        self.showQuestion()
    }
    
    @IBAction func DidTapGreenController(_ sender: UIButton) {
        self.switchCategory(newCategory: "green")
        self.setCategoryClasses()
        self.updateUI()
        self.showQuestion()
    }
    
    func switchCategory(newCategory: String) {
        categoryQuestions = quizQuestions.filter { $0["category"] as! String == newCategory }
        if currentCategory != newCategory {
            questionCounter = 0
            correctAnswerCount = 0
        }
        currentCategory = newCategory
        state = .question
    }
    
    @IBAction func DidTapNextQuestionController(_ sender: UIButton) {
        if questionCounter < (categoryQuestions.count - 1) {
            questionCounter += 1
            state = .question
        } else {
            state = .score
        }
        self.updateUI()
        self.showQuestion()
    }
    
    @IBAction func DidTapHideAnswerController(_ sender: UIButton) {
        // If hidden when clicked
        if isAnswerHidden == true {
            isAnswerHidden = false
            AnswerField.isHidden = false
            state = .answer
            answerIsCorrect = false
            
            // Label becomes
            HideAnswerButton.setTitle("Verberg Antwoord", for: .normal)
            self.updateUI()
            
        } else { // If not hidden when clicked
            isAnswerHidden = true
            AnswerField.isHidden = true
            
            // Label becomes
            HideAnswerButton.setTitle("Toon Antwoord", for: .normal)
            
        }
    }
    
    @IBAction func DidTapHideCategoryController(_ sender: UIButton) {
        self.toggleCategoryButtons(shouldShow: false)
        
        ShowCategoryButton.isHidden = false
        HideCategoryButton.isHidden = true
    }
    
    @IBAction func DidTapShowCategoryController(_ sender: UIButton) {
        self.toggleCategoryButtons(shouldShow: true)
        
        ShowCategoryButton.isHidden = true
        HideCategoryButton.isHidden = false
    }
    
    // Displays question
    private func showQuestion() {
        let question = categoryQuestions[questionCounter]
        
        QuestionField.text = question["question"] as? String
        AnswerField.text = question["answer"] as? String
    }
    
    // Runs after the user hits the Return key on the keyboard
    func textFieldShouldReturn(_ AnswerInput: UITextField) -> Bool {
        // Get text from text field
        let textFieldContents = AnswerInput.text!
        
        if state == .category {
            player = textFieldContents.lowercased()
            return true
        }
        
        let question = categoryQuestions[questionCounter]
        let answer = question["answer"] as? String
        
        // Determine if user answered correct + update correct quiz state
        if textFieldContents.lowercased() == answer?.lowercased() {
            answerIsCorrect = true
            correctAnswerCount += 1
        } else {
            answerIsCorrect = false
        }
        
        // app shows answer to user
        state = .answer
        
        self.updateUI()
        
        return true
    }
    
    func displayScoreAlert() {
        self.handleScore()
        
        let alert = UIAlertController(title: "Quiz Score",
                                      message: "Uw score is \(correctAnswerCount) van de \(categoryQuestions.count).",
                                      preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Sluiten",
                                          style: .default,
                                          handler: scoreAlertDismissed(_:))
        alert.addAction(dismissAction)
        
        let scoreAction = UIAlertAction(title: "Toon Scorebord",
                                        style: .default,
                                        handler: displayScoreBoardAlert(_:))
        alert.addAction(scoreAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func scoreAlertDismissed(_ action: UIAlertAction) {
        state = .category
        currentCategory = ""
        self.setCategoryClasses()
        self.updateUI()
    }
    
    func displayScoreBoardAlert(_ action: UIAlertAction) {
        var scoreDisplay = ""
        
        let categoryScores: [String: Int] = scoreBoard[currentCategory] ?? [:]
        let sortedScores = categoryScores.sorted(by: { $0.value > $1.value })
        let topScores = sortedScores.prefix(4)
        
        var i = 1
        for (index, value) in topScores {
            scoreDisplay += "\(i). \(index): \(value) \n"
            i += 1
        }
        
        let scoreBoardAlert = UIAlertController(title: "Scorebord",
                                                message: scoreDisplay,
                                                preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Sluiten",
                                          style: .default,
                                          handler: scoreAlertDismissed(_:))
        
        scoreBoardAlert.addAction(dismissAction)
        
        present(scoreBoardAlert, animated: true, completion: nil)
    }
    
    // SMALL FUNCTIONS
    
    func handleScore() {
        if player == "" {
            return
        }
        
        if (scoreBoard[currentCategory]?.keys.contains(player) ?? false) {
            if scoreBoard[currentCategory]?[player] ?? 0 < correctAnswerCount {
                scoreBoard[currentCategory]?[player] = correctAnswerCount
            }
            print(scoreBoard)
            return
        }
        
        var currentCategoryScore: [String: Int] = scoreBoard[currentCategory] ?? [:]
        currentCategoryScore[player] = correctAnswerCount
        
        scoreBoard[currentCategory] = currentCategoryScore
        print(scoreBoard)
    }
    
    // Toggles visbility of category buttons
    func toggleCategoryButtons(shouldShow: Bool) {
        RedButton.isHidden = !shouldShow
        YellowButton.isHidden = !shouldShow
        OrangeButton.isHidden = !shouldShow
        GreenButton.isHidden = !shouldShow
        BlueButton.isHidden = !shouldShow
        
        if shouldShow == true { return }
        
        switch currentCategory {
        case "yellow":
            YellowButton.isHidden = false
        case "red":
            RedButton.isHidden = false
        case "orange":
            OrangeButton.isHidden = false
        case "green":
            GreenButton.isHidden = false
        case "blue":
            BlueButton.isHidden = false
        default:
            break
        }
    }
    
    // UI CHANGES
    
    //
    private func setCategoryClasses() {
        QuestionField.textColor = .black
        
        switch currentCategory {
        case "yellow":
            QuestionField.backgroundColor = .yellow
        case "red":
            QuestionField.backgroundColor = .red
        case "orange":
            QuestionField.backgroundColor = .orange
        case "green":
            QuestionField.backgroundColor = .green
        case "blue":
            QuestionField.backgroundColor = .blue
            QuestionField.textColor = .white
        default:
            QuestionField.backgroundColor = .black
            QuestionField.textColor = .white
        }
    }
    
    func updateUI() {
        // Text field and keyboard
        switch state {
        case .category:
            AnswerInput.isHidden = false
            AnswerInput.isEnabled = true
            AnswerInput.text = player
            AnswerInput.becomeFirstResponder()
        case .question:
            AnswerInput.isHidden = false
            AnswerInput.isEnabled = true
            AnswerInput.text = ""
            AnswerInput.becomeFirstResponder()
        case .answer:
            AnswerInput.isHidden = false
            AnswerInput.isEnabled = false
            AnswerInput.resignFirstResponder()
        case .score:
            AnswerInput.isHidden = true
            AnswerInput.resignFirstResponder()
        }
        
        // Answer label & field
        switch state {
        case .category:
            QuestionField.text = "Kies een categorie"
            AnswerLabel.text = "Vul je naam in"
            AnswerField.isHidden = true
            isAnswerHidden = true
            HideAnswerButton.setTitle("Toon Antwoord", for: .normal)
        case .question:
            AnswerLabel.text = "Antwoord"
            AnswerField.isHidden = true
            isAnswerHidden = true
            HideAnswerButton.setTitle("Toon Antwoord", for: .normal)
        case .answer:
            AnswerField.isHidden = false
            isAnswerHidden = false
            HideAnswerButton.setTitle("Verberg Antwoord", for: .normal)
            if answerIsCorrect {
                AnswerLabel.text = "Correct!"
            } else {
                AnswerLabel.text = "Incorrect!\nCorrect Antwoord:"
            }
        case .score:
            AnswerLabel.text = ""
            self.displayScoreAlert()
            print("Your score is \(correctAnswerCount) out of \(categoryQuestions.count).")
        }
        
        // Buttons
        if questionCounter == categoryQuestions.count - 1 {
            NextQuestionButton.setTitle("Toon Score", for: .normal)
        } else {
            NextQuestionButton.setTitle("Volgende Vraag", for: .normal)
        }
        
        switch state {
        case .category:
            // Top buttons
            NextQuestionButton.isHidden = true
            HideAnswerButton.isHidden = true
            
            // Category buttons
            self.toggleCategoryButtons(shouldShow: true)
            
            // Bottom buttons
            ShowCategoryButton.isHidden = true
            HideCategoryButton.isHidden = true
            
        case .question:
            // Top buttons
            NextQuestionButton.isHidden = false
            NextQuestionButton.isEnabled = false
            HideAnswerButton.isHidden = false
            
            // Category buttons
            self.toggleCategoryButtons(shouldShow: false)
            
            // Bottom buttons
            ShowCategoryButton.isHidden = false
            HideCategoryButton.isHidden = true
            
        case .answer:
            // Top buttons
            NextQuestionButton.isHidden = false
            NextQuestionButton.isEnabled = true
            HideAnswerButton.isHidden = false
            
            // Bottom buttons
        case .score:
            // Top buttons
            NextQuestionButton.isEnabled = false
            NextQuestionButton.isHidden = true
            HideAnswerButton.isHidden = true
            
            // Category Buttons
            self.toggleCategoryButtons(shouldShow: false)
            
            // Bottom buttons
            ShowCategoryButton.isHidden = true
            HideCategoryButton.isHidden = true
        }
    }
    
    // Retrieve JSON data from LocalQuizData.json
    private func setupJsonData() {
        guard let jsonPath = Bundle.main.path(forResource: "localQuizData", ofType: "json") else { return }
        let url = URL(fileURLWithPath: jsonPath)
        do {
            let data = try Data(contentsOf: url)
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                quizQuestions = jsonArray
            } else {
                print("bad json")
            }
        } catch {
            print(error)
        }
    }
}

