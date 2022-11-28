# R 시작하기

print("hellow, World!")
print("Welcome")

print("hello, World!"); print("Welcome")

# print("hello, World!"); print("Welcome")

print("Welcome"); 1+1
print("Welcome"); # 1+1

print("Welcome") # print()는 ()의 결과를 출력하는 함수구나....!!

help(print)
?print
?sum
?max
?min
?mean

example(sum)

install.packages("rootSolve")
update.packages("rootSolve")
library(rootSolve)

??ggplot2

# object : 메모리에 올라가는 모든 것

# 데이터 타입

# 변수이름 규칙
a <- 1
A <- 2   # a와 A는 서로 다른 변수임. 즉, R에서는 대/소문자를 구분함.
b <- c(3,4)
a1 <- c(1:10)
b.1 <- rep(3,5)

# 변수이름 규칙에 어긋나는 상황들
2a <- 3
.2 <- c(9,6)
a-b <- 3

# 변수값 할당 연산자 <-, =
x <- c(1,2,3)
y = c(4,5,6)

sum(x)
sum(y)

mean(x.1 <- c(1,2,3))
x.1

ls() # 메모리에 생성된 모든 객체를 보는 함수

rm(a)  # 객체 a를 메모리에서 지워라.
rm(b,x)
rm(list=ls())  # 모두 지워라.

# 스칼라 : 1차원 값
a <- 3
b <- 4.5
c <- 3/5
print(a)
a

english <- 80
math <- 90
korean <- NA    # NA는 대문자이어야 함. NA는 Not Availalbe의 약자임

is.na(english)
is.na(math)
is.na(korean)

science <- NULL
is.null(science)    #  NULL은 대문자이어야 함. NA와 NULL의 차이를 알아두어야함
science <- 70

d <- "hello"
e <- 'hello'
print(d)
e
nchar(d)
f <- substr(d, 1, 3)
g <- substr(d, 4, nchar(d))
paste(f, g, sep=" T.T ")
paste(f, g, sep="")
paste(f, g, "World!", sep="")

a*2+b-c/a
17 %% 5
17 %/% 5

h <- "1"    #    f라는 객체에 "1"이라는 문자를 할당
h+1       #    문자 더하기 숫자는 에러

1+1
"1"+1

# 논리 값 (logic)
T 
TRUE    #  TRUE는 숫자로 표현하면 1, FALSE는 0임
true

F
FALSE

TRUE*TRUE
T*F
F*F

1 > 2
1 == 5/5
3 != 6/2
!T == F

T <- 5; F <- 7    # 에러가 발생하지는 않지만, 되도록이면 이러한 표현은 삼가한다.
rm(T, F)

# 논리 연산
TRUE && TRUE          # &&는 AND 연산자라고 부름
(1 < 2) && (1 < 3)

TRUE && FALSE
(1 < 2) && (1 > 3)

FALSE && FALSE
(1 > 2) && (1 > 3)

TRUE || TRUE          # ||는 OR 연산자라고 부름
(1 < 2) || (1 < 3)

TRUE && FALSE
(1 < 2) || (1 > 3)

FALSE || FALSE
(1 > 2) || (1 > 3)

is.na(korean) || d!="hello"

TRUE && FALSE || FALSE
TRUE || FALSE && FALSE         # &&가 || 보다 우선권을 가짐!!

(TRUE || FALSE) && FALSE         # 괄호를 먼저 계산함!!
((1 < 2) || (1 > 3)) && is.na(english)

TRUE && TRUE || FALSE && FALSE
TRUE && (TRUE || FALSE) && FALSE


# 요소 값 (Factor)
James.gender <- factor("m", c("m", "f"))
Judy.gender <- factor("f", c("m", "f"))

nlevels(James.gender)
levels(Judy.gender)

James.grade <- factor("1", c("1", "2", "3", "4"))
Judy.grade <- factor("2", c("1", "2", "3", "4"))

James.grade + Judy.grade   #  에러. Why? 각 객체가 숫자가 아님

levels(James.grade) <- c("freshmen", "sophomore", "junior", "senior")
James.grade
Judy.grade


# 벡터 : 스칼라 또는 문자를 모아놓은 것

v <- c(1, 3, 5, 6)    # 벡터를 생성하기 위해서는 c()를 사용함
w <- c("a", "b", "c", "d")

names(v) <- w    # names()는 벡터의 각 요소에 이름을 생성
v
names(v) <- NULL
v
names(v) <- c("a", "b", "c")
v
names(v) <- NULL


