//
//  ViewController.swift
//  Calculator
//
//  Created by bakebrlk on 25.09.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var height: Int = 0
    let numbers = [["0", ","],["1","2","3"],["4","5","6"],["7","8","9"]]
    let operations = ["=","+", "-", "×","÷"]
    let functions = ["AC","+/-","%"]
    
    var preview = UIView()
    var between: Int = 0
    
    var firstNum: Float? = nil
    var secondNum: Float? = nil
    
    var numberLine: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    private func setUI(){
        view.backgroundColor = .black
        height = Int(Float(view.frame.size.height))
        between = height/53
        
        setOperation()
        setFunctions()
        setNumbers()
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(height/3)
            make.trailing.equalToSuperview().offset(between * (-1))

        }
    }
    
    
    private var label: UILabel = {
        var label = UILabel()
        label.text = "0"
        label.textColor  = .white
        label.font = .systemFont(ofSize: 94)
        return label
    }()
    
    private func setNumbers(){
        
        for i in numbers.reversed(){
            for j in 0..<i.count{
                let v = nums(i[j], color: .darkGray)
                
                view.addSubview(v)
                if(j == 0){
                    
                    if(i[j] == "0"){
                        v.snp.makeConstraints { make in
                            make.top.equalTo(preview.snp.bottom).offset(between*(-1) + 2*between)
                            make.leading.equalToSuperview().offset(between + between/2)
                            make.trailing.equalTo(preview.snp.leading).offset(between*(-1))
                        }
                    }else{
                        v.snp.makeConstraints { make in
                            make.top.equalTo(preview.snp.bottom).offset(between*(-1) + 2*between)
                            make.leading.equalToSuperview().offset(between + between/2)
                        }
                    }
                }else{
                    v.snp.makeConstraints { make in
                        make.leading.equalTo(preview.snp.trailing).offset(between)
                        make.top.equalTo(preview.snp.top)
                    }
                }
                
                preview = v
            }
            
        }
    }
    
    private func setFunctions(){
        
        for i in (0..<functions.count).reversed(){
            let v = nums(functions[i], color: .gray)
            
            view.addSubview(v)
            
            if(i == 0){
                v.snp.makeConstraints { make in
                    make.leading.equalTo(preview.snp.leading).offset((between)*(-1) - height/11)
                    make.top.equalTo(preview.snp.top)
                }
            }else{
                v.snp.makeConstraints { make in
                    make.trailing.equalTo(preview.snp.leading).offset((between) * (-1))
                    make.top.equalTo(preview.snp.top)
                }
            }
            preview = v
        }
    }
    
    private func setOperation(){
        
        for i in 0..<operations.count{
            let v = nums(operations[i], color: .orange)
            
            view.addSubview(v)
            
            if(i == 0){
                
                v.snp.makeConstraints { make in
                    make.trailing.equalToSuperview().offset(between * (-1))
                    make.bottom.equalToSuperview().offset((height/15)*(-1))
                }
            }else{
                v.snp.makeConstraints { make in
                    make.bottom.equalTo(preview.snp.top).offset(between * (-1))
                    make.trailing.equalToSuperview().offset(between * (-1))
                }
            }
            preview = v
        }
    }
    
    
    private func nums(_ num: String, color: UIColor) -> UIButton{
        let view = UIButton()
        view.backgroundColor = color
        
        view.snp.makeConstraints { make in
            make.width.height.equalTo(height/11)
        }
        
        view.layer.cornerRadius = CGFloat(height/22)
            
        view.setTitle(num, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 28)
        

        
        view.addTarget(self, action: #selector(tapBtn(_:)), for: .touchUpInside)
        return view
    }
    
    var oper = ""
    
    @objc func tapBtn(_ v: UIButton){
        let data: String = v.titleLabel?.text ?? ""
        
        if(operations.contains(data)){
            
            if(oper.isEmpty){
                oper = data
            }
                if(!numberLine.isEmpty){
                    
                    if(firstNum == nil){
                        firstNum = Float(numberLine)
                    }else if(secondNum == nil){
                        secondNum = Float(numberLine)
                    }
                    numberLine = ""
                }
            
            if(firstNum != nil && secondNum != nil){
                print("oper")
                
                if(data == "+" || oper == "+"){
                    
                        firstNum! += secondNum ?? 0
                        secondNum = nil
                        oper = ""
                
                }else if(data == "-" || oper == "-"){
                   
                        firstNum! -= secondNum ?? 0
                        secondNum = nil
                        oper = ""
                    
                }else if(data == "×" || oper == "×"){
                    
                        firstNum! *= secondNum ?? 0
                        secondNum = nil
                        oper = ""
                    
                }else if(data == "÷" || oper == "÷"){
                    
                        firstNum! /= secondNum ?? 0
                        secondNum = nil
                        oper = ""
                }
                let kk = String(describing: firstNum)
                label.text = kk[9..<kk.count-1]
            }
            
        }else if(functions.contains(data)){
            print("func")
        }else if(!data.isEmpty){
            numberLine.append(data)
            label.text = numberLine
        }
    }
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}
