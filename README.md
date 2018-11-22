# Taylor Series
 
 함수 y=f(x)가 x=a에서 한없이 미분가능한 경우, Taylor 다항식을 차수에 무관하게 계속해서 구할 수 있습니다. 따라서 아래와 같은 무한급수를 얻는데, 이를 x=a에서 함수 y=f(x)의 Taylor Series라고 합니다.



### example
f(x)=cosx인 Taylor Series를 이용하여 x가 0 ~ pi/2에 대해 cos 파형을 나타내는 함수를 작성하시오.
power method로 대칭 행렬의 가장 큰 eigenvalue와 가장 작은 eigenvalue를 구하고, 그에 따른 eigenvector를 구하시오.
  - 파일 이름은 power.m이며 power 함수의 input variables는 아래 3개를 입력받을 것
A = [ 40, -20, 0 ; -20, 40, -20 ; 0, -20, 40]
es = 0.05
maxit = 100 
  - 행렬 A가 square matrix인지, 만약 square matrix라면 symmetric인지 확인하는 코드를 넣을 것
  - 가장 큰 eigenvalue를 선택할 것인지, 가장 작은 eigenvalue를 선택할 것인지에 따라 eigenvalue와 그에 따른 eigenvector를 나타낼 것



### power.m
power.m은 matlab으로 작성한 파일입니다.

```sh
[row, col] = size(A);
```
우선 power함수의 input으로 받은 행렬 A의 행의 개수와 열의 개수를 row와 col에 저장을 합니다. 예를 들어, 행렬 A가 3X3으로 주어진다면 row와 col의 값은 3이 됩니다.

```sh
 if row == col   %square matrix이면
     %symmetry matrix인지 테스트
       for i = 1 : row
           for j = 1 : row
               if A(i,j) == A(j,i)
                   check = check * 1;
               else 
                   check = check * 0;
               end
           end
       end
       
    if check == 1 % sqaure matrix 이면서 symmetric matrix 이면
       //power method 구현
    else 
        error('행렬 A는 symmetric matrix만 가능합니다.')
    end
 
   else
      error('행렬 A는 square matrix만 가능합니다.')
   end
end
```

power method는 square이면서 symmetric인 행렬인 경우에만 사용할 수 있습니다. 그렇기 때문에 input으로 주어진 행렬 A가 square이면서 symmetric인지 먼저 확인하고 맞다면 power method 풀이를 적용하여 eigenvalue와 eigenvector를 구해야합니다. 우선, 행렬 A가 square( row==col )인지 아닌지를 확인하고 만약 square라면 symmetric( A(i,j) == A(j,i) )인지 아닌지를 확인합니다. square가 아니거나 symmetric이 아닌 경우에는 error()함수를 사용하여 오류메시지를 띄우고 프로그램을 종료합니다.

```sh
value = input('가장 큰 eigenvalue는 1을, 가장 작은 eigenvalue는 2를 선택하세요: ');
```
input()함수를 사용하여 사용자로부터 입력을 받고 그에 따라 해당되는 기능을 수행합니다.

```sh
if value == 1  % 가장 큰 eigenvalue 선택한 경우
    yold = ones(row,1);
    eig_valold = 0;
    while(1)
        y = A * yold;
        eig_val = y(1); 
        for k = 1: row
            if abs(eig_val) < abs(y(k)) 
               eig_val = y(k);
            end
        end 
        eig_vec = y / eig_val;

        iter = iter + 1;
        ea = abs((eig_val - eig_valold)/eig_val) *100;
            
        eig_valold = eig_val; % 다음 iter를 위해 현재 eig_val를 저장
        yold = eig_vec; % 다음 iter를 위해 현재 eig_vec를 저장
        
        if ea <= es || iter >= maxit, break, end 
    end
```
power method에서 가장 먼저, 즉 first iteration에서는 yold = [1; 1; 1]에서 부터 시작합니다. y는 주어진 행렬 A과 yold 행렬을 곱해서 나온 결과 값입니다. y 행렬에서 절댓값이 가장 큰 eig_val(= eigenvalue)를 찾고, y 행렬을 eig_val(=eigenvalue)로 나눠주면 eig_vec(= eigenvector)를 구할 수 있습니다. 
iter는 반복횟수를 나타내며, 매 반복마다 count를 하여 maxit을 초과하는지 확인합니다. ea는 근사상대오차를 나타내며, 매 반복마다 근사상대오차 ea가 허용오차 es를 초과하는지 확인합니다. 근사상대오차가 허용오차보다 작아지거나 반복횟수가 maxit을 초과하면 반복이 종료되고 eigenvalue와 eigenvector가 구해집니다.

```sh
elseif value == 0 % 가장 작은 eigenvalue 선택한 경우
    yold = ones(row,1);
    eig_valold = 0;
    while(1)
        y = inv(A) * yold; % A의 역행렬을 곱해준다.
        eig_val = y(1); 
        for k = 1: row
            if abs(eig_val) < abs(y(k)) 
                eig_val = y(k);
            end
        end 
        eig_vec = y / eig_val;

        iter = iter + 1;
        ea = abs((eig_val - eig_valold)/eig_val) *100;
            
        eig_valold = eig_val; 
        yold = eig_vec; 
        eig_val = 1/ eig_val; % 역수를 취해서 eig_val값 구한다.
        
        if ea <= es || iter >= maxit, break, end 
end   
 
```
가장 작은 eigenvalue를 구할 때는, 행렬 A의 역행렬을 적용하면 가장 큰 eigenvalue 1/λ에 수렴하게되므로 가장 작은 eigenvalue λ를 구할 수 있습니다.
따라서, 가장 큰 eigenvalue를 구하는 코드에서 y = A * yold를 y = inv(A) * yold로 변형하고, 최종적으로 eigenvalue를 구한 것에서 eig_val = 1/ eig_val를 추가하여 역수를 취해주면됩니다.

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
