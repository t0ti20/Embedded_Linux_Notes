## Polymorphism :

Polymorphism is a fundamental concept in object-oriented programming (OOP) that allows a variable, function, or object to take on multiple forms. In C++, polymorphism is achieved through two main types: Compile-time Polymorphism (Method Overloading) and Run-time Polymorphism (Method Overriding).
  
### Compile-time Polymorphism: Method Overloading
Compile-time polymorphism occurs when multiple functions in the same scope have the same name but different parameters. The compiler determines which function to call based on the number and types of arguments.
### Run-time Polymorphism: Method Overriding
Run-time polymorphism is achieved through method overriding. This occurs when a base class declares a function as virtual, and a derived class provides a specific implementation. The function to be executed is determined at runtime, allowing dynamic behavior.

To implement run-time polymorphism in C++, you use virtual functions. A virtual function is a member function declared within a base class and overridden by a derived class. When you refer to a derived class object using a pointer to the base class, you can call a virtual function and execute the derived class's version of the function.

Here's an example code demonstrating run-time polymorphism:
```cpp
#include <iostream>
using namespace std;
class Shape
{
  string Shape_Color;
public:
  Shape(string Color)
  {
    Shape_Color=Color;
  }
  virtual void Area()
  {
    cout << "This Is The Shape Area" <<endl;
  }
};
class Rectangle : public Shape
{
  int Rectangle_Length;
  int Rectangle_Width;
public:
  Rectangle(int Length,int Width,string Color):Shape{Color}
  {
    Rectangle_Length=Length;
    Rectangle_Width=Width;
  }
  virtual void Area()
  {
    cout << "This Is The Rectangle Area" <<endl;
  }
  virtual void Area2()
  {
    cout << "This Is The Rectangle Area2" <<endl;
  }
};
int main()
{
  Shape *Shape_Ptr;
  Rectangle Rectangle_1{10,20,"Red"};
  Shape_Ptr=&Rectangle_1;
  Shape_Ptr->Area();
}
```

In this example:
- We have a base class `Shape` with a virtual function `Area`.
- The derived class `Rectangle` inherits from `Shape` and overrides the `Area` function.
- The `main` function demonstrates polymorphism by using a pointer to the base class to refer to a derived class object and calling the `Area` function.
This showcases how virtual functions enable dynamic dispatch and allow objects of different classes to be treated polymorphically.

___
## Abstract Classes and Final Classifier :

An abstract class, often referred to as an interface, outlines the behavior or capabilities of a C++ class without specifying its actual implementation. The primary purpose of an abstract class is to act as a blueprint for other classes in a hierarchy. Abstract classes cannot be instantiated, serving solely as an interface for derived classes. This implies that functions within an abstract class must be overridden by concrete (non-abstract) derived classes. However, if you want to prevent further overriding of a particular function, you can use the `final` specifier, as demonstrated in the following example.

In C++, a class is designated as abstract by declaring at least one of its functions as a pure virtual function. A pure virtual function lacks implementation in the abstract class and mandates implementation by any concrete derived class.

### Example Code: Abstract Classes

```CPP
#include <iostream>

using namespace std;

//Abstracted Class Cuz It Have Pure virtual Function
class Shape 
{
  string Shape_Color;
public:
  //Constructor to set the color of the shape
  Shape(string Color) : Shape_Color(Color) {}
  //Pure virtual function to define the 'Area' interface
  virtual void Area() = 0;
  virtual void Display() final
  {
    cout << "This Is The Shape Display" << endl;
  }
};

class Rectangle : public Shape 
{
  int Rectangle_Length;
  int Rectangle_Width;
public:
	//Constructor to initialize dimensions and color
	Rectangle(int Length, int Width, string Color) : Shape(Color)
	{
		Rectangle_Length = Length;
		Rectangle_Width = Width;
	}
	//Implementation of the pure virtual function 'Area' from the base class
	void Area() override 
	{
		cout << "This Is The Rectangle Area" << endl;
	}
	//Additional function specific to the Rectangle class
	void Area2() 
	{
		cout << "This Is The Rectangle Area2" << endl;
	}
};

int main() 
{
  // Using a pointer to the base class to demonstrate polymorphism
  Shape *Shape_Ptr;
  Rectangle Rectangle_1{10, 20, "Red"};
  Shape_Ptr = &Rectangle_1;
  //'Area' function is polymorphically overridden in the Rectangle class
  Shape_Ptr->Area();
  Shape_Ptr->Display();
}
```

___
## Friend Function and Friend Class :
### Friend Function:

A friend function of a class is defined outside that class's scope, but it has the right to access all private and protected members of the class. The prototypes for friend functions appear in the class definition. Friend functions are not member functions.

```cpp
#include <iostream>
using namespace std;
class Person 
{
friend void New_Display(Person);
private:
  string Person_Name;
  string Person_Gender;
  float Person_Age;
public:
  Person(){}
  Person(string Name,string Gender,float Age)
  :Person_Name{Name},Person_Gender{Gender},Person_Age{Age}
  {}
  void Display()
  {
    cout << "This Is The Person Display" << endl;
  }
};
void New_Display(Person Current_Person)
{
  cout << "This Is The Public Display " << Current_Person.Person_Name << endl;
}
int main() 
{
  Person Person_1{"Ahmed","Male",22};
  New_Display(Person_1);
}
```
### Friend Class:

Just like friend functions, we can also have a friend class. A friend class can access private and protected members of the class to which it is a friend. Note that the friendship is not mutual unless we make it so. The friendship of the class is not inherited. This means that as class B is a friend of class A, it will not be a friend of the subclasses of class A.

```cpp
#include <iostream>
using namespace std;
class Person 
{
friend class Engineer;
private:
  string Person_Name;
  string Person_Gender;
  float Person_Age;
public:
  Person(){}
  Person(string Name,string Gender,float Age):Person_Name{Name},Person_Gender{Gender},Person_Age{Age}{}
  void Display()
  {
    cout << "This Is The Person Display" << endl;
  }
};
class Engineer
{
private:
public:
  void Print_Engineer(Person Current_Engineer)
  {
    cout << "This Is The Engineer Display " << Current_Engineer.Person_Name << endl;
  }
};
int main() 
{
  Person Person_1{"Ahmed","Male",22};
  Engineer Engineer_1;
  Engineer_1.Print_Engineer(Person_1);
}
```
