//
//  ViewController.swift
//  DrawingApp
//
//  Created by Yauheni Bunas on 6/3/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var canvasView: CanvasView!
    
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var opacitySlider: UISlider!
    
    var colors: [UIColor] = [UIColor.red, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.black]
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        widthSlider.maximumValue = 20
        widthSlider.minimumValue = 0.05
        widthSlider.value = 1
        
        opacitySlider.maximumValue = 1
        opacitySlider.value = 1
    }

    @IBAction func onClickSave(_ sender: Any) {
        let image = canvasView.takeScreenShoot()
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextType:)), nil)
        
    }
    
    
    @IBAction func onClickUndo(_ sender: Any) {
        canvasView.undoDraw()
    }
    
    @IBAction func onClickClear(_ sender: Any) {
        canvasView.clearCanvasView()
    }
    
    @IBAction func onClickBrushSize(_ sender: UISlider) {
        canvasView.strokeWidth = CGFloat(sender.value)
    }
     
    @IBAction func onClickOpacity(_ sender: UISlider) {
        canvasView.strokeOpacity = CGFloat(sender.value)
    }
    
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextType: UnsafeRawPointer) {
        if error != nil {
            print("Unable to save image to Photo Album")
        } else {
            print("Image saved")
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let view = cell.viewWithTag(111) {
            view.backgroundColor = colors[indexPath.row]
            view.layer.cornerRadius = 3
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        canvasView.strokeColor = colors[indexPath.row]
    }
}
