//
//  ViewController.swift
//  ChenxingOuyangLab 5
//
//  Created by ouyang chenxing on 3/25/17.
//  Copyright © 2017 ouyang chenxing. All rights reserved.
//

import Cocoa
import AudioToolbox
import AVFoundation

class ViewController: NSViewController {


    @IBOutlet weak var foodView: DisplayView!
    @IBOutlet weak var happyView: DisplayView!
    @IBOutlet weak var foodWarning: NSTextField!
    @IBOutlet weak var feedTimes: NSTextField!
    @IBOutlet weak var happyWarning: NSTextField!
    @IBOutlet weak var playTimes: NSTextField!
    @IBOutlet weak var backView: NSView!
    @IBOutlet weak var petImage: NSImageView!
    @IBOutlet weak var growthCount: NSTextField!
    @IBOutlet weak var load: NSButton!
    
    
    var dogInstance:PetPlayFeed!
    var catInstance:PetPlayFeed!
    var birdInstance:PetPlayFeed!
    var bunnyInstance:PetPlayFeed!
    var fishInstance:PetPlayFeed!
    var customInstance:PetPlayFeed!
    var petType = ""
    var player = AVAudioPlayer()
    var customImage: [NSImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogInstance = PetPlayFeed(name: "Dog")
        catInstance = PetPlayFeed(name: "Cat")
        birdInstance = PetPlayFeed(name: "Bird")
        bunnyInstance = PetPlayFeed(name: "Bunny")
        fishInstance = PetPlayFeed(name: "Fish")
        customInstance = PetPlayFeed(name: "Custom")
        foodView.color = CGColor(red: 64/255, green: 224/255, blue: 205/255, alpha:1)
        happyView.color = CGColor(red: 0/255, green: 199/255, blue: 140/255, alpha:1)
        self.backView.wantsLayer = true
    }
    
    override func viewWillAppear() {
        backView.layer?.backgroundColor = NSColor.cyan.cgColor
        updateDogView()
    }
    
    private func updateDogView() {
        let foodValue = Double(dogInstance.foodLevel)/10
        let happyValue = Double(dogInstance.happinessLevel)/10
        
        foodView.animateValue(to: CGFloat(foodValue))
        happyView.animateValue(to: CGFloat(happyValue))
        playTimes.stringValue = "played:" + String(dogInstance.playCount)
        feedTimes.stringValue = "fed:" + String(dogInstance.feedCount)
        growthCount.stringValue = "growth:" + String(dogInstance.growthValue)
        fullWarning(foodValue: foodValue,happyValue: happyValue)
        
    }
    private func updateCatView() {
        let foodValue = Double(catInstance.foodLevel)/10
        let happyValue = Double(catInstance.happinessLevel)/10
        
        foodView.animateValue(to: CGFloat(foodValue))
        happyView.animateValue(to: CGFloat(happyValue))
        playTimes.stringValue = "played:" + String(catInstance.playCount)
        feedTimes.stringValue = "fed:" + String(catInstance.feedCount)
        growthCount.stringValue = "growth:" + String(catInstance.growthValue)
        fullWarning(foodValue: foodValue,happyValue: happyValue)
        
    }
    private func updateBirdView() {
        
        let foodValue = Double(birdInstance.foodLevel)/10
        let happyValue = Double(birdInstance.happinessLevel)/10
        
        foodView.animateValue(to: CGFloat(foodValue))
        happyView.animateValue(to: CGFloat(happyValue))
        playTimes.stringValue = "played:" + String(birdInstance.playCount)
        feedTimes.stringValue = "fed:" + String(birdInstance.feedCount)
        growthCount.stringValue = "growth:" + String(birdInstance.growthValue)
        fullWarning(foodValue: foodValue,happyValue: happyValue)
        
        
    }
    private func updateBunnyView() {
        let foodValue = Double(bunnyInstance.foodLevel)/10
        let happyValue = Double(bunnyInstance.happinessLevel)/10
        
        foodView.animateValue(to: CGFloat(foodValue))
        happyView.animateValue(to: CGFloat(happyValue))
        playTimes.stringValue = "played:" +  String(bunnyInstance.playCount)
        feedTimes.stringValue = "fed:" + String(bunnyInstance.feedCount)
        growthCount.stringValue = "growth:" + String(bunnyInstance.growthValue)
        fullWarning(foodValue: foodValue,happyValue: happyValue)
        
    }
    private func updateFishView() {
        let foodValue = Double(fishInstance.foodLevel)/10
        let happyValue = Double(fishInstance.happinessLevel)/10
        
        foodView.animateValue(to: CGFloat(foodValue))
        happyView.animateValue(to: CGFloat(happyValue))
        playTimes.stringValue = "played:" + String(fishInstance.playCount)
        feedTimes.stringValue = "fed:" + String(fishInstance.feedCount)
        growthCount.stringValue = "growth:" + String(fishInstance.growthValue)
        fullWarning(foodValue: foodValue,happyValue: happyValue)
    }
    
