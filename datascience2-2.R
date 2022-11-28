# 조건문
if(1 == 2/2) {
  print("true")
  print("Hello World!")
} else {
  print("false")
  print("welcome")
}

if(1 == 3/2) {
  print("true")
  print("Hello World!")
} else {
  print("false")
  print("welcome")
}

x <- "1"
if(is.numeric(x)) {
  print(x + 1)
} else if(is.factor(x)){
  print(as.numeric(x) + 2)
} else {
  print(as.numeric(x) + 3)
}

# else 와 else if 는 선택사항.(즉, 필요할 때만 씀)
if(is.numeric(x)) {
  print(x + 1)
}

if(is.numeric(x)) print(x + 1)

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

df <- rbind.data.frame(df.1, df.2)
str(df)
rm(df.1, df.2); gc()

# 세번째 학생이 남자면 그 학생의 기말시험 점수를 알고 싶다.
if(df$gender[3]=="M") print(df$final[3])

# 두번째 학생의 고향이 서울이면 그 학생의 기말시험 점수를 알고 싶다.
# 그렇지 않으면 그 학생의 중간시험과 기말시험 점수와 평균을를 출력하고 싶다.
if(df$hometown[2]=="Seoul") {
  print(df$final[2])
} else {
  df.exam <- df[2, c("mid", "final")]
  df.exam$avg <- rowMeans(df.exam)
  print(df.exam)
}

# 두번째 학생의 기말시험 점수가 6점 올랐다.
# 성적평가 정책상 중간/기말 평균이 95점 이상이면 A+를 준다.
# df를 수정하라.
df
df[2,"final"] <- df[2,"final"] + 6
df
exam.avg.2 <- rowMeans(df[2,c("mid","final")])
if(exam.avg.2 > 95) df[2,"grades"] <- "A+"
df

# ifelse 조건문
x <- c(1:6)
ifelse(x %% 2 != 0, "odd", "even")

# gender 컬럼이 팩터형이 아니면, 팩터형으로 변환하라.
str(df)
ifelse(is.factor(df$gender), Sys.sleep(0), df$gender <- as.factor(df$gender))
str(df)

# 반복문 (for, while, repeat)
for(i in 1:10) {
  print(i)
}

i <- 1
while(i <= 10) {
  print(i)
  i <- i + 1
}

i <- 1
repeat {
  print(i)
  if(i < 10) {
    i <- i + 1
  } else break
}

# 350 부터 489500 까지 자연수 중 7의 배수를 모두 구하라.

for(i in 350:489500) {
  if(i %% 7 == 0) print(i)
}

x <- 350:489500
x[x %% 7 == 0]

system.time(
  for(i in 350:489500) {
    if(i %% 7 == 0) print(i)
  }
)

system.time(print(x[x %% 7 == 0]))
rm(x); gc()

# 되도록 이면 반복문은 피할 것! 어쩔 수 없이 사용해야 된다면 그때 사용할 것!

# 1 부터 12 까지 자연수 중 3의 배수의 평균을 구하라.
x <- rep(0, 12)
for(i in 1:12) {
  if(i %% 3 == 0) x[i] <- i
}
x <- x[x != 0]
mean(x)

x <- 1:12
x <- x[x %% 3 == 0]
mean(x)

# 수학연산
# 사칙연산 모두 가능 (+, -, *, /)
# n %% m  => n을 m으로 나눈 나머지
# n %/% m  => n을 m으로 나눈 몫
# n^m  => n의 m제곱
# exp(n)  => 자연대수 e의 n제곱
# log(n, base=n)  => 밑이 n인 로그, 만약 base를 지정하지 않으면 밑이 e인 자연로그
log(9, 3)
log(9)
log(9, exp(1))
log(exp(1))

# log2(n)  => 밑이 2인 로그
log2(4)

# log10(n)  => 상용 로그
log10(1000)
pi
# sin(x), cos(x), tan(x)
sin(pi/2); cos(2*pi); tan(pi/4)

# 괄호 연산
1:5*2+1 # 1 부터 5까지 2를 곱하여 1을 더함
1:(5*2)+1 # 1부터 10까지 1을 더함
1:(5*2+1)#1부터 11까지
1:5*(2+1) # 1부터 5까지 3을 곱함
x <- exp(1:5*(2+1))
log(x)

x <- append(seq(1, 100, 3), seq(1, 100, 4))
x
table(x)
sum(x); mean(x); var(x); median(x)

# NA(Not Available) 처리
NA && TRUE
NA + 1
x <- c(1, 2, 3, NA)

if(NA %in% x){
  sum(x, na.rm = TRUE)
}

sum(x)
sum(x, na.rm = TRUE)
mean(x, na.rm = TRUE)
var(x, na.rm = TRUE)
median(x, na.rm = TRUE)
x <- as.numeric(na.omit(x))
x
class(x)
############################################################################
# 함수 (매우 중요!!)
############################################################################
rm(list=ls())

# f(x) = x + 1 을 고려해보자.
f <- function(x) {
  y <- x + 1          # y라는 객체는 f라는 함수에만 정의. 메모리에 생성되지 않음
  return(y)
}
f(1)

g <- function(x) return(x^2)
g(4)

# h(x) = x + y 을 고려해보자. x와 y를 출력하고, x+y와 x-y를 반화하는 함수를 만들어라.
h <- function(x, y) {
  print(paste("x =",x))
  print(paste("y =",y))
  print(paste("x + y =",x+y))
  print(paste("x - y =",x-y))
}
h(10,10)

j <- function(x, y, z=1) x+y+z     # 인자 지정 전달 (z=1)
j(2, 3)
j(2, 3, 7)
j(2, 4)

j1 <- function(x, y, z=-x-y) x+y+z     # 인자 지정 전달 (z=-x-y)
j1(464, 18)

j2 <- function() sum(1:100)
j2()

# d라는 함수는 3차원 좌표평면의 어느 점에서 원점까지 거리를 계산하는 함수이다.
# d라는 함수를 구현하고, 원점에서 부터 점(3,4,5)의 거리를 구하라. (HW)
d <- function(x, y, z) {
  Length = sqrt(sqrt(x^2+y^2)^2 + z^2)
  print(Length)
}
d (3,4,5)
# 이름, 고향, 중간, 기말을 입력받아 기말/중간 평균 점수가 60점 이상이면 Pass,
# 이하이면 Fail을 반환하는 함수를 만들어라. (HW)
PassOrFail <- function(name, hometown, mid, final) {
  score = mean(mid, final)
  if (score >= 60) 
    return ('Pass')
  else 
    return ('Fail')
}
value = PassOrFail("공동준", "서울", 59.99999999999999, 60)
print(value)
# 중첩함수
f <- function(x, y) {
  x <- x + 5
  g <- function(y, z = 7) return(y + z)
  return(c(x, g(y)))
}
f(15, 3)

# 스코프
n <- 100             # 전역변수 n 선언
f <- function() {
  print(n)
}
f()

f.1 <- function() {
  n <- 1             # 지역변수 n 선언
  print(n)        
}
f.1()               # 함수내부의 지역변수 n이 전역변수 n보다 우선한다.

f.2 <- function(n) {
  print(n)        
}
f.2(1)               # 함수인자의 변수명 n이 전역변수 n보다 우선한다.

f.3 <- function(x) {
  a <- 2
  g <- function(y) {
    print(y + a)
  }
  g(x)
}
f.3(1)