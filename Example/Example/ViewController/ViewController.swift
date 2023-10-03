//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2023/04/19.
//  ~/Library/Caches/org.swift.swiftpm/
//  file:///Users/william/Desktop/WWKeychain

import UIKit
import WWMetronome

final class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    private var metronome: WWMetronome?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
    }
    
    @IBAction func startAction(_ sender: UIBarButtonItem) { start() }
    @IBAction func stopAction(_ sender: UIBarButtonItem) { stop() }
}

// MARK: - 小工具
private extension ViewController {
    
    func initSetting() {
        metronome = WWMetronome.build()
    }
    
    func start() {
        
        metronome?.start(withBPM: 120) { [weak self] info in
            
            guard let this = self else { return }
            DispatchQueue.main.async { this.myLabel.text = info.beat.message() }
        }
    }
    
    func stop() {
        metronome?.stop()
    }
}
