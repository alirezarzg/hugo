---
title: 'Part (III) : What is .filter in Swift ?'
date: 2021-11-13T08:40:41+00:00
slug: part-iii-filter
tags:
- swifty-collections
- higher-order-functions
categories:
- Swifty Collections
series:
- Swifty Collections
aliases: []
summary: Let's learn what is .filter in Swift's collections and much more about such Higher Order Functions ...
description: A brief summary on swift collections' functions such as reduce, filter,
  map and etc.
author:
- Alireza Rezagholian
showToc: true
TocOpen: true
hidemeta: false
canonicalURL: ''
disableHLJS: false
disableShare: false
hideSummary: false
searchHidden: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
comments: true
editPost:
  URL: ''
  Text: ''
  appendFilePath: false

---
It's simple! as you already know , .filter is a Higher Order Function for collections in Swift. Just like .map, .filter is also referred as **Instance Method** . 

Why do we need **.filter**?

# .filter :

Well, well ... as [developer.apple.com](https://developer.apple.com/documentation/swift/sequence/3018365-filter) says, .filter's job is to :
>Return an array containing, in order, the elements of the sequence that satisfy the given predicate.

I know that it's somehow hard to understand to make it a little bit readable , we can say that :
> .filter returns a new array , with elements which are ok with the predicate (~given logic) declared by the closure; Keep in mind that returned array has the same order as the given array.

Behind the scenes , .filter is doing a simple job; It iterates through the whole given array , checks if the given predicate -*passed as a closure*- applies to the element , returns a **Bool** indicating the *true/false* state of the operation for the element; if it the result were *true* the element would be added to the array we're expecting in return .

The only thing we need to know for our daily use is that we can filter an array with .filter by any logic we need and get a new array filtered as we desire !

Here is the example for .filter :
```
import Foundation

var array = [10, 7, 1, 4, 0, -2, 20]

let newArray = array.filter { (element) -> Bool in
    element < 5
}
print(newArray)

let newArraySwifty = array.filter( { $0 < 5 })
print(newArraySwifty)
``` 
**Can you guess the result ? -> [1, 4, 0, -2]**

The passed predicate (logic) was to filter our array to have a newArray with only greater than 3 Integers.
Wasn't it really simple? the complexity in O(n) , as obvious as it is, because it needs to traverse the whole array once to check the given predicate . *Note that here , n is the length -count- of main array.*

###  .filter or .compactMap , that is the question!

Think about the following code :

```
import Foundation

var array = [10, 7, 1, 4, 0, -2, 20]

let newArray = array.filter { (element) -> Bool in
    element < 5
}
let newArray_compactMap = array.compactMap { (element) -> Int? in
    if element < 5 {
        return element
    } else { return nil }
}
print(newArray)
print(newArray_compactMap)

let newArraySwifty = array.filter( { $0 < 5 })
let newArraySwifty_compactMap: [Int] = array.compactMap( {
    if $0 < 5 {
        return $0
    } else { return nil }

})
print(newArray)
print(newArray_compactMap)
// Result -> [1, 4, 0, -2]

``` 
It seems that we can achieve our goal by writing few more codes with .compactMap instead of .filter ! *So , why did Apple bother creating .filter?* It's the tricky part :) 
>According to [developer.apple.com/.filter](https://developer.apple.com/documentation/swift/sequence/3018365-filter) and [developer.apple.com/ .compactMap](https://developer.apple.com/documentation/swift/sequence/2950916-compactmap) while **.filter's complexity is O(n)** , it is **O(m + n) in .compactMap** !

The same issues -as .compactMap- go with **.map** plus .map isn't able to discard nil resulted elements =)

*Here's where Hamlet comes in and says **"To be, or not to be, that is the question:
Whether 'tis nobler in the mind to suffer
The slings and arrows of outrageous fortune,"** ... well , I guess by [The slings and arrows] , he meant misusing .compactMap instead of .filter which will cause us so much pain -I'll assure you it's nothing near noble =)))* .

Next : [Part (IV) : What is .reduce in Swift?](https://swiftycode.com/posts/part-iv-reduce/)
***
*Thanks a lot for coming this far and reading the article :) As you may know it's a series about **Higher Order Functions of Swift's Collection** , so make sure to read next articles as well as previous one -if you hadn't already- to completely master this subject . **Stay Safe** , **Code Well** & **Read Macbeth** =) *
> If you have any questions, suggestions or etc. feel free to contact me at *[alireza@swiftycode.com](mailto:alireza@swiftycode.com)* . We can also chat about One Piece & Macbeth beside Swift -kidding- on Twitter at *[@swiftycode_com](https://twitter.com/swiftycode_com)* .
