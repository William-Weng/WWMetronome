//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2021/12/21.
//  ~/Library/Caches/org.swift.swiftpm/
//  file:///Users/william/Desktop/WWCountdownButton

import UIKit

// MARK: 節拍計數器
open class WWMetronome {
    
    public typealias MetronomeInformation = (count: UInt, beat: BeatType)   // (計數, 拍子)
    
    /// 調性類型
    public enum RhythmType {
        
        case beat1_4
        case beat2_4
        case beat3_4
        case beat4_4
        
        /// 說明
        /// - Returns: String
        func message() -> String {
            
            switch self {
            case .beat1_4: return "1/4拍"
            case .beat2_4: return "2/4拍"
            case .beat3_4: return "3/4拍"
            case .beat4_4: return "4/4拍"
            }
        }
        
        /// 一小節有幾拍
        /// - Returns: UInt
        func value() -> UInt {
         
            switch self {
            case .beat1_4: return 1
            case .beat2_4: return 2
            case .beat3_4: return 3
            case .beat4_4: return 4
            }
        }
    }
    
    /// 節拍聲
    public enum BeatType {
        
        case di
        case da
        
        /// 節拍聲 (中文)
        /// - Returns: String
        func message() -> String {
            
            switch self {
            case .di: return "滴"
            case .da: return "答"
            }
        }
    }
    
    private var count: UInt = 0
    private var rhythm: RhythmType = .beat4_4
    private var timer: Timer?
    private var result: ((MetronomeInformation) -> Void)?
    
    private init() {}
    
    /// 啟動節拍器後的回傳值
    /// - Parameter sender: Timer
    @objc func countAction(_ sender: Timer) {
        
        count += 1
        
        var info: MetronomeInformation = (count: count, beat: .da)
        if (count % rhythm.value() != 0) { info.beat = .di }
        
        result?(info)
    }
}

// MARK: - 公開工具
public extension WWMetronome {
    
    /// 產生WWMetronome物件
    /// - Returns: WWMetronome
    static func build() -> WWMetronome { return WWMetronome() }
}

// MARK: - 公開工具
public extension WWMetronome {
    
    /// 啟動節拍器 (計數)
    /// - Parameters:
    ///   - bpm: [音樂速度單位 - 120bpm](https://zh.wikipedia.org/zh-tw/速度_(音樂))
    ///   - rhythm: [音樂節拍 - 4/4拍](https://zh.wikipedia.org/zh-tw/节拍)
    ///   - mode: [RunLoop模式](https://medium.com/@chengyang1380/簡單聊聊-ios-run-loop-a9204314b773)
    ///   - result: ((MetronomeInformation) -> Void)?
    func start(withBPM bpm: Int, rhythm: RhythmType = .beat4_4, mode: RunLoop.Mode = .common, result: ((MetronomeInformation) -> Void)? = nil) {
        
        let fps = 60.0 / TimeInterval(bpm)
        let timer = Timer.scheduledTimer(timeInterval: fps, target: self, selector: #selector(countAction), userInfo: nil, repeats: true)
        
        self.result = result
        self.timer = timer
        self.rhythm = rhythm
        
        timer.fire()
        RunLoop.main.add(timer, forMode: mode)
    }
    
    /// 停止節拍器 (歸零)
    func stop() {
        count = 0
        timer?.invalidate()
        timer = nil
    }
}

