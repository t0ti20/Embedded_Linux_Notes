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