#include <stdio.h>
#include <stdbool.h>

// 定义全局变量和常量
int i = 2;
int f = 1;

// 声明函数
int factorial(int n);

// 定义宏
#define PRINT_RESULT(result) printf("Result: %d\n", result)

    int n;

    printf("Enter a number: ");
    scanf("%d", &n);

    // 调用函数计算阶乘
    int result = factorial(n);

    // 使用宏打印结果
    PRINT_RESULT(result);

    return 0;
}

// 实现计算阶乘的函数
int factorial(int n) {
    
    while (i <= n) {
        f *= i;
        i++;
    }

    return f;
}

int main() {
