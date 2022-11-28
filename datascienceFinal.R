###############################################################
library('tidyverse')
library(dplyr)
library(magrittr)
library(rootSolve)
library(lpSolve)
library(nnet) # 인공신경망
setwd("~/R")

###############################################################
#################1
earthquake <- read.csv("EARTH.csv", header = T)
#1-1 삼척 이남에서 발생한 지진중 규모가 제일 큰 지진은 언제, 어디서 발생하였는가? 
#강원대학교 기준으로 해당 위도보다 아래로 계산. 구글 어스 기준 37.27`13N 129.09`44E

# 강원대보다 아래 있는 지진 발생 지역만 저장
ans1 <- subset(earthquake, 위도.숫자. < 37.27, c('발생시각', '위도.숫자.', '규모', '위치'))

# 저장 데이터중 규모가 가장 큰 값을 찾음
max(ans1$규모)
#[1] 5.8 가장 큰 규모의 값이 나왔기 때문에 조건을 추가해서 새로 데이터를 구성.
ans1 <- subset(earthquake, 위도.숫자. < 37.27 & 규모 == 5.8, c('발생시각', '위도.숫자.', '규모', '위치'))
ans1

#1-2 북한에서 발생한 지진 중 가장 최남단에서 발생한 지진은 규모가 얼마인가?
# 북한 최남단의 위도는 37.67 해당 위도보다 높은 값, 북한 데이터만 추출
ans2 <- subset(earthquake, 위도.숫자. >= 37.67 & str_detect(위치, '북한') == TRUE, c('위도.숫자.', '규모', '위치'))
# 최남단 확인
min(ans2$위도.숫자.)
# 최남단 값을 넣고 규모 확인
ans2 <- subset(earthquake, 위도.숫자. == 37.67, c('위도.숫자.', '규모', '위치'))
ans2


#1-3 강원도에서는 몇월에 지진이 가장 많이 발생했는가? 
# 강원도 지역의 지진 데이터를 월을 포함해서 추출
ans3 <- subset(earthquake, str_detect(위치, '강원') == TRUE, c('월', '규모', '위치'))
# 월별로 묶어, 지진이 가장 많이 발생한 횟수 확인
ans3 <- ans3 %>% 
  count(월)
max(ans3$n)
# 최대치 값 기준으로 월과 횟수를 가져온다.
ans3 <- subset(ans3, n == 7, c('월', 'n'))
ans3

#1-4 제주 해역에서 발생한 지진 중 규모가 2.5 이하인 지진은 몇번 일어났는가?
# 지명 이름이 제주 이고, 규모가 2.5 이하인 경우를 추출
ans4 <- subset(earthquake, str_detect(위치, '제주') == TRUE & 규모 <= 2.5, c('규모', '위치'))
# 추출한 데이터의 갯수 확인으로 지진의 횟수 구하기
count(ans4)

#1-5 인천에서 발생한 지진의 규모에 대해 상자그림(boxplot)을 작성하라.
# 지명이 인천인 데이터 추출
ans5 <- subset(earthquake, str_detect(위치, '인천') == TRUE, c('규모', '위치'))
boxplot(ans5[1])


###############################################################
#################2
func <- function(seta) tan(seta) - 6 / tan(seta)
# seta의 범위는 4 < seta <  3*pi/2
# 사이의 값중 func가 1인값을 찾는다. 

# 반복문을 통해 최대한 근접한 값을 찾는다.
i = 4
while(func(i) <= 1){
  i = i + 0.0000001
}  
j = 3*pi/2
while(func(j) >= 1){
  j = j - 0.0000001
}
i;j;
# i = 4.39063850109549
# j = 4.3906383794824
# 두값 사이에서 func(seta)가 1인 값이 존재함.

k = 4.3906385
func(k)
# 값은 1.000001 
k = 4.3906384
func(k)
# 값은 0.9999996
# 7 번째 자리수에서 값을 찾는다.
seta0 = 4.39063842
seta1 = 4.39063843
seta2 = 4.39063844
seta3 = 4.39063845
seta4 = 4.39063846
func(seta0)
func(seta1)
func(seta2)
func(seta3)
func(seta4)
# 3가지 값에서 func값이 1임을 확인하였다.
# 소수점 자리수를 늘려 탐색도 가능하지만 결국 사이값에선 모두 1인 값이 나올것으로 판단
# 따라서 seta 1,2,3에 대한 sec(seta) + csc(seta) 값을 찾는다.
# sec = 1/cos 이고 csc = 1/sin이다.
ans2 = 1/cos(seta1) + 1/sin(seta1)
ans2
ans2 = 1/cos(seta2) + 1/sin(seta2)
ans2
ans2 = 1/cos(seta3) + 1/sin(seta1)
ans2

