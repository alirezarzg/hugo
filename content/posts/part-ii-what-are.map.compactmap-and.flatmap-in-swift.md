+++
ShowBreadCrumbs = false
ShowPostNavLinks = false
ShowReadingTime = false
TocOpen = true
aliases = []
author = ["Alireza Rezagholian"]
canonicalURL = ""
categories = ["Swifty Collection"]
comments = true
date = 2021-11-12T20:30:00Z
description = "Let's dig in our very first and also one of the most useful Higher Order functions in Swift's collections !"
disableHLJS = false
disableShare = false
hideSummary = true
hidemeta = true
searchHidden = false
series = []
showToc = true
slug = "part-ii-map-compactmap-flatmap"
summary = ""
tags = ["higher-order-functions", "swifty-collection"]
title = "Part (II) : What are .map , .compactMap and .flatMap in Swift"
weight = nil
[cover]
alt = ""
caption = ""
hidden = false
image = ""
relative = false
[editPost]
Text = ""
URL = ""
appendFilePath = false

+++
It's simple ! Let's start with :

# .map :

The whole idea is about mapping collection elements , do something on them and then return the same-sized array of them !

So, here we are **creating** a new array from the other array . It is done with an O(n) complexity since it iterates through the whole array . 

> What is O(n)? it's just a simple measure helping us represent the algorithms complexity. Soon I'll publish an article on **What is O(n) ? Swifty way and examples** to help you understand it better .

Well let's see an example on .map in Arrays to help you understand it better :)

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
    
    //3. What if there weren't any .map in Swift? Oh... S*#!
    
    var newArray_OldFashioned: [Int] = []
    
    for element in array {
    
        newArray_OldFashioned.append(element * element)
    
    }
    
    print(newArray_OldFashioned) // Result? The same as above! What did you expect?!

O...K, but what about return? To make it easier than what you can find at [swift.org](https://docs.swift.org/swift-book/LanguageGuide/Closures.html):

> While having only one line of code inside the closure , our smart complier understands that it's what we wanted to return! **element * element** is the same as **return element * element** for the compiler in this case .

Gotcha! Wondering WTH is $0 ?! As it is explained at [swift.org](https://docs.swift.org/swift-book/LanguageGuide/Closures.html):

> ... $0 and $1 refer to the closure’s first and second arguments... . You'll see $1 in future examples but for now , it's enough to know that $0 simply is the first (in our case the _only_) argument that .map closure offers ;) 

Let's meet .map's brothers - or maybe sisters :) **.compactMap** and **.flatMap** !

# .compactMap :

Well , as I've already mentioned in the first part of this series , Swift's collection types are implemented as _generic types_ . The same thing goes for also the collections' in-built functions :) It means that there isn't any restrictions on using .map with Array<String> or Array<Double> just like Array<Int> !

The interesting thing here is that they also work with Optional Types ! What would happen if the .map(ped) array result in some *nil* values ? Here's where our new Savior shows up :) _Ladies & Gentlemen let me introduce you the **.compactMap** !_

    import Foundation
    var array = ["2", "3", "Four", "Roronoa Zoro"]
    
    let newArray_ModernStyle = array.map { (element) -> Int? in
    
        Int(element)
    
    }
    
    print(newArray_ModernStyle)

Can you guess the result? It's an Optional array of Ints :) Why Optional? because the Downcast of String to Int might fail - Just like what's happening here . So to make the above example more readable :

    ...
    
    let newArray_ModernStyle: [Int?] = array.map { (element) -> Int? in //element is a String
    
        Int(element)
    
    }
    
    print(newArray_ModernStyle) // Result -> [Optional(2), Optional(3), nil, nil]

Wait , wait ... What just happened ?! Do you remember what I said about .map ? _... do something on each element and then return the same-sized array of them ..._ - Yep! .map should return the **same-sized array** as the inputed array . In our case some of the Downcasts fail and as we expecting the same-sized array from .map to be _throw_n , it fills the array with nil as for failed Downcasts .

I guess that you've already guessed ... Here is where .compactMap enters! 

