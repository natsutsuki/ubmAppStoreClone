/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import UIKit

enum BackgroundType: String {
  case light
  case dark
  
  var titleTextColor: UIColor {
    switch self {
    case .dark:
      return .lightTitleTextColor
    case .light:
      return .darkTitleTextColor
    }
  }
  
  var subtitleTextColor: UIColor {
    switch self {
    case .dark:
      return .lightSubtitleTextColor
    case .light:
      return .darkSubtitleTextColor
    }
  }
}

extension UIColor {
  static let backgroundColor = UIColor(red:0.99, green:0.99, blue:0.99, alpha:1.00)
  static let buttonBackgroundColor = UIColor(red:0.94, green:0.95, blue:0.96, alpha:1.00)
  static let borderColor: UIColor =  UIColor(red:0.35, green:0.35, blue:0.35, alpha:0.3)
  static let heroTextColor: UIColor = .white
  static let lightSubtitleTextColor: UIColor = UIColor.white.withAlphaComponent(0.8)
  static let lightTitleTextColor: UIColor = .white
  static let darkSubtitleTextColor: UIColor = .gray
  static let darkTitleTextColor: UIColor = .black
}
