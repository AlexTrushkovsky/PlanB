//
//  ModeViewController.swift
//  PlanB
//
//  Created by Алексей Трушковский on 01.09.2021.
//

import UIKit
import StepSlider

class ModeViewController: UIViewController {
    var tags: [TagView]?
    var mode = GameModeTexts.first
    
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var modeGameMenu: UIView!
    @IBOutlet weak var modeGameInsideView: UIView!
    @IBOutlet weak var textBoxBackground: UIView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var modeDescriptionTextField: UITextView!
    @IBOutlet weak var peopleCountTextField: UILabel!
    @IBOutlet weak var timeTextField: UILabel!
    @IBOutlet weak var stepSlider: StepSlider!
    
    
    @IBAction func firstModeButtonTapped(_ sender: UIButton) {
        stepSlider.setIndex(0, animated: true)
    }
    @IBAction func secondModeButtonTapped(_ sender: UIButton) {
        stepSlider.setIndex(1, animated: true)
    }
    @IBAction func thirdModeButtonTapped(_ sender: UIButton) {
        stepSlider.setIndex(2, animated: true)
    }
    @IBAction func valueChanged(_ sender: StepSlider) {
        setGameMode(index: Int(sender.index))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyGradient(colors: [0xFFF48C.toColor().cgColor, 0xDAB018.toColor().cgColor])
        modeGameMenu.layer.cornerRadius = 20
        modeGameInsideView.clipsToBounds = true
        modeGameInsideView.layer.cornerRadius = 20
        modeGameInsideView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        textBoxBackground.layer.cornerRadius = 15
        separatorView.layer.cornerRadius = separatorView.layer.frame.width / 2
    }
    
    func setGameMode(index: Int) {
        switch index {
        case 2:
            self.mode = GameModeTexts.third
            self.view.layer.sublayers?.first?.removeFromSuperlayer()
            view.applyGradient(colors: [0xFF602F.toColor().cgColor, 0xA60B37.toColor().cgColor])
            self.startGameButton.setText(text: "Разблокировать")
            self.modeDescriptionTextField.setText(text: "Для отбитых компаний, которым хочется чего-то нового. Каверзные вопросы и задания, узнай компанию получше")
            self.peopleCountTextField.setText(text: "6+")
            self.timeTextField.setText(text: "90+")
        case 1:
            self.mode = GameModeTexts.second
            self.view.layer.sublayers?.first?.removeFromSuperlayer()
            view.applyGradient(colors: [0xF19197.toColor().cgColor, 0xA60B39.toColor().cgColor])
            self.startGameButton.setText(text: "Разблокировать")
            self.modeDescriptionTextField.setText(text: "Жаркая игра с партнером. Вопросы, ответы на которые ты мог не знать, различные горячие задания для двоих")
            self.peopleCountTextField.setText(text: "2+")
            self.timeTextField.setText(text: "30+")
        default:
            self.mode = GameModeTexts.first
            self.view.layer.sublayers?.first?.removeFromSuperlayer()
            view.applyGradient(colors: [0xFFF48C.toColor().cgColor, 0xDAB018.toColor().cgColor])
            self.startGameButton.setText(text: "Играть")
            self.modeDescriptionTextField.setText(text: "Веселая посиделка в компании. Обычные вопросы и задания, чтобы не думать головой")
            self.peopleCountTextField.setText(text: "3+")
            self.timeTextField.setText(text: "60+")
        }
        animateBackView(index: index)
    }
    
    func animateBackView(index: Int) {
        var color = 0x87E013.toColor()
        if index == 1 || index == 2 {
            color = 0xFF6030.toColor()
        }
        UIView.animate(withDuration: 0.2) {
            self.modeGameMenu.backgroundColor = color
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        guard let gameView = storyboard?.instantiateViewController(withIdentifier: "gameView") as? GameViewController else { return }
        gameView.tags = tags
        gameView.cardsText = mode
        gameView.modalPresentationStyle = .fullScreen
            self.present(gameView, animated: true, completion: nil)
    }
    
    
}
