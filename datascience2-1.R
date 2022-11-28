# cat : 출력함수
string1 <- "Hello, World!"
print(string1)
cat(string1)

# print() 는 객체 한개만 출력 가능, cat()은 여러객체 동시에 출력 가능
string2 <- "Welcome!"
print(string1, string2)    # 에러
print(c(string1, string2))
print(paste(string1, string2))  

cat(string1, string2)
cat(string1, string2, "- Prof. Lee")

r1 <- print(paste(string1, string2))  
r2 <- cat(string1, string2)
###########################################################################
# 파이프 %>% 
###########################################################################
f <- function(x) x+1
g <- function(y) y^2
f(g(7))

# 파이프는 생각의 방향과 코딩의 방향을 같게 만들어 주는 기술
# 파이프를 사용하기 위한 패키지 설치
install.packages("dplyr")

library(dplyr)
#  파이프 연산자 : %>%  ( 단축키 command + shift + m )
g(7)
7 %>% g
f(g(7))
7 %>% g %>% f

sum(c(2,4,1))
c(2,4,1) %>% sum
c(2,4,1) %>% sum()
c(2,4,1) %>% sum(.)

mean(rep(777,777))
rep(777,777) %>% sd()
# sd() : 표준 편차
a <- c(6,2,9,1,77,66)
sort(a)
a %>% sort

sort(a, decreasing = T)
a %>% sort(., decreasing = T)
a %>% sort(decreasing = T)
T %>% sort(a, decreasing = .)

m <- matrix(c(1,5,
              5,3), byrow = T, ncol=2)
rowSums(m)
m %>% rowSums

a <- c(6,3,1)
b <- c(0,3,9)

sum(union(a, b))
a %>% union(., b) %>% sum
b %>% union(a, .) %>% sum

a %>% union(b) %>% sum

d <- NULL
is.null(d)
d %>% is.null

f1 <- function(x) x+2
4 %>% f1 %% 3

g1 <- function(y, z) y^3+sqrt(z)

2 %>% g1(., z=16) %>% f1
2 %>% g1(z=16) %>% f1
2 %>% g1(16) %>% f1

2 %>% 
  g1(16) %>%
  f1

4 %>%
  g1(y=3,.) %>%
  f1

4 %>%
  g1(3,.) %>%
  f1

c("2","7") %>% 
  as.numeric %>% 
  sum %>%
  print

c("2","7") %>% 
  sum %>% 
  as.numeric %>%
  print

c(1,2,3,4) %>%
  matrix(ncol=2) %>% 
  rowSums %>% 
  mean

f2 <- function(x, y, z=1) x+y+z
2, 3 %>% f2
c(2, 3) %>% f2
c(2, 3) %>% f2(.,.)
# 함수의 입력이 2개 이상일 경우에는 %>% 를 왠만하면 쓰지 마세요.(권장)

f2 <- function(v, z=1) v[1]+v[2]+z
c(2, 3) %>% f2
c(2, 3) %>% f2(z=8)
c(2, 3) %>% f2(8)
