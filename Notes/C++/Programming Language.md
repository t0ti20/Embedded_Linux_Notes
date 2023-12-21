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

# Operators
## Operator Types

```CPP
# Arithmetic Operators
a + b;
# Assignment Operators
a = 5;
# Relational Operators
a > b;
# Logical Operators
(a>b)&&(a>10);
# Bitwise Operators
a&1;
# Other Operators
sizeof
?:
&
.
->
>>
<<
```
## Operator Overloading

```CPP
void operator+(uint32_t &Number,const string &Name)
{
    for(size_t Counter{};Counter<Name.size();Counter++)
    {
        Number=Number*10+(Name[Counter]-'a');
    }
}
int main (int argc,char *argv[])
{
    uint32_t Number{};
    string Name{"abcdefg"};
    Number+Name;
    cout<<Number<<endl;
    return 0;
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

## Accessing Characters

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
## Comparing

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

## Common Operations

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





















___
# Functions
## Pass By Reference

```cpp
// & Operaot
void Modify_Number(int &Number){Number++;}
int main()
{
  int x{9};
  Modify_Number(x);
  cout << x << endl;
  return 0;
}
// Pointer
// Array
void Modify_Number(int (&Array)[4],int Size)
{
	for(size_t Counter{};Counter<Size;++Counter)
	{
		Array[Counter]++;
	}
}
int main()
{
  int x[]{10,20,30,40};
  Modify_Number(x,4);
  cout << x[1] << endl<< x[2] << endl<< x[3] << endl;
  return 0;
}
// & And Cast
void Modify_Number(const int &Number){cout << x << endl;}
int main()
{
  double x{9};
  Modify_Number(x);//Id Const Not Exist Will Fail
  return 0;
}
```
## Constrexpr

```CPP
constexpr int Power(constexpr int Number)
{
	return (Number*Number);
}
int main ()
{
	constexpr int Number = Power(2);
	std::cout<<Number<<std::endl;
	return 0;
}
```
## Consteval

```CPP
consteval int Power(int Number)
{
	return (Number*Number);
}
int main ()
{
	constexpr int Number = Power(2);
	std::cout<<Number<<std::endl;
	return 0;
}
```
## Main Arguments 

```cpp
int main (int argc,char *argv[])
{
    for(size_t Counter{};Counter<argc;++Counter)
    {
        cout<<argv[Counter]<<std::endl;
    }
    return 0;
}
```
## Return By Reference
```cpp
int &Maximun_Number(int &First_Number,int &Second_Number)
{
    return (First_Number>Second_Number)?First_Number:Second_Number;
    //static int result =(First_Number>Second_Number)?First_Number:Second_Number;
    //return result;
}
int main (int argc,char *argv[])
{

    int First_Number{10},Second_Number{20};
    int Result{Maximun_Number(First_Number,Second_Number)};
    cout<<Result<<std::endl;
    return 0;
}
```
## Function Overloading

```cpp
#include <array>
void Print_Name(string Name_1){cout<<Name_1<<endl;}
void Print_Name(string Name_1,string Name_2){cout<<Name_1<<' '<<Name_2<<endl;}
int main (int argc,char *argv[])
{
    Print_Name("Hello World");
    Print_Name("Hello","World");
    return 0;
}
```
## Optional Output

```cpp
#include <optional>
using namespace std;
int main (int argc,char *argv[])
{
    optional<int> Age{3};
    optional<string> Name{"Ahmed"};
    optional<bool> Gender{nullopt};
    cout<<(Age.has_value()?Age.value():-1)<<endl;
    cout<<static_cast<string>(Name.has_value()?Name.value():"")<<endl;
    cout<<(Gender.has_value()?Gender.value():-1)<<endl;
    return 0;
}
#--------------------------------------------------------------
optional<size_t> Get_Char(const string &Name,optional<char> Char)
{
    optional<size_t>Result{nullopt};
    char Searching_For{Char.value_or('!')};
    for(size_t Counter{};Counter<Name.size();++Counter)
    {
        if(Searching_For==Name[Counter])Result=Counter;
    }
    return Result;
}
int main (int argc,char *argv[])
{
    string Name{"Hello World!"};
    optional<size_t> Result=Get_Char(Name,'A');
    cout<<static_cast<int>(Result.has_value()?Result.value():-1)<<endl;
    return 0;
}
```
# Enum & Type Alias
## Enum Class

```cpp
enum class MONTH : unsigned char
{
	JAN,FEP=254,MAR,
};
int main ()
{
	unsigned int Register=3'000'000'000;
	MONTH x=MONTH::MAR;
	std::cout << static_cast<int>(x) << std::endl;
	using enum MONTH
	MONTH x=MAR;
	std::cout << static_cast<int>(x) << std::endl;
	return 0;
}
```

## Type Alias

```cpp
using Number=unsigned int;
int main ()
{
    Number x=123;
    std::cout << x << std::endl;
    return 0;
}
```

