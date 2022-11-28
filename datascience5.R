#회귀분석(regression analysis)
install.packages('magrittr')
library(dplyr)
library(magrittr)


faithful <- faithful
plot(faithful)
faithful %$% cor(eruptions,waiting)  # Pearson 상관계수(선형관계만 파악)

set.seed(111)
x <- sample(10:90, 250, replace = T)
set.seed(222)
y <- (x-50)^2/10+20+rnorm(length(x),0,10)
xy <- data.frame(x,y)
plot(xy).          # 직선의 유무/ 직선에 가까울수록 1 직선에서 멀수록 0
xy %$% cor(x,y)    # x와 y간 선형관계가 없음 # 비선형은 파악하지 못함.

xy$xprime <- (x-50)^2/10
View(xy)
xy %$% cor(xprime,y)   # x와 y간 비선형관계가 존재
plot(xy$xprime, xy$y)  #xprime과 y사이에는 선형 관계가 존재

# 최소자승법 설명!!!
# 단순 선형회귀 (simple linear regression)


summary(rg1) # 가설 검정
# 회귀계수 검정 설명

rg2 <- lm(y ~ x, data=xy)
rg2 # b1값이 너무 작아 영향을 주지 않는다.
plot(xy[,-3])
abline(rg2, col="red", lwd=3) # 직선이 맞지 않음
mean(xy$y) # y값의 평균
summary(rg2)

rg3 <- lm(y ~ xprime, data=xy)
rg3
plot(xy[,3:2])
abline(rg3, col="red", lwd=3)
summary(rg3)

# (실습 1) iris 데이터에서 종속변수를 Petal.Length로 
# 독립변수를 Petal.Width로 하여
# 1. 단순 선형회귀분석을 수행하라.
# 2. 산점도와 회귀직선을 그려라.
# 3. Petal.Width는 Petal.Length에 대해
#    설명력이 있는지(유의한 변수인지) 검정하시오.


iris <- iris
plot(iris$Petal.Width,
     iris$Petal.Length)

rg4 <- lm(Petal.Length ~ Petal.Width, data = iris) # name <- lm( y ~ x , data )
rg4$residual # 모든 잔차
rg4$coefficients # Beta0 와 Beta1의 계수 확인
abline(rg4, col="red", lwd=3)
summary(rg4)

# 다중 선형회귀(multiple linear regression)
# 설명변수가 2개 이상인 경우의 회귀분석

xy %<>% select(1,3,2)
names(xy)[1:2] <- c("x1","x2")
View(xy)

lm(y ~ x1, data=xy) %>% summary
lm(y ~ x2, data=xy) %>% summary

mrg1 <- lm(y ~ x1 + x2, data=xy)  # 또는 y ~ .
summary(mrg1)
# 모형의 적합도 검정 설명!!!
#install.packages("rgl")
library(car)
scatter3d(y~x1+x2, data=xy, surface=F)
scatter3d(y~x1+x2, data=xy)

# (실습 2) iris 데이터에서 종속변수를 Petal.Length로 
# 독립변수를 Petal.Width, Sepal.Length, Sepal.Width로 하여
# 1. 다중 선형회귀분석을 수행하라.
# 2. 위 회귀모형의 적합도 검정을 수행하라.
# 3. 각 독립변수가 Petal.Length에 대해
#    설명력이 있는지(유의한 변수인지) 검정하시오.

iris <- iris
plot(iris$Petal.Width,
     iris$Petal.Length)

rg <- lm(Petal.Length ~ ., data=iris[,-5])
plot(iris[,-5])
rg$coefficients


# 다항회귀(polynomial regression)
xy %<>% select(1,3)
names(xy) <- c("x","y")
plot(xy)
xy$x.sq <- xy$x^2
prg1 <- lm(y ~ x + x.sq, data=xy)
summary(prg1)

prg1$coefficients
beta0 <- prg1$coefficients[1]
beta1 <- prg1$coefficients[2]
beta2 <- prg1$coefficients[3]
curve(beta0+beta1*x+beta2*x^2, min(xy$x), max(xy$x),
      col="blue", lwd=3, add=T)

