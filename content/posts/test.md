---
title: "Part (V) : Farewell , Swifty Collections!"
date: 2021-07-15T13:10:41+05:30
slug: "vim-vs-neovim"
category: "Development Environments"
summary:
  A brief summary on swift collections' functions such as reduce, filter, map and etc.
description:
  desc :A brief summary on swift collections' functions such as reduce, filter, map and etc.
cover:
  image: https://res.cloudinary.com/jarmos/image/upload/v1628425482/vim-vs-neovim_kn8cm9.gif
  alt: Vim vs Neovim; Which one to use?
  caption: Vim vs Neovim; Which one to use?
  relative: false
showtoc: true
draft: false
---

So, it seems that it's the end of the way for Swifty Collections! We learned that there are some functions called Higher Order Functions and their difference with normal ones is that they deal with other functions, either as a *parameter* or as a *return type*.

Also we learned that *Swift provides three primary collection types (arrays, sets, and dictionaries) for storing collections of values.*

Then there were our lovely trio: * **.map**, **.filter**, **.reduce** * .

Here we have a summary of what they are and a simple , *Swifty* example of them!

# [.map, .compactMap, .flatMap](https://swiftycode.com/part-ii-map-compactmap-flatmap) :

### .map :
>The whole idea is about mapping collection elements , do something on them and then return the same-sized array of them ! Complexity? O(n)

```
import Foundation

var array = [2, 3, 4, 5]

// 1. Just pass a closure as parameter in .map function and that's that !
let newArray_ModernStyle = array.map { (element) -> Int in
    element * element
}
print(newArray_ModernStyle)  // Result -> [4, 9, 16, 25]

//2. It's what swift offers to help us live better :) $0 acts as (element) in _ModernStyle's map closure.
let newArray_SwiftyWay = array.map { $0 * $0 }
print(newArray_SwiftyWay) // Result -> [4, 9, 16, 25]
``` 

### .compactMap :
>.compactMap is almost the same as .map with one difference ; .compactMap discards all of nil results so the newArray contains only valid transformed elements. And here we don't expect the same-sized array to be returned . .compactMap returns an array containing the non-nil results of calling the given transformation with each element of this sequence ! Complexity? O(m +n) [m is the length of the result] 

```
import Foundation

var array: [String] = ["2", "3", "Four", "Roronoa Zoro"]

let newArray_ModernStyle = array.compactMap { (element) -> Int? in
    Int(element)
}
print(newArray_ModernStyle) // Result -> [2, 3]

let newArray_SwiftyWay = array.compactMap { Int($0) }
print(newArray_SwiftyWay) // Result -> [2, 3]
```

*Wait wait ... Who was **Roronoa Zoro**?* You mean you hadn't read the full article? 

*Psst ... check out [switycode.com/.map](https://swiftycode.com/part-ii-map-compactmap-flatmap) :) *

### .flatMap :
>In Swift 4.1+ .flatMap is used only to help you flattening a nested collection into a single array. Complexity? Complexity? O(m +n) [m is the length of the result]

```
import Foundation

var array: Array<[Int]> = [[1], [2, 3, 4, 5], [6, 7]]

let newArray_ModernStyle = array.flatMap { (element) -> [Int] in
    element
}
print(newArray_ModernStyle)

let newArray_SwiftyWay: [Int] = array.flatMap { $0 }
print(newArray_SwiftyWay)
```

>**✨ As I've mentioned above, you can read the full, detailed article at [switycode.com/.map](https://swiftycode.com/part-ii-map-compactmap-flatmap) **


# [.filter](https://swiftycode.com/part-iii-filter) :
>.filter returns a new array , with elements which are ok with the predicate (~given logic) declared by the closure; Keep in mind that returned array has the same order as the given array. Complexity? O(n)

```
import Foundation

var array = [10, 7, 1, 4, 0, -2, 20]

let newArray = array.filter { (element) -> Bool in
    element < 5
}
print(newArray)

let newArraySwifty = array.filter( { $0 < 5 })
print(newArray)

// Result -> [1, 4, 0, -2]
```

> **☄️ As you might've noticed we could use .comapctMap instead of .filter! So why .filter? The answer is in the full article at [switycode.com/.filter](https://swiftycode.com/part-iii-filter) **


# [.reduce](https://swiftycode.com/part-iv-reduce) :

**Although it's unbelievably useful but it is a bit tricky! So I deeply suggest you read the detailed article of this awesome Instance Method at [switycode.com/.filter](https://swiftycode.com/part-iv-reduce)! **

*There is also a semi-real world example on .map and .reduce + a bit of structs there -**with Naruto 🦊 , Dattebayo!** *

### .reduce -classic 😂 :

> Whenever you felt like combining a collection, you can depend on .reduce! It only needs the collection you wanna combine , a baseValue to start combining with and the way you'd like it to combine -passed by a closure. Complexity? O(n)

```
import Foundation

var array = [1, 2, 3, 4, 5]

let combinedValue = array.reduce(0) { (previousResult, currentElement) -> Int in
    previousResult + currentElement
}
print(combinedValue) // -> 15

let swiftyCombinedValue = array.reduce(0) { $0 + $1 }
print(swiftyCombinedValue) // -> 15

let swiftyCombinedValue_UltimateEdition = array.reduce(0, +)
print(swiftyCombinedValue_UltimateEdition) // -> also 15! What'd you expect?!
```
If there is anything you feel uncomfortable with, let me know via *[alireza@swiftycode.com](mailto:alireza@swiftycode.com)* or Twitter: *[@swiftycode_com](https://twitter.com/swiftycode_com)* . I'd try my best to explain it the way you'd understand ;)

### .reduce(into:) -the overloaded bro 🤣 :
> By using .reduce(into:) we reduce -or combine- the sequence using the given closure into the initialResult while in .reduce we did create a new value from combined -reduced- elements! Complexity? O(n)

```
import Foundation

let array = [1, 2, 4, 5]

let reduceInto = array.reduce(into: 0) { (previousResult, currentElement) in
    previousResult += currentElement
}
print(reduceInto) // -> 12
```

O.....K! As I've mentioned before the next series is **Swifty Types: What are named types?** . There we'll dive deep in named types to learn about Class, Struct, Enum, Protocol, and etc. in our beloved Swift ! See you soon :)

There will also be a single article , **Swifty String: What are Strings behind the scene?** and there, we'll find another Higher Order Function called *.split* and lots of interesting things about Strings in Swift!

*Farewell, Swifty Collections -for now ... 🙌🏼*


***
*Thanks a lot for coming this far and reading the article :) As you may know it was a summary on a series about [**Higher Order Functions of Swift's Collection**](https://swiftycode.com/part-i-higher-order-functions-in-swift-collections) , so make sure to read previous articles -if you hadn't already- to completely master this subject -**Dattebayo!** . **Stay Safe** , **Code Well** & **Watch Naruto** =) *
> If you have any questions, suggestions or etc. feel free to contact me at *[alireza@swiftycode.com](mailto:alireza@swiftycode.com)* . We can also chat about One Piece ,Macbeth & Naruto beside Swift -kidding- on Twitter at *[@swiftycode_com](https://twitter.com/swiftycode_com)* .