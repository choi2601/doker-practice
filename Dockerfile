# Layer 4
# FROM baseImage
FROM node:16-alpine 

WORKDIR /app

COPY package.json package-lock.json ./

# RUN npm install : 실제 현재 릴리즈된 버전과 명시한 package.json 버전이 다를 수 있음
RUN npm ci 

COPY index.js .

# Layer 0(Base Image)
ENTRYPOINT ["node", "index.js"]

# Layer0(Base Image) ~ Layer4 : 제일 빈번하게 발생하는 것(Update Frequency)일수록 마지막에 작성
# 변경되지 않은 레이어는 캐시에 저장된 토대로 재사용하기 때문에 빈번하게 발생하는 것을 상단의 레이어에 위치(실제 순서 반대)

# 빌드 명령어 : docker build -f Dockerfile -t fun-docker .
# image 확인 명령어 : docker images
# container print 실행 명령어 : docker run -d -p 8080:8080 fun-docker     
# docker ps : 현재 실행 중인 container
# docker tag fun-docker:latest 1234obama/docker-example:tagname : docker 이름 변경
# docker rmi 1234obama/docker-example:(tagname) : docker image 삭제                                                                                                                                 