# (실습 3) pr3.Rdata를 로딩하시오.
# 종속변수는 y 이다. 다항 회귀분석을 실시하고, 수정설명계수(adjusted R-squared)를 구하시오.
?load
load("pr3.RData")
plot(xy)
xy$rootx <- xy$x %>% sqrt
xy$logx <- xy$x %>% log
xy$sinx <- xy$x %>% sin

View(xy)


# 로지스틱 회귀(logistic regression) (분류 예측)
# 설명변수가 이항 범주형(binomial and categorical type) 자료 일때 사용

set.seed(11)
hours <- c(runif(20,0,6), runif(20,5,9)) %>% round(2)
outcomes <- rep(c("fail","pass"),each=20)
rstudy <- data.frame(hours,outcomes)
rstudy$outcomes.number <- ifelse(rstudy$outcomes=="fail",0,1)
plot(rstudy[,c(1,3)], pch=16, cex=2)

rg4 <- lm(outcomes.number~hours,data=rstudy)
summary(rg4)
abline(rg4,lwd=3,col="red")

#s자 커브 곡선 (glm) 
lrg1 <- glm(outcomes.number~hours, data=rstudy,
            family = "binomial") # 2진분류 : family = "binomial"옵션 추가
summary(lrg1)

coeff <- lrg1$coefficients %>% unname
beta0 <- coeff[1]
beta1 <- coeff[2]
l <- function(x) beta0+beta1*x
pred <- function(x) 1/(1+exp(-l(x)))

curve(pred, min(rstudy$hours), max(rstudy$hours),
      col="blue",lwd=3,add=T)

abline(h = 0.5, lty=3)
abline(v = 6, lty=3, col='red')
pred.pf(6)
abline(h = pred(6), lty=3, col='red')

# 예측치에 대한 결과 반환
pred.pf <- function(hours) ifelse(pred(hours) >= 0.5, "pass", "fail") 
pred.pf(6)
abline(h=0.5,lty=2)



# Pass 를 받기위한 공부시간이 0.5인 시간값 구하기
library(rootSolve)
q0.5 <- uniroot(function(x) pred(x)-0.5,
                c(min(rstudy$hours), max(rstudy$hours)))$root
abline(v=q0.5,lty=3)
text(q0.5,0.2,q0.5 %>% round(3))

# iris 데이터에서 setosa 구분하기
iris <- iris
plot(iris[,-5], col=iris$Species)
plot(iris %>% select(3,1), col=iris$Species,
     pch=16, cex=1)
legend("topleft", legend = levels(iris$Species), 
       col = c(1:3), pch = 16, cex=1)

plot(iris %>% select(4,1), col=iris$Species,
     pch=16, cex=1)
legend("topleft", legend = levels(iris$Species), 
       col = c(1:3), pch = 16, cex=1)

iris$is.setosa <- ifelse(iris$Species=="setosa",1,0)
iris %>%
  select(Petal.Length, is.setosa) %>% 
  plot(col=iris$Species,cex=2,pch=16)
legend("topright", legend = levels(iris$Species), 
       col = c(1:3), cex=2,pch=16)
abline(lm(is.setosa~Petal.Length, data=iris),lwd=3,col="red")

lrg2 <- glm(is.setosa~Petal.Length, data=iris,
            family = "binomial")
summary(lrg2)

coeff <- lrg2$coefficients %>% unname
beta0 <- coeff[1]
beta1 <- coeff[2]
l <- function(x) beta0+beta1*x
pred <- function(x) 1/(1+exp(-l(x)))
curve(pred, min(iris$Petal.Length), max(iris$Petal.Length),
      col="blue",lwd=3,add=T)

pred.setosa <- function(Petal.Length) 
  ifelse(pred(Petal.Length)>0.5, "setosa", "not setosa")
pred.setosa(6)
pred.setosa(2.1)
abline(h=0.5,lty=2)

q0.5 <- uniroot(function(x) pred(x)-0.5, c(2, 3))$root
abline(v=q0.5,lty=4)
text(2.3,0,q0.5 %>% round(3))

plot(iris %>% select(3,1), col=iris$Species,pch=16)
legend("topleft", legend = levels(iris$Species),
       col = c(1:3),pch=16)
abline(v=q0.5,lwd=2)

