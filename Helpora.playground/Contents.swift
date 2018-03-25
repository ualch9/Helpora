//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Helpora

var index = HPAIndex(identifier: "fdsa", name: "App Name", locale: Locale(identifier: "en_US"))
index.addSection(identifier: "com.section", name: "yup")

var pageOne = HPAPage(name: "First Page Title")
pageOne.contents = """
# Intro Page
![Image](http://via.placeholder.com/350x150)
Hello there! I am an introduction page!

## This is a subsection
- I'm list item one!
- List item two
- List item 3

--

## Steps to fix:
1. I'm item one of an ordered list!
2. Item two
3. Item 3
4. ...
5. Profit

# H1
## H2
### H3
#### H4
"""

index.sections[0].pages.append(pageOne)

var introPage = HPAPage(name: "intro_page")
introPage.contents = """
# Welcome to App Name Knowledge Base

![Image](https://via.placeholder.com/128x128)

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam placerat a enim non mollis. Mauris vitae dui est. Cras eu tristique dui, sit amet condimentum dui. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aenean tempus posuere nulla, sed tincidunt odio iaculis ut. Nulla facilisi. Pellentesque habitant morbi tristique senectus et netus

et malesuada fames ac turpis egestas.
"""
index.introductionPage = introPage

PlaygroundPage.current.liveView = HPAHelporaView(withIndex: index)

let encoder = JSONEncoder()
let data = try! encoder.encode(index)
print(String(data: data, encoding: .utf8)!)

//let decoder = JSONDecoder()
//let style = try! decoder.decode(HPAStyle.self, from: data)
//
//print(style.styles)


//print(HPAStyle.defaultStyle.stylesheet)
//
//UIFont.boldSystemFont(ofSize: 50.0).fontDescriptor.fontAttributes
//UIFont.preferredFont(forTextStyle: .body).fontName.dropFirst()

