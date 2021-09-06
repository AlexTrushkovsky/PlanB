import UIKit

class GameViewController: UIViewController {
    var cardsText = GameModeTexts.first
    var tags: [TagView]?
    var cardModels = [CardModel]()
    @IBOutlet weak var swipeCardStack: SwipeCardStack!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        generateCards()
        swipeCardStack.delegate = self
        swipeCardStack.dataSource = self
    }
    
    func setupUI() {
        if cardsText.elementsEqual(GameModeTexts.third) {
            view.applyGradient(colors: [0xFF602F.toColor().cgColor, 0xA60B37.toColor().cgColor])
        } else if cardsText.elementsEqual(GameModeTexts.second) {
            view.applyGradient(colors: [0xF19197.toColor().cgColor, 0xA60B39.toColor().cgColor])
        } else {
            view.applyGradient(colors: [0xFFF48C.toColor().cgColor, 0xDAB018.toColor().cgColor])
        }
    }
    
    func generateCards() {
        guard let tags = tags else { return }
        var cards = [CardModel]()
        for (index, _) in tags.enumerated() {
            let imageName = UIImage(named: "face_\(Int.random(in: 1..<6))")
            var text = cardsText[Int.random(in: 0..<cardsText.count)]
            var newTags = tags
            newTags.remove(at: index)
            if let randomName = newTags[Int.random(in: 0..<newTags.count)].titleLabel?.text {
                text = text.replacingOccurrences(of: "%name%", with: randomName)
            }
            let model = CardModel(text: text, image: imageName)
            cards.append(model)
        }
        self.cardModels = cards
    }
    
    
    @objc
    private func handleShift(_ sender: UIButton) {
        swipeCardStack.shift(withDistance: sender.tag == 1 ? -1 : 1, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: Data Source + Delegates

extension GameViewController: SwipeCardStackDataSource, SwipeCardStackDelegate {
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = SwipeCard()
        card.footerHeight = 500
        card.swipeDirections = [.left, .up, .right]
        let model = cardModels[index]
        card.content = CardContentView(withImage: model.image)
        card.footer = CardFooterView(subtitle: model.text)
        
        return card
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return cardModels.count
    }
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        generateCards()
        swipeCardStack.reloadData()
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
    }
    
}
