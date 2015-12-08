#include <iostream>
#include <string>

using namespace std;

int main(int argc, char *argv[])
{
    int x(5);

    string s1("test");

    printf("%d %s\n", x, s1.c_str());
    return 0;
}
