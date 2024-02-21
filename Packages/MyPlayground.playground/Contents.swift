import UIKit

var greeting = "Hello, playground"

let text = "# This is a header"

let regex = try? NSRegularExpression(pattern: #"^(?!>|\t*\d+\.\s|\t*-\s|#+\s)([^\>].*)"#)
let range = NSRange(text.startIndex..., in: text)

let match = regex?.firstMatch(in: text, range: range)
match?.range(at: 1)