To make what [developer.apple.com](https://developer.apple.com/documentation/swift/sequence/2950916-compactmap) says about it :

> .compactMap is almost the same as .map with one difference ; .compactMap discards all of **nil** results so the newArray contains only valid transformed elements. And here we don't expect the same-sized array to be returned . **.compactMap returns an array containing the non-nil results of calling the given transformation with each element of this sequence** !

    import Foundation
    
    var array: [String] = ["2", "3", "Four", "Roronoa Zoro"]
    
    let newArray_ModernStyle = array.compactMap { (element) -> Int? in
    
        Int(element)
    
    }
    
    print(newArray_ModernStyle) // Result -> [2, 3]
    
    let newArray_SwiftyWay = array.compactMap { Int($0) }
    
    print(newArray_SwiftyWay) // Result -> [2, 3]

> What exactly is Optional behind the scenes ? It's built using **Enum** with two cases of some value and .none . I'd soon publish an article on **What is Optional in Swift ? Behind the scenes** to cover the whole thing !

Here is the magic of .compactMap ! As it returns _an array containing the non-nil results..._ it discards the nil and (if needed) unnecessary results just like Optional parts of Int? . To be more clear , it converts the Optional value since it knows that the result can't be nil ,so using Optionals is absolutely useless . But if you declare newArray as type \[Int?\] in the above example it would produce an array of Optional Ints while holding nils _-just like big bro, .map_ .

> It's good to know that the complexity of ,compactMap as [developer.apple.com](https://developer.apple.com/documentation/swift/sequence/2950916-compactmap) says is O(m +n) . Thats because it iterates through the whole array of **n** times and produces an array of **m** items .

_By the way, who was that **Roronoa Zoro** guy in our array ? He is a legend, the greatest swordsman in the whole New World, Vice Captain of Straw Hat Pirates =))))) I deeply suggest you to go and watch_ [**_One Piece_**](https://www.imdb.com/title/tt0388629/?ref_=ext_shr_lnk) _.In the Anime, there is only one thing wrong about Roronoa , and that's he always loses his way and his sense of direction is absolutely awful . This time as he got lost it seems that he were here with us ;)_

Let's learn about the last .map's brother -or maybe sister- and wrap this up -so we can go and enjoy the Holy [**One Piece**](https://www.imdb.com/title/tt0388629/?ref_=ext_shr_lnk) :) 

# .flatMap :

It's simple . As of introducing .compactMap beside Swift 4.1 it got even simpler than before .

Nowadays the only thing .flatMap does is to :

> "Returns an array containing the concatenated results of calling the given transformation with each element of this sequence."
>
> \-[_developer.apple.com_](https://developer.apple.com/documentation/swift/sequence/2905332-flatmap)

To make it readable by humans , 

> "in Swift 4.1+ .flatMap is used only to help you flattening a nested collection into a single array." 
>
> \-_Alireza_

Well, a _nested collection_ is like an array having another array as its elements . Like an array of arrays !

    import Foundation
    
    var array: Array<[Int]> = [[1], [2, 3, 4, 5], [6, 7]]
    
    let newArray_ModernStyle = array.flatMap { (element) -> [Int] in
    
        element
    
    }
    
    print(newArray_ModernStyle)
    
    let newArray_SwiftyWay: [Int] = array.flatMap { $0 }
    
    print(newArray_SwiftyWay) 

Wondering about the result? It'd be ->  \[1, 2, 3, 4, 5, 6, 7\] . The whole array in flattened by .flatMap to make our newArray . 

> There are two things here that could be nice to point out . The .flatMap's closure always returns **Sequence** and it's also good to know that Arrays , Sets , Dictionaries and lots of collection types conform to **Sequence Protocol** .

As [developer.apple.com](https://developer.apple.com/documentation/swift/sequence) mentions , **Sequence** is a type that provides sequential, iterated access to its elements. Simply it's a list of values that you can step through one at a time . Consider iterating over a Sequence has complexity of O(n) .

Before putting an end to this topic , just like .compactMap , .flatMap has complexity of O(m + n) ! The reason is simple , isn't it? :)

Next: Part (III) : What is .filter in Swift ?

***

_Thanks a lot for coming this far and reading the article :) As you may know it's a series about **Higher Order Functions of Swift's Collection , so make sure to read next articles as well as previous one -if you hadn't already- to completely master this subject . Stay Safe , Code Well & Watch One Piece** =)_ 

> If you have any questions, suggestions or etc. feel free to contact me at [_alireza@swiftycode.com_](mailto:alireza@swiftycode.com) . We can also chat about One Piece beside Swift -kidding- on Twitter at [_@swiftycode_com_](https://twitter.com/swiftycode_com) .