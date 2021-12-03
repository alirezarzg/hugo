---
title: 'Part (IV) : What is .reduce in Swift?'
date: 2021-11-18T08:40:41+00:00
slug: part-iv-reduce
tags:
- swifty-collections
- higher-order-functions
categories:
- Swifty Collections
series:
- Swifty Collections
aliases: []
summary: Let's learn what is .reduce and .reduce into in Swift's collections and much more about such Higher Order Functions ...
description: A deep introduction to .reduce and .reduce(into:) in Swift
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
Well, as always , It's simple ! 

Yeah , although it doesn't seem so but .reduce's functionality is super useful while super simple :)

# .reduce :
Imagine you have a collection (e.g. an array) of some elements . It doesn't matter if it is an array of Ints or a set of structs ; What would you do if you wanted to combine its elements? For example you have an array of Ints and you wanna know about their sum *(It'd be like combining integers by sum operation)* ! 
```
var array = [1, 2, 3, 4, 5]

var baseValue = 0
for element in array {
    baseValue += element
}
print(baseValue) // -> 15
``` 
Wanna know what Swift offers instead of the classic simple for-in loop in our case? *I'm honored to introduce you , the **.reduce** . * As [developer.apple.com](https://developer.apple.com/documentation/swift/array/2298686-reduce) says, the whole reason of Swift giving birth to .reduce is :
> To return the result of combining the elements of the sequence using the given closure.

Well, don't bother him -Apple Documentation- he only wants to say that :
>Whenever you felt like combining a collection, you can depend on .reduce! It only needs the collection you wanna combine , a baseValue to start combining with and the way you'd like it to combine -passed by a closure.

Let's help ourselves with .reduce :
```
var array = [1, 2, 3, 4, 5]
let combinedValue = array.reduce(0) { (previousResult, currentElement) -> Int in
    previousResult + currentElement
}
print(combinedValue) // -> 15
``` 
Om...,well, well, well , well, ... ( *for _ in 0...3 { print("well") }* ) although it seems a bit confusing but believe me it's unbelievably easy! Let me explain .

Just like what we saw in the for loop example above , we need to have a baseValue so that we can start the whole combining thing . Then we should let the .reduce function , to know how we desire our given collection (in this case array) to be combined . The passing closure of our combining logic must have two arguments which they'd represent previousResult and the currentElement :

** previousResult** is the *result of combining the given array's elements until now -the currentElement.*

 ** currentElement** is the *... -do I really need to explain it? :)*

