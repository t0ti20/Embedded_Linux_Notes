## Steps

1- **Prepare CMake**

```cmake
#Set Version
cmake_minimum_required(VERSION 3.22)
#Set Project Name  
PROJECT(Test_CPP VERSION 22.22)
#Set CPP Standard
set(CMAKE_CXX_STANDARD 20)
#Find Needed Package For This Project
find_package(GTest REQUIRED)
#Enable G-Test
enable_testing()
#Locate Source Files
set(SRC_FILES "./Source/Company/Company.cpp")
set(SRC_TEST "./Source/Company/Company_Test.cpp")
#Add Executable
set(Application_Name "Main")
add_executable(${Application_Name} ${SRC_FILES} ${SRC_TEST})
message(STATUS "Files To Be Compiled : ${SRC_FILES}")
#Link Gtest While Compiling
target_link_libraries(${Application_Name} PUBLIC GTest::gtest GTest::gmock_main)
#Include Google Test
include (GoogleTest)
gtest_discover_tests(${Application_Name})
```

2-**Create Test Source File**

```cpp
//Include GTest Headders
#include <gtest/gtest.h>
#include "Company.hpp"
//Create Test Case
TEST(Group_1,Test_1)
{
    Math Calculator{11,12};
    /* Arrange */
    double Result{};
    /* Act */
    Result=Calculator.Add();
    /* Expect */
    EXPECT_EQ(Result,23);
}
```

3- **Run Test And Check Result**

## Types Of Tests In CMake
### TEST

```cpp
#include <gtest/gtest.h>
#include "Company.hpp"
TEST(Group_1,Test_3)
{
    Math Calculator{20,40};
    /* Arrange */
    double Result{};
    /* Act */
    Result=Calculator.Add();
    /* Expect */
    EXPECT_EQ(Result,62);
}
```
### TEST_F

```cpp
#include <gtest/gtest.h>
#include "Company.hpp"
class Math_Test : public testing::Test
{
public:
    Math Calculator{6,10};
    void SetUp()override
    {
        cout<<"Starting\n";
    }
    void TearDown()override
    {
        cout<<"Ending\n";
    }
};
TEST_F(Math_Test,Test_4)
{
    /* Expect */
    EXPECT_EQ(Calculator.Add(),16);
}
```
### TEST_P

```cpp
#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include "Company.hpp"

// Define a fixture class for parameterized tests
class MathParamTest : public testing::TestWithParam<std::tuple<int, int, int>>
{
public:
    Math Calculator;
    void SetUp() override 
    {
        Calculator = Math(std::get<0>(GetParam()), std::get<1>(GetParam()));
    }
};

// Define parameters for the test cases
INSTANTIATE_TEST_SUITE_P(MathTests, MathParamTest,
    testing::Values(
        std::make_tuple(1, 2, 3),   // Test case 1
        std::make_tuple(4, 5, 9),   // Test case 2
        std::make_tuple(-3, 6, 3)   // Test case 3
    )
);

// Test case using TEST_P
TEST_P(MathParamTest, AddTest) {
    int expected = std::get<2>(GetParam());
    EXPECT_EQ(Calculator.Add(), expected);
}

```
## Syntax

```cpp
#include <gmock/gmock-matchers.h>
#include <gtest/gtest.h>
TEST(Test_Group,Test_Name)
{
#Compare Intity And Stop Test
ASSERT_THAT(5,5);
#Compare Intity
EXPECT_THAT(5,5);
#Return Value Is True
EXPECT_TRUE(1);
#Return Value Is False
EXPECT_FALSE(1);
#Compare Numbers
EXPECT_EQ(100,100);
EXPECT_NE(100,100);
EXPECT_LT(100,100);
EXPECT_LE(100,100);
EXPECT_GT(100,100);
EXPECT_GE(100,100);
#Compare String
EXPECT_STREQ("100","100");
EXPECT_STRNE("100","100");
EXPECT_STRCASEEQ("Ahmed","AHMED");
EXPECT_STRCASENE("Ahmed","AHMED");
#Use Test Utils 
using::testing::StartsWith;
EXPECT_STREQ("Hello",StartsWith("Hello"));
#
}
#######################################################
TEST(Group_1,Test_1)
{
    using namespace testing;
    std::vector<int> Output{1,2,3};
    std::string Text{"Welcome To My Application"};
    int *Pointer{};
    int Value{10};
    /*===========================================*/
    EXPECT_THAT(Pointer,IsNull());
    //EXPECT_THAT(Pointer,NotNull());
    /*===========================================*/
    EXPECT_THAT(Output,testing::ElementsAre(1,2,3));
    /*===========================================*/
    EXPECT_THAT(Text,StartsWith("Welcome"));
    EXPECT_THAT(Text,MatchesRegex("[a-zA-Z ]{8}To.*"));
    /*===========================================*/
    EXPECT_THAT(Value,Gt(3));
    EXPECT_THAT(Value,AllOf(Gt(9),Lt(11)));
    /*===========================================*/
    EXPECT_THAT(Output,Each(Lt(Value)));
}
```
## Common Commands

```Bash
#Show Tests In Make
ctest -V

```

# References

1 - [G-Test Utils](google.github.io/googletest/reference/matchers.html).
2- [G-Test](https://google.github.io/googletest/)