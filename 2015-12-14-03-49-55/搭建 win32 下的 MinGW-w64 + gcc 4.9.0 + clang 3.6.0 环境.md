###搭建MinGW + gcc 4.9.0 + clang 3.6.0 环境

>[下载][1](解压后 311MB 左右)

1. 去 http://www.drangon.org/mingw/ 下载 `mingw-w32-bin-i686-20140425.7z` 解压放在`C:\MinGW32_drangon`
2. 去 http://www.mingw.org/ 下载 MinGW 安装到`C:\MinGW`，先别在意 path
 
 > 这里其实只是需要他自带的 msys 环境，如果已经有其他的(如 msys2)，可以试试用现有的
3. 安装[Subversion][2]，我用的是[VISUALSVN][3]的`Apache Subversion command line tools`，解压并添加  path
4. 安装 Python2，添加到 path
5. 新建文件夹`C:\MinGW\msys\1.0\src`
6. 运行`"C:\MinGW\msys\1.0\msys.bat"`
7. 
 ```cpp
 cd src
 svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm
 ```

8. 
 ```
 cd llvm/tools
 svn co http://llvm.org/svn/llvm-project/cfe/trunk clang
 ```
9. 
 ```
 cd llvm/projects
 svn co http://llvm.org/svn/llvm-project/compiler-rt/trunk compiler-rt
 ```

10. `MinGW` 文件夹重命名为 `MinGW_clang`
11. 将`C:\MinGW32_drangon\bin`添加到 path

12. 因为我是要弄`i686-w64-mingw32`使用的 clang ，且 gcc 版本高于 clang 原本支持的版本，导致 include 头文件查找失败需要自己 -I，因此需要修改代码
 > MinGW32_drangon 的目录结构与 MinGW-w64 是相同的
13. 修改 `llvm\tools\clang\lib\Frontend\InitHeaderSearch.cpp`

 在
 ```
       AddMinGW64CXXPaths(HSOpts.ResourceDir, "4.7.3");
       AddMinGW64CXXPaths(HSOpts.ResourceDir, "4.8.0");
       AddMinGW64CXXPaths(HSOpts.ResourceDir, "4.8.1");
       AddMinGW64CXXPaths(HSOpts.ResourceDir, "4.8.2");
 ```
 后面添加
 ```
       AddMinGW64CXXPaths(HSOpts.ResourceDir, "4.9.0");
       AddMinGW64CXXPaths(HSOpts.ResourceDir, "4.9.1");
       AddMinGW64CXXPaths(HSOpts.ResourceDir, "4.9.2");
       AddMinGW64CXXPaths(HSOpts.ResourceDir, "4.9.3");
 ```
14. 在`msys.bat`目录下打开`cmd`，输入`msys.bat`，看看有没有`gcc`(在cmd中打开是为了继承环境变量)

 正常的话可以编译了
 ```
 export CC=gcc
 export CXX=g++
 cd ../../src/build/
 ../llvm/configure --disable-docs --disable-assertions --enable-optimized --enable-targets=x86 --build=i686-w64-mingw32 --prefix=/clang_mingw
 make
 make install
 ```

 > + 确保使用 msys 的 make，make 会花好长时间，我的 i5 用了一个多小时才弄完  
 > + `make -jN` N 为逻辑处理器数，正常的话可以提高使用率
 > +  `make install` 会放到`C:\MinGW_clang\msys\1.0\clang_mingw`下
  `make install` 也花了一阵子，真不能理解

15. 可以将 MinGW32_drangon 重命名为 MinGW 或其他正式的名字，顺便改 path
16. 合并 `MinGW_clang\clang_mingw` 目录到`C:\MinGW`（显然，应该没有重复文件的警告）
17. 新开个 cmd 看看 `gcc -v` 和 `clang -v` 输出对不对
18. 找个地方创建`regex.cpp`

 ```cpp
 #include <iostream>
 #include <string>
 #include <regex>
  
 int main()
 {
     std::string lines[] = {"Roses are #ff0000",
                            "violets are #0000ff",
                            "all of my base are belong to you"};
  
     std::regex color_regex("#([a-f0-9]{2})"
                             "([a-f0-9]{2})"
                             "([a-f0-9]{2})");
  
     for (const auto &line : lines) {
         std::cout << line << ": " 
                   << std::regex_search(line, color_regex) << '\n';
     }   
  
     std::smatch color_match;
     for (const auto &line : lines) {
         std::regex_search(line, color_match, color_regex);
         std::cout << "matches for '" << line << "'\n";
         for (size_t i = 0; i < color_match.size(); ++i) {
             std::ssub_match sub_match = color_match[i];
             std::string sub_match_str = sub_match.str();
             std::cout << i << ": " << sub_match_str << '\n';
         }   
     }   
 }
 ```
19. 从`regex.cpp`所在目录打开 cmd，运行 `clang++ regex.cpp -std=c++11 -fno-exceptions -o a.exe`
运行看看行不行，没错的话就好了


> PS.如果是想为 MinGW-builds 编译clang 则在
> `"C:\msys32\home\wenlong\clang\llvm\tools\clang\lib\Frontend\InitHeaderSearch.cpp"`的
> `#if defined(LLVM_ON_WIN32)`后添加
>```
       AddPath(HSOpts.ResourceDir + "/../../../i686-w64-mingw32/include/c++/" ,
       CXXSystem, false);
       AddPath(HSOpts.ResourceDir + "/../../../i686-w64-mingw32/include/c++/" + "i686-w64-mingw32",
       CXXSystem, false);
       AddPath(HSOpts.ResourceDir + "/../../../i686-w64-mingw32/include/c++/" + "backward",
       CXXSystem, false);
>```

  [1]: http://pan.baidu.com/s/1dD5Y1zV
  [2]: http://subversion.apache.org/packages.html
  [3]: http://www.visualsvn.com/downloads/