# 벡터의 접근
v <- c(4,5,23,5,6,7,8,9,4,2)
v[1]
v[-1]
v[2:4]
v[-(2:4)]
v[c(5,7)]
v[-c(5,7)]
v[5,7]
v[v > 7]
length(v)
v[length(v)-2]
max(v)
min(v)
which.max(v)
v[which.max(v)] == max(v)

# 벡터의 연산
u <- c(1, 2, 3, 4, 5)
w <- c(1, 4, 6, 9, 11)

u + w
u + 1
w - u
10 - w
u + c(1,2,7)    # recyling rule in R

7 * u
u * w   # 각 요소끼리 곱
u %*% w   # 벡터 내적(inner product)
w/10
10/w
u/w

sum(u)     # 합
mean(u)    # 평균
var(u)     # 분산
sqrt(var(u))     # 표준편차
sd(u)

identical(u,w)   # 전체를 비교
u == w             # 벡터 각 요소별로 비교
all(u == w)      # identical(u,w)와 같은 결과임, all(u == w)라고 쓰기를 권장함

intersect(u,w)    # 교집합
union(u,w)        # 합집합
setdiff(u,w)      # 차집합
setdiff(w,u)

4 %in% u    # 4가 벡터 u의 요소인지 판별

(4 %in% u) && (4 %in% w)  # 4가 벡터 u와 벡터 w의 요소인가?
4 %in% intersect(u,w)

# 2가 벡터 u의 요소이고, 벡터 w의 요소는 아닌가?


# 벡터 쉽게 생성하기
rm(list=ls())

u <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)
w <- c(1:20)
w <- 1:20      # 20:0, 20:-10, 1:1
all(u == w)

x <- seq(1, 10)
y <- seq(1, 10, by = 0.5)
z <- seq(10, 0, by = -0.5)
y.1 <- seq(1, 12, 5)
y.2 <- seq(1, 12, length.out = 10)

z.1 <- rep(2, 5)
z.2 <- rep(seq(1,3), times=3)
z.3 <- rep(seq(1,3), each=3)
z.4 <- rep(seq(1,3), each=3, times=2)

append(c(1,2), c(3,4))
c(c(1,2),c(3,4))
c(c(1,2),c("3","4"))

# 1에서 부터 10까지 공차가 1인 수열중에서 5보다 작고 8보다 큰 벡터를 만드시오.
x[x < 5]
x[x > 8]
append(x[x < 5], x[x > 8])

# 1에서 부터 10968까지 자연수 중에서, 3의 배수인 수들의 평균과 표준편차를 구하시오.
n <- seq(1:10968)
m <- n[(n %% 3)==0]
mean(m)
sqrt(var(m))

# 리스트 : 스칼라 또는 문자를 혼합해서 모아놓은 것

James.info <- list(name="James", height=188, weight=80, hometown="Seoul")
Judy.info <- list(name="Judy", height=165, weight=51, hometown="Seoul")

James.info
Judy.info

James.info$name
James.info$height
James.info$weight
James.info$hometown

James.info[1]
James.info$hometown == Judy.info$hometown

# 리스트 중첩
James.score <- list(exam = list(mid=90, final=80, grading="B+"))
Judy.score <- list(exam = list(mid=95, final=90, grading="A0"))

James <- append(James.info, James.score)
Judy <- append(Judy.info, Judy.score)

James$exam$mid
James$exam$final

James.points <- James$exam$mid + James$exam$final  #  90+80=170
Judy.points <-Judy$exam$mid + Judy$exam$final      #  95+90=185

# James와 Judy 중 시험점수 합계(중간+기말)가 높은 사람은 누구인가?
c("James","Judy")[which.max(c(James.points,Judy.points))]

# 행렬 만들기
rm(list=ls())

m <- matrix(c(1:8), nrow = 2)
m.1 <- matrix(c(1:8), ncol = 2)

m.2 <- matrix(c(1:8), nrow = 2, byrow=T)
m.3 <- matrix(c(1:8), ncol = 2, byrow=T)

m.4 <- matrix(c(1:10), nrow=4)   # recycling rule
m.5 <- matrix(c(1:10), nrow=4, byrow=T)
m.6 <- matrix(c(1:10), nrow=4, ncol=2, byrow=T)

m.8 <- matrix(, nrow=4, ncol=4)  # null matrix
I <- diag(4)                   # identity matrix (단위행렬)
J <- diag(3,4)                # 대각선 요소가 3인 4x4 대각행렬

# 벡터를 이용한 행렬 만들기
m <- rbind(c(1,5,6), c(8,4,78))
m <- rbind(m, c(2,87,5))

n <- cbind(c(1,5,6), c(8,4,78)) # 옆에다 붙힌다.
n <- cbind(n, c(2,87,5))