# 해당 찾고자 하는 값은 -4.21637이다. 값에 따라 소수점 6자리 이후로는 차이가 존재할 수있다.

# 좌변을 0 으로 만드는 uniroot도 사용해보았을 경우
func02 <- function(seta) tan(seta) - 6 / tan(seta) - 1
ans02 <- uniroot(func02,c(4,3*pi/2))$root
# seta 값은 4.39063113213219가 나온다.
func02(ans02)
# 다음을 실행할 경우 
# 0.9998784 값이 나오게 된다.
# 해당 경우 
ans2 = 1/cos(ans02) + 1/sin(ans02)
ans2

#값이 -4.216304로 소수점 자리수가 어느정도 넘어가게되면 반올림 되어 차이가 발생하는 것으로
#차이가 생긴다고 판단된다.


###############################################################
#################3
#가위바위보 게임을 똑같이 작성하시오.
# 함수 시작
rsp.start <- function(x){       
  # 게임 스코어 저장
  win = 0
  lose = 0 
  draw = 0
  # 컴퓨터가 낼 목록 구성
  bot <- c('가위', '바위', '보')
  # 시작 print 를 사용할 경우 라인넘버가 나와서 다른 출력인 cat을 사용
  cat('가위 바위 보 대결 시작!')
  while(T){
    # 사용자로부터 데이터를 입력 받음 종료를 받을때 까지 반복
    input <- readline('가위, 바위, 보, (게임을 끝낼려면 종료를 입력) : ')
    # 입력 데이터가 종료일 경우 스코어를 출력하고 종료
    if (input == '종료'){
      cat('게임 종료\n')
      cat('.\n')
      # 0이 아닌 스코어만 출력한다.
      if (draw != 0)
        cat('비김   ')
      if (win != 0)
        cat('승   ')
      if (lose != 0)
        cat('패   ')
      if (draw != 0 | win != 0 | lose != 0)
        cat('\n')
      if (draw != 0)
        cat('  ',draw)
      if (win != 0)
        cat('  ',win)
      if (lose != 0)
        cat('  ',lose)
      break
    }
    # 사용자가 올바른 입력을 할 경우
    else if ( input == '가위' | input == '바위' | input == '보'){
      #1~3 사이의 값중 랜덤하게 하나를 가져와서 botresult에 넣어 값을 가져옴
      idx <- sample(1:3,1)
      botresult <- bot[idx]
      # 입력과 컴퓨터의 결과에 따라 승패 확인
      # 동점
      if ( input == botresult){
        gameresult <- '비김'
        draw = draw + 1
      }
      # 승리
      else if ((input == '가위' & botresult == '보') |(input == '보' & botresult == '바위') |
               (input == '바위' & botresult == '가위')) {
        gameresult <- '승'
        win = win + 1
      }
      # 패배
      else{
        gameresult <- '패'
        lose = lose + 1
      }
      cat('컴퓨터는', botresult, '를 냈습니다.  ', gameresult)
    }
    # 가위 바위 보 종료를 제외한 나머지 값은 다음을 출력하고 다시 입력을 받음
    else{
      cat('똑바로 입력하세요. ㅡㅡ;')
    }
  }
}


###############################################################
#################4
#두집합X={1,2,3,4,5},Y={1,2,3,4}에대하여다음조건을만족시키는X에서Y로의
#함수 f 의 갯수를 R코딩으로 구하시오. 
X = c(1,2,3,4,5)
Y = c(1,2,3,4)

# 조건을 무시하고 모든 함수의 수는
4^5
# 총 1024 개 이다.

# 1번 조건에 따라 집합X의모든원소x에대하여f(x) >= root(x)이다.
sqrt(1) # 1
sqrt(2) # 1.414214
sqrt(3) # 1.732051
sqrt(4) # 2
sqrt(5) # 2.236068

# 2번 조건으로 함수 f 치역의 원소 개수는 3개
# 123, 124, 134, 234가 나오게 된다.

