# RPN-Calculator

This repository provides a reverse-polish-notation calculator.

## Prerequisites

In order to run this program, you need a copy of `ruby`.
In order to run the tests, you will also need to run the following:

- gem install bundler
- bundle install

## Usage

Run `./example.rb` for an interactive calculator session.
Input the components of your calculation in reverse-polish notation, one line at a time.
Valid operators are "+", "-", "\*", and "/".

## Sample session

```
1
2
+
= 3
2
*
= 6
4
-
= 2
q
goodbye
```

## Known Issues

This calculator does not gracefully handle invalid inputs.
If, for example, you type a session like this:

```
1
+
```

Your calculator will properly display an error (as there's nothing to add to `1`), but it will *not* restore the previous state of the calculator afterwards.


