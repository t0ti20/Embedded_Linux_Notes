- definition int x{1};
- constants constexpr int x{1}; like  `#define`
- constants constinit int x{1}; ensuring that the initialization of the variable happens during the static initialization phase, preventing potential issues with initialization order or delayed initialization.
- function overloading
- if constexpr
- if and switch with initializer
- size_t in loops
- Range Based For Loop with initializer
## References
In C++, a reference is a powerful feature that allows you to create an alias for an existing variable. This means that the reference becomes another name for the same memory location as the original variable.
Main Features:
1- Don't use dereferencing for reading and writing
2-Can't be changed to reference something else
3- Must be initialized at declaration
Example:
```Cpp
int Variable {100};
#Reference Syntax
int &Variable_Alias {Variable};
#Make Constant Alias
const int &Const_Alias {Variable};
#Modify Alias and Source
Variable_Alias=10;
#Test
cout<<Const_Alias-Variable<<&Const_Alias-&Variable;//00
cout<<endl<<Const_Alias<<Variable_Alias;//1010
######################################
#Usefil In Range Based Loop
int Array[]{1,2,3,4,5};
for(auto &Element:Array)
{
  Element+=1;
}
for(auto Element:Array)
{
  cout << Element << endl;
}
```
# Strings (std::string)
## Declaring and Using 

```cpp
#include<string>
//Empty String
std::string Name;
//Initialized
std::string Name{"My Name"};
//Part Of Strring
std::string Name{"My Name",4};
//Repeat Character
std::string Name{'A',4}
//Range
std::string Name{"Hello World",2,6};
```

## Concatenating

```cpp
#include<string>
std::string Name_1{"My Name"};
std::string Name_2{" Is Khaled"};
// + Operator
std::string Name{Name_1+Name_2};
//Append
Name_1.append(Name_2);
```

##  Accessing Characters

```cpp
#include<string>
std::string Name{"This Is My String."};
// size Function
for(size_t Counter{};Counter<Name.size();Counter++)
{
	std::cout<<Name[Counter]<<std::endl;//Name.at(Counter)
}
// front and back
 char &Front=Name.front();
 char &Back=Name.back();
 Front='t';
 Back='!';
 cout<<Name<<endl;
 // Pointer
 std::string Name{"This Is My String."};
 char *Name_Ptr=Name.data();
 cout<<Name_Ptr<<endl;
```

## Size and Capacity

```cpp
#include<string>
std::string Name{"This Is My String."};
std::string No_Name{};
// empty Function
cout<<Name.empty()<<endl;
cout<<No_Name.empty()<<endl;
// size function
cout<<No_Name.size()<<endl;
cout<<Name.size()<<endl;
// length function
cout<<No_Name.length()<<endl;
cout<<Name.length()<<endl;
// max number
cout<<std::string::max_size()<<endl;
cout<<std::Name.capacity()<<endl;
// extend size
Name.reserve(<bytes>);
// reduce string
Name.shrink_to_fit(<bytes>);
```

## Modifying

```cpp
#include<string>
std::string Name{"This Is My String."};
// insert string
Name.insert(4," Hello");
Name.insert(4,1,'H');
Name.insert(4," Hello World",6);
// erase string
Name.erase(4,Name.size());
// empty string
Name.clear();
std::cout<<Name<<std::endl;
// push - pop
Name.push_back('!');
Name.pop_back();
```
##  Comparing

```cpp
#include<string>
std::string Number_1{"Number 1"};
std::string Number_2{"Number 2"};
// operator
if(Number_1>Number_2)cout<<"True"<<endl;
else cout<<"False"<<endl;
// compare
if(Number_1.compare(0,6,Number_2,0,6)==0)cout<<"True"<<endl;
else cout<<"False"<<endl;
```

##  Common Operations

```cpp
#include<string>
std::string Number{"Number 1"};
// Replacing
Number.replace(7,8,"2");
// copy
char Array[10]{};
Number.copy(Array,1,7);
cout<<Array<<endl;
// resize
Number.resize(10,'!');
Number.resize(6);
cout<<Number<<endl;
// swap
std::string Number_1{"Number 1"};
std::string Number_2{"Number 2"};
Number_1.swap(Number_2);
cout<<Number_1<<endl;
```

## Searching

```cpp
#include<string>
std::string Number{"The Number Is 1"};
// find
cout << Number.find("Is") << endl;
cout << Number.find("The",2) << endl;
```

## Numbers Transforming

```cpp
#include<string>
std::string Number_String{};
int Number{100};
// to_string
Number_String=to_string(Number);
cout << Number_String << endl;
// sto<type>
Number=stoi(Number_String);
cout << Number_String << endl;
```

## Raw String Literals

```cpp
#include<string>
std::string String
{
  R"<delimiter>(  1-Hello!
  2-Hello/
  3-Hello*
  4-Hello
  )<delimiter>"
};
cout<<String<<endl;
```



## String View

```cpp
#include<string>
std::string Name{"This Is My Name !"};
std::string_view Name_View{Name};
//remove_prefix
Name_View.remove_prefix(1);
//remove_suffix
Name_View.remove_suffix(1);
std::cout<<Name_View<<std::endl;
```



