    private func updateCustomView() {
        let foodValue = Double(customInstance.foodLevel)/10
        let happyValue = Double(customInstance.happinessLevel)/10
        
        foodView.animateValue(to: CGFloat(foodValue))
        happyView.animateValue(to: CGFloat(happyValue))
        playTimes.stringValue = "played:" + String(customInstance.playCount)
        feedTimes.stringValue = "fed:" + String(customInstance.feedCount)
        growthCount.stringValue = "growth:" + String(customInstance.growthValue)
        fullWarning(foodValue: foodValue,happyValue: happyValue)
    }
    
    private func fullWarning(foodValue:Double, happyValue:Double){
        if (foodValue >= 1){
            foodWarning.stringValue = "HIC!"
            //play the system sound when the food value is full
            AudioServicesPlaySystemSound(createHicSound())
        }else{
            foodWarning.stringValue = "Food level:"
        }
        if (happyValue >= 1){
            happyWarning.stringValue = "HAHAHA!"
            //play another system sound when the happy value is full
            AudioServicesPlaySystemSound(createLaughSound())
        }else{
            happyWarning.stringValue = "Happiness:"
        }
        
    }
    
    //create two system sounds
    private func createHicSound() -> SystemSoundID {
        var soundID:SystemSoundID = 0
        let souundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "hic" as CFString!, "wav" as CFString!, nil)
        AudioServicesCreateSystemSoundID(souundURL!, &soundID)
        return soundID
    }
    private func createLaughSound() -> SystemSoundID {
        var soundID:SystemSoundID = 1
        let souundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "hahaha" as CFString!, "wav" as CFString!, nil)
        AudioServicesCreateSystemSoundID(souundURL!, &soundID)
        return soundID
    }
    
    
    @IBAction func playPet(_ sender: Any) {
        switch petType {
        case "Dog":
            dogInstance.play()
            updateDogView()
        case "Cat":
            catInstance.play()
            updateCatView()
        case "Bird":
            birdInstance.play()
            updateBirdView()
        case "Bunny":
            bunnyInstance.play()
            updateBunnyView()
        case "Fish":
            fishInstance.play()
            updateFishView()
        case "Custom":
            customInstance.play()
            updateCustomView()
        default:
            dogInstance.play()
            updateDogView()
        }
    }
    
    @IBAction func feedPet(_ sender: Any) {
        switch petType {
        case "Dog":
            dogInstance.feed()
            updateDogView()
        case "Cat":
            catInstance.feed()
            updateCatView()
        case "Bird":
            birdInstance.feed()
            updateBirdView()
        case "Bunny":
            bunnyInstance.feed()
            updateBunnyView()
        case "Fish":
            fishInstance.feed()
            updateFishView()
        case "Custom":
            customInstance.feed()
            updateCustomView()
        default:
            dogInstance.feed()
            updateDogView()
        }
    }
    
    @IBAction func trainPet(_ sender: Any) {
        switch petType {
        case "Dog":
            dogInstance.training()
            updateDogView()
        case "Cat":
            catInstance.training()
            updateCatView()
        case "Bird":
            birdInstance.training()
            updateBirdView()
        case "Bunny":
            bunnyInstance.training()
            updateBunnyView()
        case "Fish":
            fishInstance.training()
            updateFishView()
        case "Custom":
            customInstance.training()
            updateCustomView()
        default:
            dogInstance.training()
            updateDogView()
        }
    }
    
    @IBAction func dogSelected(_ sender: Any) {
        petType = "Dog"
        load.isEnabled = false
        backView.wantsLayer = true
        backView.layer?.backgroundColor = NSColor.cyan.cgColor
        //play the dog sound effect when dog is selected
        let url = Bundle.main.url(forResource: "Dogsound", withExtension: "wav")!
        do{
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: nil)}
        catch let error as NSError { print(error.description) }
        player.numberOfLoops = 0
        player.prepareToPlay()
        player.play()
        petImage.image = #imageLiteral(resourceName: "dog-1")
        foodView.color = CGColor(red: 64/255, green: 224/255, blue: 205/255, alpha:1)
        happyView.color = CGColor(red: 0/255, green: 199/255, blue: 140/255, alpha:1)
        updateDogView()
    }
    @IBAction func catSelected(_ sender: Any) {
        petType = "Cat"
        load.isEnabled = false
        backView.wantsLayer = true
        //play the cat sound effect when cat is selected
        let url = Bundle.main.url(forResource: "Catsound", withExtension: "wav")!
        do{
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: nil)}
        catch let error as NSError { print(error.description) }
        player.numberOfLoops = 0
        player.prepareToPlay()
        player.play()
        backView.layer?.backgroundColor = CGColor(red: 0/255, green: 100/255, blue: 220/255, alpha:0.8)
        petImage.image = #imageLiteral(resourceName: "cat-1")
        foodView.color = CGColor(red: 25/255, green: 25/255, blue: 112/255, alpha:1)
        happyView.color = CGColor(red: 3/255, green: 168/255, blue: 200/255, alpha:1)
        updateCatView()
    }
    @IBAction func birdSelected(_ sender: Any) {
        petType = "Bird"
        backView.wantsLayer = true
        backView.layer?.backgroundColor = CGColor(red: 222/255, green: 145/255, blue: 33/255, alpha:1)
        load.isEnabled = false
        //play the bird sound effect when bird is selected
        let url = Bundle.main.url(forResource: "Birdsound", withExtension: "wav")!
        do{
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: nil)}
        catch let error as NSError { print(error.description) }
        player.numberOfLoops = 0
        player.prepareToPlay()
        player.play()
        petImage.image = #imageLiteral(resourceName: "bird-1")
        foodView.color = CGColor(red: 123/255, green: 144/255, blue: 100/255, alpha:1)
        happyView.color = CGColor(red: 237/255, green: 145/255, blue: 33/255, alpha:1)
        updateBirdView()
    }
    @IBAction func bunnySelected(_ sender: Any) {
        petType = "Bunny"
        backView.wantsLayer = true
        backView.layer?.backgroundColor = CGColor(red: 122/255, green: 122/255, blue: 122/255, alpha:1)
        load.isEnabled = false
        //play the bunny sound effect when bunny is selected
        let url = Bundle.main.url(forResource: "Bunnysound", withExtension: "wav")!
        do{
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: nil)}
        catch let error as NSError { print(error.description) }
        player.numberOfLoops = 0
        player.prepareToPlay()
        player.play()
        petImage.image = #imageLiteral(resourceName: "bunny-1")
        happyView.color = CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha:1)
        foodView.color = CGColor(red: 192/255, green: 192/255, blue: 192/255, alpha:1)
        updateBunnyView()
    }

    @IBAction func fishSelected(_ sender: Any) {
        petType = "Fish"
        backView.wantsLayer = true
        backView.layer?.backgroundColor = CGColor(red: 34/255, green: 139/255, blue: 34/255, alpha:1)
        load.isEnabled = false
        //play the fish sound effect when fish is selected
        let url = Bundle.main.url(forResource: "Fishsound", withExtension: "wav")!
        do{
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: nil)}
        catch let error as NSError { print(error.description) }
        player.numberOfLoops = 0
        player.prepareToPlay()
        player.play()
        petImage.image = #imageLiteral(resourceName: "fish-1")
        foodView.color = CGColor(red: 34/255, green: 139/255, blue: 34/255, alpha:1)
        happyView.color = CGColor(red: 107/255, green: 142/255, blue: 35/255, alpha:1)
        updateFishView()
    }
    
    //select the custom pet
    @IBAction func customSelected(_ sender: Any) {
        petType = "Custom"
        backView.wantsLayer = true
        backView.layer?.backgroundColor = CGColor(red: 255/255, green: 10/255, blue: 20/255, alpha:0.7)
        load.isEnabled = true
        if customImage.isEmpty == true {
            let select = NSOpenPanel()
            select.allowedFileTypes = ["png", "jpeg", "jpg"]
            select.canChooseFiles = true
            select.allowsMultipleSelection = false
            select.canChooseDirectories = false
            select.runModal()
            let selectFile = select.url
            if selectFile != nil {
                customImage = [NSImage(contentsOf: selectFile!)!]
                petImage.image = customImage[0]
            }
        }else{
            petImage.image = customImage[0]
        }
        //play the custom sound effect when custom is selected
        let url = Bundle.main.url(forResource: "hello", withExtension: "wav")!
        do{
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: nil)}
        catch let error as NSError { print(error.description) }
        player.numberOfLoops = 0
        player.prepareToPlay()
        player.play()

        foodView.color = CGColor(red: 255/255, green: 20/255, blue: 34/255, alpha:1)
        happyView.color = CGColor(red: 200/255, green: 10/255, blue: 15/255, alpha:0.8)
        updateCustomView()
    }
    //allow to change the pet icon when they select the custom pet
    @IBAction func loadImage(_ sender: Any) {
        let select = NSOpenPanel()
        select.allowedFileTypes = ["png", "jpeg", "jpg"]
        select.canChooseFiles = true
        select.allowsMultipleSelection = false
        select.canChooseDirectories = false
        select.runModal()
        let selectFile = select.url
        if selectFile != nil {
            customImage = [NSImage(contentsOf: selectFile!)!]
            petImage.image = customImage[0]
        }
    }
    
    
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

