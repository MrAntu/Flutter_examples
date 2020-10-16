# 编译framework流程和指令

#### 由于Flutter.framework打包出来过大，无法上传。需要执行下述步骤才能运行
1. 进入到flutter_module中直线下面指令，生成framework

~~~
flutter build ios-framework --output=some/path/MyApp/Flutter/
~~~

2. 创建本地pod, 将framework集成到项目中使用， 切记：模拟器只能运行debug或profile编译产出的framework， 真机只能运行release编译出来的framework.