rbind(m,n)
cbind(n,m)

# 행렬 데이터 접근
m <- matrix(seq(1:16), nrow = 4, byrow=T)
m[2, 3]
m[-2, 3]
m[2,- 3]
m[2:3, 1]
m[2:3,-1]
m[-(2:3), 3:4]
m[2,] #2번째 행을 다 가져온다
m[,2]#두번째 열을 가져온다
m[-2,]#두번째 행을 제외하고 다 가져온다
m[,-2]
m[m <= 5]#열방향으로 찾으며 요소보다 작은값 출력

# m행렬 요소중 5 이하인 요소는 몇개인가?
length(m[m <= 5])

max(m)
which(m >= 10, arr.ind = TRUE) #조건을 만족하는 값들의 행과 열의 값을 반환

# m행렬 요소중 가장 큰 수자는 몇번째 요소인가? (행번호 및 열번호)
which(m == max(m), arr.ind = TRUE)

m[1,2] <- 7
m[1,2:3] <- c(100,200)

# 행렬 연산

m <- matrix(c(1:4), byrow=T, ncol=2)
n <- matrix(c(1,1,0,1), byrow=T, ncol=2)

m + n
m - n
m * n   # 각 요소끼리 곱
m %*% n   # 행렬의 곱 (내적)
n/m   # 각 요소끼리 나누기

nrow(m)
ncol(m)
rowSums(m)     # 행 합
rowMeans(m)    # 행 평균
colSums(m)     # 열 합
colMeans(m)    # 열 평균

t(m)   # t() 전치행렬(transpose matrix)를 구함
solve(m)   # solve() 역행렬을 구함

m %*% solve(m)
solve(2)

dim(m)   # 행렬의 차원

# 데이터 프레임
df <- data.frame(name = c("James", "Judy", "Donald"),
                 gender = c("M","F", "M"),
                 hometown = c("Seoul", "Samcheok", "New York"),
                 mid = c(90, 95, 60),
                 final = c(80, 90, 50),
                 grades = c("B+", "A0", "F"), stringsAsFactors = FALSE)
df
View(df)
str(df)
names(df)
names(df)[1] <- "First name"
df

df$name
df$grades[2]

# 데이터 프레임에 기존에 없던 열 추가
hw <- c(100, 90, 70)
df$homework <- hw
df

# 데이터 프레임 접근
df$final[2] <- 95
df.1 <- df[c(1,3), ]
df.2 <- df[, c("First name", "mid", "final", "homework", "grades")]
df.3 <- df[, -c(2:3)]

df.2 == df.3

df.2[2 ,c("First name","grades")]
df.2[2 ,c(1,5)]

# df에 각 학생의 중간/기말 성적의 평균을 나타내는 열을 추가하라. 열의 이름은 avg로 하시오.
df$avg <- rowMeans(df[, c("mid", "final")])

# 데이터 프레임 합치기
rm(list=ls())
df.1 <- data.frame(name = c("James", "Judy", "Donald"),
                   gender = c("M","F", "M"),
                   hometown = c("Seoul", "Samcheok", "New York"),
                   mid = c(90, 95, 60),
                   final = c(80, 90, 50),
                   grades = c("B+", "A0", "F"), stringsAsFactors = FALSE)
df.2 <- data.frame(name = c("Lee", "Emma"),
                   gender = c("M","F"),
                   hometown = c("Seoul", "LA"),
                   mid = c(70, 95),
                   final = c(75, 78),
                   grades = c("C+", "B+"), stringsAsFactors = FALSE)

df.3 <- rbind.data.frame(df.1, df.2)
df.3 <- rbind.data.frame(df.3, df.3)

head(df.3)
head(df.3, 3) # 위에서부터 해당 번호까지만 본다

tail(df.3)
tail(df.3, 4) # 아래서부 해당 개수만큼 본다

# 타입 판별
a <- c(1,2,3,4,5)
class(a)
LETTERS
letters
is.numeric(a)
is.factor(a)
is.character(a)
is.matrix(a)

class(df.3)
is.data.frame(df.3)

# 타입 변환
x <- c("a", "b", "c")
class(x)

x <- as.factor(x)
x
class(x)

x <- as.character(x)
x

m <- matrix(c(1:9), ncol=3)
m
class(m)

m <- as.data.frame(m)
m

m <- as.matrix(m)
m
colnames(m) <- NULL
m

df.3
str(df.3)
df.3$gender <- as.factor(df.3$gender)
str(df.3)

df.3$gender <- as.character(df.3$gender)
str(df.3)

# 메모리 효율적으로 쓰기
x <- rnorm(50000000)
gc()

