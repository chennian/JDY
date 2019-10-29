//
//  String+Extension.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/23.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import Foundation

extension String{
    
    // MARK: 汉字 -> 拼音
      func chineseToPinyin() -> String {
          
          let stringRef = NSMutableString(string: self) as CFMutableString
          // 转换为带音标的拼音
          CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false)
          // 去掉音标
          CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false)
          let pinyin = stringRef as String
          
          return pinyin
      }
      
      // MARK: 判断是否含有中文
      func isIncludeChineseIn() -> Bool {
          
          for (_, value) in self.enumerated() {
              
              if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                  return true
              }
          }
          
          return false
      }
      
      // MARK: 获取第一个字符
      func first() -> String {
          let index = self.index(self.startIndex, offsetBy: 1)
          return self.substring(to: index)
      }
    
    public func formateForBankCard(joined: String = "   ") -> String {
        guard self.count > 0 else {
            return self
        }
        let length: Int = self.count
        let count: Int = length / 4
        var data: [String] = []
        for i in 0..<count {
            let start = self.index(self.startIndex, offsetBy: 4 * i)
            let end  = self.index(self.startIndex, offsetBy: 4 * (i + 1))
            data.append(String(self[start..<end]))
            
        }
        if length % 4 > 0 {
            let start = self.index(self.startIndex, offsetBy: 4 * count)
            let end  = self.index(self.startIndex, offsetBy: length)

            data.append(String(self[start..<end]))
        }
        let result = data.joined(separator: joined)
        return result
    }
    
}
