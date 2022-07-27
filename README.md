# CatBox

Cats and Boxes and its equation.

[**Play it here!**](https://masynchin.github.io/CatBox/)

## What it is?

CatBox is little project based on this picture.

My motivation was to learn basic of monadic parsers, so I chose PureScript [parsec](https://github.com/purescript-contrib/purescript-parsing) with which I can build interactive game.

Model of the game can be described like:

~~~plain
Equation is either Box or Cat.
Cat is Cat.
Box is one or more Equations.
~~~

For this model I created special syntax, which can be described in extended Backus–Naur form like:

~~~ebnf
equation ::= box | cat
box ::= equation, { equation }
cat ::= 😼
~~~