# (실습 4) Sepal.Length 변수로 setosa를 구별하는
# 1. 로지스틱 회귀모형을 제시하시오. 
# 2. 그림으로 표현하시오.
# 3. 어느 붓꽃이 Sepal.Length가 4.6일때,
#    이 꽃은 setosa인지 예측하시오.

# 다중 로지스틱 회귀(multiple logistic regression)
rm(list=ls()); gc(); dev.off()
iris <- iris
plot(iris[,-5], col=iris$Species, pch=16)
iris$is.virginica <- ifelse(iris$Species=="virginica",1,0)
plot(iris %>% select(starts_with("Petal")),
     col=iris$Species,pch=16)
legend("topleft", legend = levels(iris$Species), 
       col = c(1:3), pch=16)
abline(h=1.5,v=5,col="blue",lwd=2)

boxplot(iris$Petal.Length ~ iris$Species, col=1:3,
        main="Classification by Petal.Length")
boxplot(iris$Petal.Width ~ iris$Species, col=1:3,
        main="Classification by Petal.Width")

glm(is.virginica ~ Petal.Length, iris, 
    family = "binomial") %>% summary

glm(is.virginica ~ Petal.Width, iris, 
    family = "binomial") %>% summary

mlrg1 <- glm(is.virginica ~ Petal.Length+Petal.Width, iris, 
             family = "binomial")
summary(mlrg1)

# library(rgl)
# coeff <- mlrg1$coefficients %>% unname
# beta0 <- coeff[1]
# beta1 <- coeff[2]
# beta2 <- coeff[3]
# l <- function(x1,x2) beta0+beta1*x1+beta2*x2
# pred <- function(x1,x2) 1/(1+exp(-l(x1,x2)))
# 
# x1 <- seq(min(iris$Petal.Length),max(iris$Petal.Length),length=100)
# x2 <- seq(min(iris$Petal.Width),max(iris$Petal.Width),length=100)
# z <- diag(100)
# for(j in 1:100)
#   for(i in 1:100)
#     z[i,j] <- pred(x1[i],x2[j])
# plot3d(iris[,c(3,4,6)], col=rep(1:3,each=50),
#        size=5)
# persp3d(x1,x2,z,add=T,col="skyblue")

pred.virginica <- function(x, y) {
  prob <- predict(mlrg1, 
                  data.frame(Petal.Length=x,Petal.Width=y),
                  type = "resp")
  ifelse(prob > 0.5, return("virginica"), return("not virginica"))
}

pred.virginica(6,2)
pred.virginica(5,1.5)
pred.virginica(3,1)

# (숙제) rpf.Rdata를 로딩하시오.
# 1. pass, fail에 대한 다중 로지스틱회귀 모형을 제시하시오.
# 2. 일주일 동안 평균 4.9시간 공부하고, 출석점수가 82점일 때
#    pass를 예측하라.
setwd("~/R")
load("rpf.Rdata")


plot(rpf[,c(1,4)], pch=16, cex=1)
rg1 <- lm(outcomes.num~hours,data=rpf)
abline(rg1,lwd=3,col="red")

plot(rpf[,c(2,4)], pch=16, cex=1)
rg2 <- lm(outcomes.num~absence,data=rpf)
abline(rg2,lwd=3,col="red")

plot(rpf %>% select('hours', 'absence'),
     col=rpf$outcomes,pch=16)

glm(outcomes.num ~ hours, rpf, 
    family = "binomial") %>% summary

glm(outcomes.num ~ absence, rpf, 
    family = "binomial") %>% summary

mlrg1 <- glm(outcomes.num ~ hours+absence, rpf, 
             family = "binomial")
coeff <- mlrg1$coefficients %>% unname
beta0 <- coeff[1]
beta1 <- coeff[2]
beta2 <- coeff[3]
l <- function(x1,x2) beta0+beta1*x1+beta2*x2
pred <- function(x1,x2) 1/(1+exp(-l(x1,x2)))
pred.pass <- function(x, y) {
  prob <- predict(mlrg1, 
                  data.frame(hours=x,absence=y),
                  type = "resp")
  ifelse(prob > 0.5, return("Pass"), return("not Pass"))
}

pred.pass(4.9,82)
pred(4.9,82)
