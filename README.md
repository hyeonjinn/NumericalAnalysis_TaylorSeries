# Taylor Series
 
 함수 y=f(x)가 x=a에서 한없이 미분가능한 경우, Taylor 다항식을 차수에 무관하게 계속해서 구할 수 있습니다. 따라서 아래와 같은 무한급수를 얻는데, 이를 x=a에서 함수 y=f(x)의 Taylor Series라고 합니다.



### example
f(x)=cosx인 Taylor Series를 이용하여 x가 0 ~ pi/2에 대해 cos 파형을 나타내는 함수를 작성하시오.

  - 파일 이름은 cos_Taylor.m이며 cos_Taylor 함수의 input variables는 아래 3개를 입력받을 것
    (x = [0 ; 0.06 ; pi/2],
    a = pi/4,
    n = 4)
  - factorial 계산은 built-in 함수 factorial()로 처리할 것



### cos_Taylor.m
cos_Taylor.m은 matlab으로 작성한 파일입니다.



```sh
function cos_Taylor(x, a, n)

y = ones(size(x));

for i = 1 : length(x)
    y(i) = cos(a);
    
    for j = 1 : n
        value = ( diff(j, a) * (x(i) - a)^j )/factorial(j);
        y(i) = y(i) + value;
    end
end

plot(x, y, 'r:o','LineWidth',5)
end
```




```sh
function k = diff(n, b)

    switch mod(n, 4)
        case 0
            k = cos(b);
        case 1
            k = (-1) * sin(b);
        case 2
            k = (-1) * cos(b);
        case 3 
            k = sin(b);
    end
end
```
cos을 계속해서 미분해보면 cos, -sin, -cos, sin 4가지의 경우가 반복되는 것을 알 수 있습니다. 
따라서 diff함수는 cos함수를 n차 미분한 값을 구하는 함수이며, 미분하는 차수를 4로 나눈 나머지에 따라 그 값이 반복되도록 구현하였습니다.


[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [dill]: <https://github.com/joemccann/dillinger>
   [git-repo-url]: <https://github.com/joemccann/dillinger.git>
   [john gruber]: <http://daringfireball.net>
   [df1]: <http://daringfireball.net/projects/markdown/>
   [markdown-it]: <https://github.com/markdown-it/markdown-it>
   [Ace Editor]: <http://ace.ajax.org>
   [node.js]: <http://nodejs.org>
   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [jQuery]: <http://jquery.com>
   [@tjholowaychuk]: <http://twitter.com/tjholowaychuk>
   [express]: <http://expressjs.com>
   [AngularJS]: <http://angularjs.org>
   [Gulp]: <http://gulpjs.com>

   [PlDb]: <https://github.com/joemccann/dillinger/tree/master/plugins/dropbox/README.md>
   [PlGh]: <https://github.com/joemccann/dillinger/tree/master/plugins/github/README.md>
   [PlGd]: <https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md>
   [PlOd]: <https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md>
   [PlMe]: <https://github.com/joemccann/dillinger/tree/master/plugins/medium/README.md>
   [PlGa]: <https://github.com/RahulHP/dillinger/blob/master/plugins/googleanalytics/README.md>
