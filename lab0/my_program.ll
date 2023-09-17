; Declare the string constant as a global constant.
@.str1 = private unnamed_addr constant [30 x i8] c"Please input two number x,y:\0A\00"
@.strx = private unnamed_addr constant [10 x i8] c"input x:\0A\00"
@.stry = private unnamed_addr constant [10 x i8] c"input y:\0A\00"
@.str2 = private unnamed_addr constant [30 x i8] c"Please input control number:\0A\00"
@.i1str = private unnamed_addr constant [11 x i8] c"1:x add y\0A\00"
@.i2str = private unnamed_addr constant [11 x i8] c"2:x sub y\0A\00"
@.i3str = private unnamed_addr constant [11 x i8] c"3:x mul y\0A\00"
@.i4str = private unnamed_addr constant [11 x i8] c"4:x div y\0A\00"
@.outputstr = private unnamed_addr constant [43 x i8] c"x = %d, y = %d, control = %d, result = %d\0A\00"

@.Input = private unnamed_addr constant [3 x i8] c"%d\00"

@.biggerstr = private unnamed_addr constant [27 x i8] c"number is bigger than 100\0A\00"
@.defaultstr = private unnamed_addr constant [22 x i8] c"error to read number\0A\00"

; External declaration of the puts function
declare i32 @printf(i8*, ...)
declare i32 @__isoc99_scanf(i8*, ...)



; Definition of main function
define i32 @main() {

  entry:
    br label %loop

  loop:

    %str1 = getelementptr inbounds [30 x i8], [30 x i8]* @.str1, i32 0, i32 0
    %strx = getelementptr inbounds [10 x i8], [10 x i8]* @.strx, i32 0, i32 0
    %stry = getelementptr inbounds [10 x i8], [10 x i8]* @.stry, i32 0, i32 0
    %strxInput = getelementptr inbounds [3 x i8], [3 x i8]* @.Input, i32 0, i32 0
    %stryInput = getelementptr inbounds [3 x i8], [3 x i8]* @.Input, i32 0, i32 0
    call i32 (i8*, ...) @printf(i8* %str1)   
    
    ; 读取两个数
    %x = alloca i32
    %y = alloca i32
    call i32 (i8*, ...) @printf(i8* %strx)
    call i32 (i8*, ...) @__isoc99_scanf(i8* %strxInput, i32* %x)    
    call i32 (i8*, ...) @printf(i8* %stry)
    call i32 (i8*, ...) @__isoc99_scanf(i8* %stryInput, i32* %y)
    %x_value = load i32, i32* %x
    %y_value = load i32, i32* %y

    ; Compare x and y with 100
    %x_flag = icmp sgt i32 %x_value, 100
    %y_flag = icmp sgt i32 %y_value, 100


    ; Check if either x or y is bigger than 100
    %condition = or i1 %x_flag, %y_flag

    ; If condition is true, exit the loop
    br i1 %condition, label %bigger_error, label %continue_loop

  bigger_error:
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.biggerstr, i32 0, i32 0))
    br label %end_label

  continue_loop:

    %str2= getelementptr inbounds [30 x i8], [30 x i8]* @.str2, i32 0, i32 0
    %str2Input= getelementptr inbounds [3 x i8], [3 x i8]* @.Input, i32 0, i32 0

    ; 控制数
    call i32 (i8*, ...) @printf(i8* %str2)
    %control = alloca i32
    call i32 (i8*, ...) @__isoc99_scanf(i8* %str2Input, i32* %control)

    %control_value = load i32, i32* %control

    ; 初始化结果
    %result = alloca i32
    store i32 0, i32* %result

    switch i32 %control_value, label %default_case [
        i32 1, label %case_add
        i32 2, label %case_sub
        i32 3, label %case_mul
        i32 4, label %case_div
    ]

  case_add:
    %add_result = call i32 @add(i32 %x_value, i32 %y_value)
    store i32 %add_result, i32* %result
    br label %result_label

  case_sub:
    %sub_result = call i32 @sub(i32 %x_value, i32 %y_value)
    store i32 %sub_result, i32* %result
    br label %result_label

  case_mul:
    %mul_result = call i32 @mul(i32 %x_value, i32 %y_value)
    store i32 %mul_result, i32* %result
    br label %result_label

  case_div:
    %div_result = call i32 @div(i32 %x_value, i32 %y_value)
    store i32 %div_result, i32* %result
    br label %result_label
    
  default_case:
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.defaultstr, i32 0, i32 0))
    br label %end_label

  result_label:
    %result_value = load i32, i32* %result
    %output_str = getelementptr inbounds [43 x i8], [43 x i8]* @.outputstr, i32 0, i32 0
    call i32 (i8*, ...) @printf(i8* %output_str, i32 %x_value, i32 %y_value, i32 %control_value, i32 %result_value)
    br label %loop

  end_label:
    ret i32 0
}