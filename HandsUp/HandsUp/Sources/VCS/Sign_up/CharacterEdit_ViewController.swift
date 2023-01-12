
import UIKit

class CharacterEdit_ViewController: UIViewController {
    
    @IBOutlet var characterView: Character_UIView!
    
    func reload(){
        characterView.setCharacter()
    }
    
    @IBAction func orange(_ sender: Any) {
        characterView.bgType = 0
        reload()
    }
    
    @IBAction func blue(_ sender: Any) {
        characterView.bgType = 1
        reload()
    }
    @IBAction func curly(_ sender: Any) {
        characterView.headType = 0
        reload()
    }
    
    @IBAction func short(_ sender: Any) {
        characterView.headType = 1
        reload()
    }
    
    @IBAction func bald(_ sender: Any) {
        characterView.headType = 2
        reload()
    }
    
    @IBAction func beanie(_ sender: Any) {
        characterView.headType = 3
        reload()
    }
    
    @IBAction func fomade(_ sender: Any) {
        characterView.headType = 4
        reload()
    }
    
    @IBAction func eyebrow1(_ sender: Any) {
        characterView.eyebrowType = 0
        reload()
    }
    
    @IBAction func eyebrow2(_ sender: Any) {
        characterView.eyebrowType = 1
        reload()
    }
    
    @IBAction func eyebrow3(_ sender: Any) {
        characterView.eyebrowType = 2
        reload()}
    
    @IBAction func mouth1(_ sender: Any) {
        characterView.mouthType = 0
        reload()}
    
    @IBAction func mouth2(_ sender: Any) {
        characterView.mouthType = 1
        reload()}
    
    @IBAction func mouth3(_ sender: Any) {
        characterView.mouthType = 2
        reload()}
    
    @IBAction func mouth4(_ sender: Any) {
        characterView.mouthType = 3
        reload()}
    
    @IBAction func nose1(_ sender: Any) {
        characterView.noseType = 0
        reload()}
    
    @IBAction func nose2(_ sender: Any) {
        characterView.noseType = 1
        reload()}
    
    @IBAction func nose3(_ sender: Any) {
        characterView.noseType = 2
        reload()}
    
    @IBAction func nose4(_ sender: Any) {
        characterView.noseType = 3
        reload()}
    
    @IBAction func eyes1(_ sender: Any) {
        characterView.eyesType = 0
        reload()}
    
    @IBAction func eyes2(_ sender: Any) {
        characterView.eyesType = 1
        reload()}
    
    @IBAction func eyes3(_ sender: Any) {
        characterView.eyesType = 2
        reload()}
    
    @IBAction func eyes4(_ sender: Any) {
        characterView.eyesType = 3
        reload()}
    
    @IBAction func noglasses(_ sender: Any) {
        characterView.glassesType = 0
        reload()}
    
    @IBAction func sunglasses(_ sender: Any) {
        characterView.glassesType = 3
        
        
        reload()}
    
    @IBAction func glasses1(_ sender: Any) {
        characterView.glassesType = 1
        reload()}
    
    @IBAction func glasses2(_ sender: Any) {
        characterView.glassesType = 2
        reload()}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterView.setCharacter()
        // Do any additional setup after loading the view.
    }
    
    
    
}