So, to represent the .reduce function [developer.apple.com](https://developer.apple.com/documentation/swift/array/2298686-reduce) says :
```
func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result
```
To understand the above declaration you need to have good grasp of Generics in Swift *-I'll write about it soon* . To translate it in the most simple -careless- way possible for our example here is what we need for now *-I know, it's sloppy* :
```
a function to reduce(baseValue: Int, previousResult_AddedTo_currentElement: (Int, Int) -> Int) -> Int
``` 
So now you know that to combine a Sequence (collection) you need to have a baseValue to start with and a block of code (closure) to apply your desired logic . Like other Instance Methods and Higher Order functions in Swift , there is also a more Swifty way to use .reduce :
```
var array = [1, 2, 3, 4, 5]

let swiftyCombinedValue = array.reduce(0) { $0 + $1 }
print(swiftyCombinedValue) // -> 15
``` 
As you already know $0 is the first and $1 is the second argument of our closure , which in our case (.reduce) $0 refers to previousResult and $1 to the currentElement . Since we wanted to know about the sum of our array , we started with 0 as our initialResult to not to affect our final result. 

To go through what .reduce is doing generally , step by step, it's like :

"Where do I start? Give me an initialResult -maybe baseValue-" .reduce asks,

"Ok you wanted me to combine a collection for you. Then how do I do that?" 

"Would you mind passing the logic inside my closure , which has to arguments of what's the result of combining previous elements *-previousResult-* or your given *initialResult* and which element I'm currently on *-currentElement*."

Then it iterates through the array by having the result of previous combinations and tries applying the combination logic -passed through the closure- to each element . 

Keep in mind that at the starting point it uses the given initialResult -which we also called baseValue in our example- as the *..result of previous combinations..* .

According to [developer.apple.com](https://developer.apple.com/documentation/swift/array/2298686-reduce) , .reduce has :
> complexity of O(n), where n is the length of the sequence.

*... it's obvious because it traverses the whole given sequence for our sake !*

## One more magic!

There's also another awesome way to use .reduce and it is **Ultimately Swifty**! 

By now we've understood that .reduce's closure is smart enough to know $0 and $1 are its arguments; As you might have noticed the way we use it is somehow like an operation on its two arguments! *What if we could only pass the operator and leave the rest to our smart Swifty closure?*

Well, here it is:
```
var array = [1, 2, 3, 4, 5]

let swiftyCombinedValue_UltimateEdition = array.reduce(0, +)

print(swiftyCombinedValue_UltimateEdition)
``` 
 

# .reduce(into:) :

Well, to be honest at first .reduce(into:) seemed a bit tricky to myself but after trying to find its differences with the classic .reduce the whole thing was surprisingly easy! *So, It's simple :)* 

As you might have already guessed, it's almost the same as classic .reduce! *If there were more differences between them, why would they just **overload** it?*

The first thing we'd notice is the extra *into:* parameter; It's saying: ...reduce into *me*! As we've learned above, .reduce needed a starting point(starting value) called initialResult , here in .reduce(into:) it's somehow the same but there is a bit of a difference in the mechanism. 
>By using .reduce(into:) we reduce -or combine- the sequence using the given closure **into** the initialResult while in .reduce we did create a new value from combined -reduced- elements!

Let's take a look at their templates:
```
// Classic .reduce 
func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result

// Overloaded .reduce(into:)
func reduce<Result>(into initialResult: Result, _ updateAccumulatingResult: (inout Result, Element) throws -> ()) rethrows -> Result
``` 

As the arguments' naming offers, nextPartialResult (.reduce's closure) is named updateAccumulatingResult which suggests the same idea of combining into initialResult instead of returning the combined value through the closure !

That's why nextPartialResult (given closure) in .reduce returns the result ,while updateAccumulatingResult in .reduce(into:) returns *Void -nothing*.

Did you notice the *inout* keyword in .reduce(into:) closure? Well, that was the key difference! 
> Long story short, **inout** is used when we need to make the functions' parameters mutable! That means modifying the local variable will also modify the passed-in parameter.

*Riddle solved!* Instead of copying the initialResult , .reduce(into:) uses it to add-up combined results *into* . That's why [developer.apple.com](https://developer.apple.com/documentation/swift/array/3126956-reduce) says:
> .reduce(into:) is preferred over .reduce for efficiency when the result is a copy-on-write type, for example an Array or a Dictionary.

Let's see an example to help you understand it better (Although it's not the best/most-preferred example but it's useful to compare .reduce an .reduce(into:) :
```
let array = [1, 2, 4, 5]

let claasicReduce = array.reduce(0) { (previousResult, currentElement) -> Int in
    return previousResult + currentElement
}
print(claasicReduce) // -> 12

let reduceInto = array.reduce(into: 0) { (previousResult, currentElement) in
    previousResult += currentElement
}
print(reduceInto) // -> 12
``` 

>If there is anything you feel uncomfortable with, let me know via *[alireza@swiftycode.com](mailto:alireza@swiftycode.com)* or Twitter: *[@swiftycode_com](https://twitter.com/swiftycode_com)* . I'd try my best to explain it the way you'd understand ;)

That's all for .reduce! But if you're looking forward to see a semi real-world example of .reduce with structs in Swift you can follow along; *Keep in mind that you must have watched **Naruto** to understand this example -Just kidding I'll spoil it for you (without affecting the story) 👹. *

# Naruto *x* .reduce: The .reduce jutsu!

I'm super happy to see you here -*Believe it!*

If you don't know *the 7th Hokage, **Naruto***, let me tell you what you need to come along.

Naruto is a lovely character in *Naruto Shippuden* series who has an amazing ability *-jutsu-* called *Shadow Clones* to produce clones of himself. They're copies of him , that once they merge back into him they add all they've experienced, learned or trained to the main Naruto. Can you guess how does he do *merging back* part? Yay, it's the **.reduce** jutsu! (Jutsu ~= Technique)

Enough talk, let's dive into the code by creating an Struct for Naruto which has four properties :
```
class Naruto {
    var isClone: Bool
    var stamina = 100 , powerLevel = 0 , usedStamina: Int

    init(usedStamina: Int, isClone: Bool = true) {
        self.usedStamina = usedStamina
        self.isClone = isClone

        stamina -= usedStamina
    }
}
``` 
For now, the main Naruto hast 100 stamina and power level of 0; There is also isClone and used stamina to keep track of how much energy a clone used , and to see wether it is a clone or the actual Naruto -I know that this part is not a best practice .

Ok, let's create the real Naruto and ask him to create his shadow clones to get trained!
```
// Here we have the Real Hero -Naruto . Dattebayo!
var realNaruto = Naruto(usedStamina: 0, isClone: false)

// Ok, Shadow Clone Jutsu ... Poof!
var narutoClonesArray = [
    realNaruto,
    Naruto(usedStamina: 10),
    Naruto(usedStamina: 5),
    Naruto(usedStamina: 15),
    Naruto(usedStamina: 30)
]
``` 
By now we have 4 clones of Naruto which they've already used some stamina.

Now, let's start training them -Naruto and his clones. As a Sensei -trainer- I'd prefer using .map to train each of them equally to gain power level of 20.
```
// Well dear Shadow Clones , let's train for Alireza Sensei .
var trainedNarutoClones = narutoClonesArray.map { (clone) -> Naruto in
    clone.powerLevel = 20
    return clone
}
``` 

Now that we have an array of trained Naruto and clones it's time to gather up all of the clones so that our dear Naruto can power-up ! *** .reduce Jutsu*** :
```
// Time to gather up clones ...
realNaruto = trainedNarutoClones.reduce(realNaruto, +)
``` 
Wow! *-probably in a for loop of 0...10!* .

How did you add up those Naruto objects? Let me reveal the hidden part of my code :
```
// How to add up Naruto's Shadows Clones
extension Naruto {
    static func +(left: Naruto, right: Naruto) -> Naruto {
        let narutoClone = Naruto(usedStamina: 0)

        narutoClone.stamina = right.stamina + left.stamina
        narutoClone.powerLevel = right.powerLevel + left.powerLevel
        if !right.isClone || !left.isClone {
            narutoClone.isClone = false
        }

        return narutoClone
    }
}
``` 
> What we've done is called Operator Overloading ; It's the act of overloading an operator's function so that we can use different argument types! Soon, I'll publish an article on how to make use of operator overloading deeply!

Curious how much power did Naruto gain and how much stamina did he used? As you might know it's not like print(realNaruto) would give us any information! So here Swift comes to save us :
```
//Print detail of Naruto state:
extension Naruto: CustomStringConvertible {
    var description: String {
        "Current State-> Power Level: \(powerLevel), Stamina: \(stamina), Is Clone: \(isClone)"
    }
}
``` 
So ... let's print Naruto like a pro :
```
print(realNaruto) 
// "Current State-> Power Level: 120, Stamina: 540, Is Clone: false"
``` 

>You might wonder why I've used Class and not Struct? The answer is something like this : **Classes are reference types** ! Well, Let me spoil that :) The next series is **Swifty Types: What are named types?** .


***
*Thanks a lot for coming this far and reading the article :) As you may know it's a series about **Higher Order Functions of Swift's Collection** , so make sure to read next articles as well as previous one -if you hadn't already- to completely master this subject -**Dattebayo!** . **Stay Safe** , **Code Well** & **Watch Naruto** =) *
> If you have any questions, suggestions or etc. feel free to contact me at *[alireza@swiftycode.com](mailto:alireza@swiftycode.com)* . We can also chat about One Piece ,Macbeth & Naruto beside Swift -kidding- on Twitter at *[@swiftycode_com](https://twitter.com/swiftycode_com)* .