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

stud <- rbind(ga, gb, gc)
stud <- left_join(stud, sch, by="scholarship")
stud
stud %>%
  group_by(scholarship, gender) %>%
  summarise(n = n())
