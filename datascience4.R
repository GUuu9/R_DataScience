# 그래프# 산점도 (scatter plot)
faithful <- faithful
str(faithful)
library(dplyr)
library(magrittr)
plot(faithful)

plot(faithful,
     xlab="explode Period",
     ylab="explode Cycle")

plot(faithful,xlab="explode Period",ylab="explode Cycle",
     main="Old Faithful Scatter plot ")

plot(faithful,
     xlab="explode Period",ylab="explode Cycle",
     main="Old Faithful Scatter plot ",
     col="red")

plot(faithful,xlab="explode Period",ylab="explode Cycle",
     main="Old Faithful Scatter plot ",
     col="violetred")

colors() # R에서 제공하는 컬러
par(mfrow=c(2,2)) #plot을 () 안의 표처럼 분할
dev.off() #plot 종료



#pch : point of character 점의 종류
#cex : character expension 점의 크기 확장

plot(faithful,xlab="explode Period",ylab="explode Cycle",
     main="Old Faithful Scatter plot ",
     col="violetred", pch=16)

par(mfrow=c(1,1))

plot(faithful,xlab="explode Period",ylab="explode Cycle",
     main="Old Faithful Scatter plot",
     col="violetred", pch=16, cex=0.8)

iris <- iris
plot(iris$Petal.Length, iris$Petal.Width,
     xlab="petal Length",
     ylab="petal Width",
     main = "iris",pch=16)

plot(iris %>% select(3,4),
     xlab="petal Length",
     ylab="petal Width",
     main = "iris",pch=16,
     col=iris$Species) # 종별로 색을 다르게 표시하라

#항목 명을 다음 위치에 표시
#legend : 범례
#“bottomright”, “bottom”, “bottomleft”, “left”, 
#“topleft”, “top”, “topright”, “right”, “center”
legend("left", legend = levels(iris$Species), 
       pch=16, col=1:3)
legend("right", legend = levels(iris$Species),
       pch=16, col=1:3)

plot(iris %>% select(3,4),
     xlab="petal Length",
     ylab="petal Width",
     main = "iris",pch=16,
     col=c(rep("blue",50),rep("green",50),rep("orange",50))
)
legend("topleft", legend = levels(iris$Species),
       pch=16, col=c("blue","green","orange"), cex=1.2)

plot(iris %>% select(3,4),
     xlab="petal Length",
     ylab="petal Width",
     main = "iris",pch=16,
     col=iris$Species)

# 범례의 이름을 직접 설정가능하다.
legend("bottomright",
       legend = c("setosa","versicolor","virginica"),
       pch=16, col=1:3, cex=1.2)

# Export 버튼을 통해 작성한 Plots을 저장할 수 있다.

plot(iris)


# 히스토그램 (histogram)
?hist
hist(iris$Sepal.Width)
x <- rnorm(2000,10,4)
hist(x,col="yellow") # 도수 분포
hist(x,col="yellow",probability = T) # 확률분포
curve(dnorm(x,10,4),col="red",add=T) # dnorm 정규분포 확률 밀도 함수

# 상자그림 (box plot)
?boxplot
boxplot(iris$Sepal.Width)
boxplot(Sepal.Width ~ Species, data=iris)
# 아래서 부터 min, 25%, median, 75%, max 지점 표시됨
boxplot(Sepal.Width ~ Species, data=iris,
        col=c("red","yellow","blue"))
boxplot(Sepal.Width ~ Species, data=iris,
        col=c("red","yellow","blue"),
        horizontal=T, notch=T)

# 수학식
# 표를 생성  xlim = 표시할 x 의 범위, ylim = 표시할 y의 범위
plot(NA, xlim=c(-3,3), ylim=c(-3,4),
     xlab="x",ylab="y")
abline(v=0)  # v : vertical 수직의
abline(h=0)  # h : horizontal 수평의
points(0,0,col="red",pch=16) # 점찍기
text(0,-0.2, "center poing", cex = 1.2) # 텍스트 삽입

# y = a + bx 방정식
abline(a=1,b=1,col="red")
abline(a=0,b=-1,col="blue",lwd=10) # lwd 선 두께
abline(a=-2,b=3,col="black",lty=4) # lty 선의 종류

# 곡선 식, 시작지, 끝지점, 컬러
curve(-(x-1)^2+5, -3, 4, col="blue")
f <- function(x) -(x-1)^2+5
optimize(f, c(-1, 3), maximum = TRUE)


dev.off()
curve(-(x-1)^2+5, -3, 4, col="blue",
      xlab="x", ylab="y")
abline(v=0,lwd=0.5)
abline(h=0,lwd=0.5)
abline(a=1,b=1,col="red")

curve(sin(x),0,6*pi,col="red",ylab = "f(x)")
abline(v=0,lwd=0.5)
abline(h=0,lwd=0.5)
curve(cos(x),0,6*pi,col="blue",add=)

plot(NA, xlim=c(0,15), ylim=c(-1.2,1.2),
     xlab="x", ylab="y")
abline(v=0,lwd=0.5)
abline(h=0,lwd=0.5)
curve(sin(x), 0, 2*pi, add = T)
curve(cos(x), 0.5*pi, 2.5*pi, add=T, col="red")

curve(dnorm(x,5,2),-3,13, ylab = "f(x)")
abline(h=0,lwd=0.5)
curve(dnorm(x,5,3),-3,13, add=T, col="red")
curve(dnorm(x,5,4),-3,13, add=T, col="blue")

# log(x)+sqrt(x)=2를 풀어라.
curve(log(x)+sqrt(x),0,5,ylab="")
abline(h=2,col="red",lwd=0.5,lty=2)

install.packages("rootSolve")
library(rootSolve)
# 방정식의 우변을 항상 0으로 만든다.
# 즉, log(x)+sqrt(x)-2=0
eq <- function(x) log(x)+sqrt(x)-2
uniroot(eq,c(0,15))$root
abline(v=uniroot(eq,c(0,15))$root, col="blue")

?uniroot

g <- function(x) 1/(2*sqrt(2*pi))*exp(-(x-5)^2/8)
f <- function(z) integrate(g,-Inf,z)$value-0.5
x <- seq(1,10,by=0.01)
x %>% matrix(ncol = 1) %>% apply(1,f)
df <- data.frame(x=x,fx=x %>% matrix(ncol=1) %>% apply(1,f))
uniroot(f, c(4,6))$root
abline(v=uniroot(f,c(4,6))$root, col="red")

# 연립방정식
#  x + y = 3
# 2x + y = 5

A <- matrix(c(1,1,
              2,1), byrow = T, ncol=2)
b <- c(3,5)
solve(A,b)

# R 에서는 scanf 같은 함수가 없나요? 질문
a <- readline(prompt = "Enter a number: ")
class(a)

a <- readline(prompt = "Enter a number: ") %>% as.numeric
print(a+1)

