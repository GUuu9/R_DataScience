f <- function(x) 3*x^2

# 함수 f(x)를 0에서 부터 1까지 적분해라.
integrate(f, 0, 1)
integrate(f, 0, 1)$value
(f %>% integrate(0,1))$value


library(dplyr)
# 함수 f(x)를 x에 대해서 미분해라.
install.packages("Deriv")
library(Deriv)
Deriv(f,"x")
Deriv(function(x) sin(x), "x")
f %>% Deriv("x")

# 함수 g(x,y)=2*x^3+log(y)를 y에 대해서 편미분해라.
g <- function(x,y) 2*x^3+log(y)
Deriv(g,"y")
g %>% Deriv("x")

# 확률변수 X ~ Bin(5, 0.4) 이다. E[X]를 구하라.
Pr <- function(x) choose(5,x)*0.4^x*(1-0.4)^(5-x)
x <- 0:5
Pr(x) %>% sum
(x*Pr(x)) %>% sum

sum(x*dbinom(x,5,0.4))

# 고급 파이프
# install.packages("magrittr")
library(magrittr)
iris
iris <- iris

head(iris,10)
iris %>% head
str(iris)

faithful <- faithful
faithful %>% str

# old faithful 간헐천의 분출시간의 평균은?
mean(faithful$eruptions)
faithful %$% mean(eruptions) # %$% exposition pipe
faithful$eruptions %>% mean(.)
faithful$eruptions %>% mean

# old faithful 간헐천의 분출주기의 표준편차는?
sd(faithful$waiting)
faithful %$% sd(waiting)

# %<>% assignmentPipe 교체후 삽입
faithful$eruptions
x <- 1:10
x <- x %>% as.character
x %<>% as.character

1:10 %>% plot
1:10 %T>% plot %>% mean()

# working directory 지정
getwd() # 현재 작업 위치 확인
setwd("작업공간 주소")   # 작업 위치 수정
source("Rtest") # run code

# 메모리상의 데이터프레임 객체를 csv파일로 워킹 디렉토리에 저장하기
write.csv(faithful, "faithful.csv", row.names = F)

# 현재 메모리상에 있는 iris라는 데이터 프레임 객체를 워킹 디렉토리에 iris1.csv로 저장하시오.
iris %>% write.csv("iris1.csv", row.names = F)

rm(list=ls())
# 현재 워킹 디렉토리에 있는 iris1.csv라는 파일을 메모리에 올리기
irisdf <- read.csv("iris1.csv", header = T) # F로 설정시 헤더를 변수로 취급
str(irisdf)

irisdf1 <- read.csv("iris1.csv", header = F)
irisdf2 <- read.csv("iris1.csv", header = T, stringsAsFactors = T)
str(irisdf2)

class(irisdf$Species) == class(irisdf2$Species)

# irisdf2의 Species 필드를 factor형으로 바꾸시오.
# irisdf2$Species <- as.factor(irisdf2$Species)
irisdf2$Species %<>% as.factor
str(irisdf2)

# 객체의 저장
x <- 1:100
y <- 101:200 %>% as.character
f <- function(x) log(x)

save(x, y, f, file="xyf.RData") #해당 파일로 객체를 저장
rm(x,y,f)
load("xyf.RData") # 객체 불러오기

# apply 계열 함수
rm(list=ls()); gc()

m <- 1:11 %>% matrix(ncol=4, byrow = T)
m

# 행렬 m의 행평균을 구하라.
rowMeans(m)
apply(m, 1, mean) # 벡터 형태로 결과를 반환

1:11 %>%
  matrix(ncol=3, byrow = T) %>%
  apply(1, which.min) %>% 
  max

f1 <- function(x) sum(x)^0

m %>%
  apply(1, f1) %>% 
  max

# 행렬 m의 열합을 구하라.
colSums(m)
apply(m, 2, sum)
m %>%
  rbind(m) %>% 
  dim %>%
  matrix(ncol=2) %>%
  cbind(.,.) %>% 
  apply(2, function(x) x+1) %>% 
  as.character %>% 
  length

# 행렬 m의 열분산을 구하라.
apply(m, 2, var)

# 행렬 m에서 각 행에서 가장 큰 숫자는 몇번째 열인가?
apply(m, 1, which.max)
#iris에서 가장 작은 관측치
iris[,-5] %>%
apply(2, which.min)
# 중앙값
iris[,-5] %>% apply(2, median)

# for 반복문을 이용하여 행렬 m에서 행평균과 열분산을 출력하라.
for(i in 1:2)
  ifelse(i==1,
         m %>% rowMeans %>% print,
         m %>% apply(i,var) %>% print
  )

