//
//  MainViewController.swift
//  PlanB
//
//  Created by Алексей Трушковский on 30.08.2021.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var bottomView: UIStackView!
    @IBOutlet weak var banner: UIView!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if textField.text != "" && textField.text != nil {
            var isOnly = true
            for tag in tagListView.tagViews {
                if tag.titleLabel?.text == textField.text! {
                    isOnly = false
                }
            }
            if isOnly {
                tagListView.addTag(textField.text!)
            } else {
                let alert = UIAlertController(title: "Ошибка", message: "Нельзя добавить одинаковые имена", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { action in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
            textField.text = ""
        }
    }
    @IBAction func startButtonPressed(_ sender: UIButton) {
        if tagListView.tagViews.count >= 2 {
            guard let modeView = storyboard?.instantiateViewController(withIdentifier: "modeView") as? ModeViewController else { return }
            modeView.tags = tagListView.tagViews
            modeView.modalPresentationStyle = .fullScreen
            self.present(modeView, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Игроков должно быть больше одного", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagListView.delegate = self
        textField.addPadding(padding: .left(20))
        textField.addPadding(padding: .right(20))
        textField.layer.cornerRadius = textField.layer.frame.height/2
        setupTagList()
        KeyboardAvoiding.avoidingView = self.bottomView
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupTagList() {
        tagListView.textFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
        tagListView.removeButtonIconSize = 10
        tagListView.cornerRadius = 15
        tagListView.marginX = 6
        tagListView.marginY = 6
    }


}

extension MainViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}

