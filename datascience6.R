library(dplyr)
library(magrittr)
library(nnet) # 인공신경망

# 인공신경망 개념 설명
# 인공신경망 (artificial neural network)
# 1. 데이터 생성
rm(list=ls()); gc()
x <- seq(1,20, length.out = 100)
y <- seq(27,81, length.out = 100)
xyz <- data.frame(x,y,z=x^2+5*y)

# 2. 훈련 데이터와 검증 데이터 분리
samp <- sample(1:nrow(xyz), nrow(xyz)*0.7)
xyz.train <- xyz[samp, ] # 학습 데이터(훈련)
xyz.test <- xyz[-samp, ] # 검증 데이터



# linout=T 수치예측 linout=F 분류
# 입력변수, 출력변수(z), size = 은닉층의 노드 수, maxit = 반복 횟수(전진파 -> 후진파 (1회)),
nn1 <- nnet(xyz.train[,-3], xyz.train[,3], size=50, maxit=10000, linout=T) 
# nn1 <- nnet(z ~ ., data = xyz.train, size=50, maxit=10000, linout=T)

xyz.test  # 검증 데이터

z.prediction <- predict(nn1, xyz.test[,-3]) # 생성한 뉴럴 네트워크, 검증 데이터의 (x와 y갑만 주고 예측치테스트)
data.frame(xyz.test, z.prediction)

#########################################
# (실습 1) abc.Rdata를 로딩하시오.
# a=2, b=11 일 때, c=6.480741 이다.
# 신경망학습을 통해 예측오차를 구하라.
load("abc.Rdata")

#########################################

# 인공신경망 학습을 통한 곡선찾기
x <- c(0,sort(10*runif(40)))
y <- sin(2*x)+cos(3*x)
plot(x, y, pch=16)

# 실제곡선
f <- function(x) sin(2*x)+cos(3*x)
plot(f, 0, 10, add=T, lwd=2, col="blue")

nn2 <- nnet(x, y, size=20, maxit=20000, linout=TRUE)
x1 <- seq(0, 10, by=0.1)
lines(x1, predict(nn2, data.frame(x=x1)), col="red", lwd=2)

# 차이가 발생하는 이유는 사이 데이터가 없기 때문.


# 인공신경망 학습을 통한 iris의 종 분류
# 종 예측
iris <- iris
summary(iris)
iris.train <- iris %>% 
  group_by(Species) %>% 
  sample_frac(0.7) %>% 
  as.data.frame
iris.test <- setdiff(iris, iris.train)
                                                              # 분류는 F
nn3 <- nnet(Species ~., data=iris.train, size=20, maxit=10000, linout=F)
Species.prediction <- predict(nn3, iris.test[,-5], type="class") %>% as.factor
# 결과
iris.test %>% cbind.data.frame(Species.prediction)

#########################################
# (실습 2) -2.75, 0, 654.102 를 입력하여 
# 양수, 음수, 영을 판별하는 신경망을 만들어라.





#########################################

# Spiral data
load("spiral.Rdata")
load("~/R/spiral.Rdata")
str(spiral)
plot(spiral[-3], pch=16,
     col=spiral$color %>% as.character)

test <- data.frame(x=NA, y=NA)
for(i in 1:10000){
  set.seed(i)
  test[i,] <- runif(2,-1,1)
}

plot(test,xlim=c(-1,1),ylim=c(-1,1),
     xlab="x", ylab="y",pch=16)
#과적합 발생
nn4 <- nnet(color~., data=spiral, 
            size=20, maxit=10000,
            linout=F)
points(test,pch=16, col=predict(nn4, test, type="class"))

# over-fitting 
# 과적합 방지 decay
nn5 <- nnet(color ~ ., data=spiral, 
            size=20, maxit=10000,
            linout=F, decay=0.1)

plot(test,xlim=c(-1,1),ylim=c(-1,1),
     xlab="x", ylab="y", pch=16,
     col=predict(nn5, test, type="class"))

#########################################
# 배타적 논리합 대한 신경망을 만들시오.
rm(list=ls()); gc(); dev.off()
xor <- data.frame(x = c(0,0,1,1),y=c(0,1,0,1))
xor$z <- xor %$% ifelse(x==y,0,1) %>% as.factor
plot(xor$x, xor$y, col=xor$z, pch=16, cex=2,
     xlab="X", ylab = "Y", main = "XOR logicalSum")

xor.lg <- glm(z ~ ., data = xor, family = "binomial")
z.pred_by_logit <- predict(xor.lg, xor[,-3], type = "resp")
data.frame(xor,z.pred_by_logit) %>% View

nn6 <- nnet(z ~ ., data = xor, 
            size=10, maxit=100,
            linout=F)
predict(nn6, xor[,1:2], type="class")

test <- data.frame(x=NA, y=NA)
for(i in 1:10000){
  set.seed(i)
  test[i,] <- runif(2,0,1)
}
points(test,pch=16, cex=2,
       col=predict(nn6, test, type="class") %>% as.factor)

install.packages("extrafont")
library(extrafont)
font_import()



# 3-> f1 0.1 ->  f2 7 ->  f3 3 (전진파 후진파 학습)
f1 <- function(z) 1/(1+exp(-z))
a1 <- f1(0.7*3+0.1)
f2 <- function(z) tanh(z)
a2 <- f2(a1*2+7)
f3 <- function(z) max(0,z)
f3(a2*1+3)