iris <- iris
# iris 데이터 프레임에서 각 필드평균을 구하라.(단, Species 필드는 제외)
apply(iris[,-5], 2, mean)
colMeans(iris[,-5])


result <- lapply(iris[,-5], mean)
# lapply는 무조건 열로만 처리함!

str(result)
result$Sepal.Length
unlist(result)

lapply(iris[,-5], mean) %>% unlist

tapply(iris$Sepal.Length, iris$Species, mean)
iris %$%
  tapply(Sepal.Length, Species, mean)

# GPA.csv를 읽어들여서 성별로 학점의 분산을 구하라.
getwd()
setwd("/home/uuu9/R")
GPA <- read.csv("GPA.csv",header=T)
GPA %>% tapply(gpa, gender, var)
?tapply
# 데이터 가공
rm(list=ls()); gc()
iris <- iris
summary(iris)

library(dplyr)
select(iris, Sepal.Width, Sepal.Length, Species)
select(iris, c(2,1,5)) %>% head
select(iris, starts_with("Sepal"), 5) %>% head
select(iris, ends_with("Width"), 1) %>% head

iris %>% select(., -Species) %>% head
iris %>% select(-5) %>% head
iris[,-5] %>% head


group_by(iris, Species)
summarise(iris, mean.Sepal.Length = mean(Sepal.Length))
filter(iris, Sepal.Length > 5)

iris %>% 
  select(starts_with("Sepal"), Species) %>%
  filter(Sepal.Length > 5) %>% 
  group_by(Species) %>%
  summarise(Sepal.Length.sd = sd(Sepal.Length),
            Sepal.Width.mean = mean(Sepal.Width),
            Sepal.Length.max = max(Sepal.Length),
            Sepal.Width.min = min(Sepal.Width),
            n = n())

iris %>%
  filter(Sepal.Length > 5) %>% 
  select(starts_with("Sepal"), Species) %>%
  group_by(Species) %>%
  summarise(Sepal.Length.sd = sd(Sepal.Length),
            Sepal.Width.mean = mean(Sepal.Width),
            Sepal.Length.max = max(Sepal.Length),
            Sepal.Width.min = min(Sepal.Width),
            n = n())

iris %>%
  group_by(Species) %>%
  filter(Sepal.Length > 5) %>% 
  select(starts_with("Sepal"), Species) %>%
  summarise(Sepal.Length.sd = sd(Sepal.Length),
            Sepal.Width.mean = mean(Sepal.Width),
            Sepal.Length.max = max(Sepal.Length),
            Sepal.Width.min = min(Sepal.Width),
            n = n())

# GPA.csv에서 성별 최고/최저학점을 구하시오.
GPA <- read.csv("GPA.csv",header=T)
GPA
GPA %>%
  group_by(gender) %>%
  summarise(max = max(gpa),
            min = min(gpa))

?sample(1:10, 5) #비복원 추출
sample(1:10, 5, replace=T) # 복원 추출
set.seed(22); sample(1:10, 5)

iris %>% 
  group_by(Species) %>%
  sample_frac(0.1)

iris %>% 
  group_by(Species) %>%
  sample_n(6)

# GPA.csv에서 성별로 50명씩 무작위로 
# 추출하여 성별로 학점평균과 최저학점을 구하시오.
# 단, seed 값은 1000 이다.
set.seed(1000)
GPA %>%
  group_by(gender) %>%
  sample_n(50) %>%
  summarise(mean = mean(gpa),
            min = min(gpa))

sdf <- split(iris, iris$Species)
iris.se <- sdf$setosa
iris.ve <- sdf$versicolor
iris.vi <- sdf$virginica

# GPA.csv에서 성별로 나누고, 
# 여자와 남자의 데이터 프레임 객체를 생성하시오.
GPA.f <- split(GPA, GPA$gender)$f
GPA.m <- split(GPA, GPA$gender)$m

subset(iris, Species == "setosa")
iris %>% filter(Species == "setosa")

x <- ifelse(rnorm(1000000)>0,"p","n") %>%
  as.factor %>%
  as.data.frame
names(x) <- "v"

system.time(subset(x, v=="p"))
system.time(x %>% filter(v=="p"))

subset(iris, Species == "versicolor") %>% head
iris %>% filter(Species == "versicolor") %>% head

subset(iris, Species == "virginica") %>% head
iris %>% filter(Species == "virginica") %>% head

subset(iris, Species == "setosa" && Sepal.Length > 5) %>% head
iris %>%
  filter(Species == "setosa" && Sepal.Length > 5) %>%
  head

iris %>%
  filter(Species == "setosa" || Sepal.Length > 5) %>%
  head

