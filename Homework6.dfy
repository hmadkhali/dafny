datatype List<T> = Nil | Cons(T, List<T>)
//The datatype here is List datatype which means that it may be Nil value 
//Also [T,List[T]] T being an element as above
datatype Tree<T> = Leaf | Node(Tree<T>, Tree<T>, T)
//The datatype here is Tree datatype which means it may be Node or Leaf; Node being T
// We have Tree1  &   Tree2




function treeContains<T>(tree:Tree<T>, element:T):bool

// The function above can take two inputs which are:
// a Tree and an element 
// Then make sure if the element is in the tree or not.
//Recursive Function here will check the Condition 
// If Tree is exhausted and the element argument is not present in the tree, then return false
//And when element passes then it is a Leaf
// then return false as element is not present, or
//  keep on splitting the tree into two trees and checking for same element using same function recursively
{
	match(tree)
    case Leaf() => false
    case Node(LeftTree, RightTree, PresentNode) => treeContains(LeftTree, element) || treeContains(RightTree, element)
}



function listContains<T>(xs:List<T>, element:T):bool

// The function above takes 2 inputs which are 
//  List and an element and make sure if the element is in the List or not
//Recursive Function will check the Condition 
// If List is exhausted and the element argument is not present in the List return false
// And when element passes then it is Nil, then return false as element is not present, or 
//keep searching in the list using same function recursively to make sure that the presence of element is in the List
{
	match(xs)
		case Cons(ArgElement, RestOfList) => ArgElement==element || listContains(RestOfList, element) 
		case Nil => false
}


 
function append<T>(xs:List<T>, ys:List<T>):List<T>
//the function above uses two input elements ,then appends the first one to the other one 
//Recursive Function will check the Condition 
// When the first argument is of type Nil, then the list does not have any more elements
//and when first element is Nil, 
{
	match(xs) 
		case Nil => ys
		case Cons(FirstElement, RestOfList) =>  Cons(FirstElement, append(RestOfList, ys))
}



function flatten<T>(tree:Tree<T>):List<T>

//the function above uses only 1 input element Tree
// it then flattens the same, then convert the tree elements into a list
//Recursive Function will check the Condition 
// When the recieved input argument is of type LEaf implying end of branch of tree
//and when first element is of type Leaf, return Nil
{
  	match(tree)
    case Leaf() =>  Nil
    case Node(LeftTree, RightTree, PresentNode) => Cons(PresentNode,append(flatten(LeftTree),flatten(RightTree)))
    
}



ghost method sameElements<T>(tree:Tree<T>, element:T)
//The function above is meant to see and prove if the tree is flattened or not.
//it also see if  the list obtained has all the elements as that of the tree or not.
//Our assumption is true if first element is a leaf .
//Otherwise, then we need to flatten the tree again 

{
	match(tree)
    case Leaf() =>
    //
    case Node(LeftTree,RightTree,PresentNode) =>
    calc {
       treeContains(tree, element)
     ==
       listContains(flatten(tree),element);
    }
}