# 치역의 개수는 3개라고 하니 위의 방법으로 총 4가지의 조합이 발생
3^5 * 4

# 총 972가지의 경우가 나온다.

# 1번 조건을 보면 1의경우 모든 값을가질 수 있고 2, 3, 4는 2,3,4 값,
# 5는 3, 4를 가질 수 있다.

# 1,2,3의 경우
3 * 2^3 * 1
# 24가지

# 1,2,4의 경우
3 * 2^3 * 1
# 24가지

# 1,3,4의 경우
3 * 2^4 
# 48가지

# 2,3,4의 경우
3^4
# 81가지

#두개의 조건을 만족하는 함수의 개수는
(3 * 2^3 * 1) + (3 * 2^3 * 1) + (3 * 2^4) + (3^4)
# 총 177가지가 있다.

###############################################################
#################5
load('P5.Rdata')
#5-1
plot(P5,
     main="Scatter plot (산점도)",
     xlab="x(엑스)",
     ylab="y(와이)", 
     col = 'orange', pch = 18, cex=0.8)

#5-2
# 단순 선형회귀를 실행할 경우
rg <- lm(data = P5, y ~ x)
rg
rg$coefficients # Beta0 와 Beta1의 계수 확인
B0 <- rg$coefficients[1] %>% unname
B1 <- rg$coefficients[2] %>% unname
abline(rg, col="red", lwd=3) # 최적의 직선

# 곡선의 형태로 sin 함수로 예상됨. 감소 -> 증가 -> 감소
plot(P5,
     main="Scatter plot (산점도)",
     xlab="x(엑스)",
     ylab="y(와이)", 
     col = 'orange', pch = 18, cex=0.8)

rg <- lm(data = P5, y ~ x + sin(x))
summary(rg)
rg$coefficients
beta0 <- rg$coefficients[1]
beta1 <- rg$coefficients[2]
beta2 <- rg$coefficients[3]
curve(beta0 + beta1 * x + beta2 * sin(x), type = "l", col = "blue", add = T, lwd = 2)

#5-3
# x 가 23일때의 y값을 예측
pred <- function(x) beta0 + beta1 * x + beta2 * sin(x)
pred(23)


###############################################################
#################6
#6-2
#자연수 2 보다 큰 어떤 자연수 n 을 고려하자.
#n 보다 작거나 같은 소수(prime number) 의 갯수를 예측하는 인공신경망을 만들고, 
#자연수 3,005 보다 작거나 같은 소수의 갯수를 인공신경망을 통해 예측하시오.

# 소수 찾기 2000개의 데이터
x <- primeNum <- c(2:5000)
for (i in 2:5000)
  primeNum <- setdiff(primeNum, x[x %% i == 0 & x %/% i != 1])
# y값에 i보다 작은 소수의 개수를 저장
num <- 1 
count <- 0
y <- c(2:4000)
for(i in 2:4000){
  if(i == primeNum[num]){
    num <- num + 1
    count <- count + 1
  }
  y[i-1] <- count
}
y
x <- c(2:4000)
# 그래프로 소수의 개수 증가폭 확인
plot(x, y, pch=16, cex = 0.3)
xy <- data.frame(x,y)
##################################
rg <- lm(data = xy, y ~ x)
summary(rg)
rg$coefficients
beta0 <- rg$coefficients[1]
beta1 <- rg$coefficients[2]
curve(beta0 + beta1 * x, type = "l", col = "blue", add = T, lwd = 2)
pred <- function(x) beta0 + beta1 * x
pred(3005)

###################################


xyz <- data.frame(x,y,z=y)

# 훈련 데이터와 검증 데이터 분리
samp <- sample(1:nrow(xyz), nrow(xyz)*0.7)
xyz.train <- xyz[samp, ] # 학습 데이터(훈련)
xyz.test <- xyz[-samp, ] # 검증 데이터



# linout=T 수치예측
# 입력변수, 출력변수(z), size = 은닉층의 노드 수, maxit = 반복 횟수(전진파 -> 후진파 (1회)),
nn <- nnet(xyz.train[,-3], xyz.train[,3], size=50, maxit=10000, linout=T)

xyz.test  # 검증 데이터

z.prediction <- predict(nn, xyz.test[,-3]) # 생성한 뉴럴 네트워크, 검증 데이터의 (x와 y갑만 주고 예측치테스트)
ans5 <- data.frame(xyz.test, z.prediction)