# iris 데이터프레임에서 Sepal.Length가 5 이상
# 또는 Petal.Width가 2 이하인 데이터를 출력하고,
# 각 종의 갯수를 세시오.
iris %>% filter(Sepal.Length >= 5 || Petal.Width <= 2) %T>% 
  print %>% summarise(n = n())

# table 합치기
df.1 <- data.frame(name = c("James", "Judy", "Donald"),
                   mid = c(90, 95, 60))

df.2 <- data.frame(name = c("James", "Judy", "Donald"),
                   final = c(80, 90, 50))

cbind.data.frame(df.1,df.2)
merge(df.1,df.2)

df.1 <- data.frame(name = c("James", "Judy", "Donald"),
                   mid = c(90, 95, 60))

df.2 <- data.frame(name = c("James", "Judy", "Lee"),
                   final = c(80, 90, 50))
df.1
df.2
merge(df.1, df.2)
merge(df.1, df.2, all=TRUE)

test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))

test2 <- data.frame(id = c(1, 2, 3, 4, 6),
                    final = c(70, 83, 65, 95, 80))

test1
test2

merge(test1, test2, by="id")
inner_join(test1, test2, by="id")

merge(test1, test2, all=T, by="id")
full_join(test1, test2, by="id")

left_join(test1, test2, by="id")
right_join(test1, test2, by="id")

total <- test1 %>% left_join(test2, ., by="id")
total$class <- as.factor(c(1,1,2,2,2))
total %<>% select(c(1,4,2,3))

name <- data.frame(class = as.factor(1:2),
                   prof = c("Lee", "Moon"))

total %>% left_join(name, by="class")

# 숙제
# GPA 데이터에서 성적이 4.1 이상이면 "A등급" 장학금,
# 3.8~4.0 사이이면 "B등급"장학금, 3.5~3.7사이이면 "C등급" 장학금을
# 부여한다. 장학금별 장학금액은 아래의 sch 테이블과 같다.
# join함수를 이용하여 학생별 장학금액을 출력하고,
# 성별로 "A등급", "B등급", "C등급" 이 각각 몇명인지 출력하시오.

##파일 불러오기
GPA <- read.csv("GPA.csv",header=T)
##등급별로 학생 분리
ga <- GPA %>% filter(gpa >= 4.1)
gb <- GPA %>% filter(gpa <= 4.0) %>% filter(gpa >= 3.8)
gc <- GPA %>% filter(gpa <= 3.7) %>% filter(gpa >= 3.5)
gf <- GPA %>% filter(gpa < 3.5)
##분리한 테이블에 점수에 맞는 등급 부여
scholarship <- c("A")
ga <- data.frame(ga, scholarship, stringsAsFactors = FALSE)
scholarship <- c("B")
gb <- data.frame(gb, scholarship, stringsAsFactors = FALSE)
scholarship <- c("C")
gc <- data.frame(gc, scholarship, stringsAsFactors = FALSE)
scholarship <- c("N/A")
gf <- data.frame(gf, scholarship, stringsAsFactors = FALSE)
##장학금 부여 테이블
sch <- data.frame(scholarship = as.factor(c("A","B","C","N/A")),
                  amount = as.character(c(200,100,50,0)))
##분리한 학생 테이블 결합
stud <- rbind(ga, gb, gc, gf)
##scholarship기준으로 완전 조인
stud <- full_join(stud, sch, by="scholarship")
stud

stud %>%
  group_by(scholarship, gender) %>%
  summarise(n = n())


#해설
GPA <- read.csv("GPA.csv", header = T)

sch <- data.frame(scholarship = as.factor(c("A","B","C","N/A")),
                  
                  amount = as.character(c(200,100,50,0)))

scholarship <- function(x) {
  
  if(x >= 4.1) return("A")
  
  if(x >= 3.8 && x <= 4.0) return("B")
  
  if(x >= 3.5 && x <= 3.7) return("C")
  
  else return("N/A")
  
}

GPA$scholarship <-
  
  GPA$gpa %>%
  
  matrix(ncol=1) %>%
  
  apply(1,scholarship) %>%
  
  as.factor

GPA %>%
  
  left_join(sch, by="scholarship") %T>%
  
  print %>%
  
  filter(scholarship != "N/A") %>%
  
  group_by(gender, scholarship) %>%
  
  summarise(n=n())



# 정렬
rm(list=ls()); gc()
x <- c(20, 11, 33, 50, 47)
sort(x)
sort(x, decreasing = TRUE)
order(x)
order(x, decreasing = TRUE)

test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))

test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))

arrange(inner_join(test1, test2, by="id"), midterm)

test1 %>% 
  inner_join(test2, by="id") %>% 
  arrange(desc(final))
