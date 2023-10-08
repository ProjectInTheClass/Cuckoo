![Cuckoo(가제)](https://media.discordapp.net/attachments/1158743054107279413/1158749790969008168/image.png?ex=652e84d6&is=651c0fd6&hm=79555463628be2b4bea6f357a0b9c49741becb5249de93c515d5a15ce7ba8009&=&width=2699&height=880)

<div align='center'>
    <h1>Cuckoo : 빠르고 쉬운 메모, 편한 관리 및 리마인드 </h1>

```
  한양대 SS2 전공 프로젝트
  (2023.09.01 - 2023.12.31)
```

</div>

# 🚀 참여 인원

```bash
김경민, 유철민, 장동우, 표지원
```

<br>
<br>
<br>

# 🥛 목차

1. [🙋‍♂️ 서비스 소개](#%EF%B8%8F-서비스-소개)
2. [🎖️ 핵심 기능](#%EF%B8%8F-핵심-기능)
3. [📚 사용 라이브러리](#-사용-라이브러리)
4. [📖 디렉토리 구조](#-디렉토리-구조)
5. [🙏 Git Flow / Rules](#-git-flow--rules)

---

<br>
<br>
<br>

# 🙋‍♂️ 서비스 소개

<br>
<br>

# 🎖️ 핵심 스케쥴

### 1️⃣ 간편한 메모

타 앱 사용시에도 편하게 **공유하기** 기능으로 한 곳에 메모 & 링크 모으기

### 2️⃣ 쉬운 메모 & 링크 관리

태그 기반으로 분류된 모든 메모들을, **사용자에게 맞춘 UI**를 통해 관리

### 3️⃣ 너무 오래된 메모 및 기록을 편하게 관리하도록 리마인드

바쁜 현대인을 위해 기록 조차 **까먹은 내용들을 보기 편할때 따로 리마인드** 및 알아서 관리!

<br>
<br>
<br>

# 📚 사용 라이브러리

## 🙌 팀 구조

![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=white)
![Express](https://img.shields.io/badge/Express-000000?style=for-the-badge&logo=express&logoColor=white)

<br>
<br>
<br>

# 📖 디렉토리 구조

```bash
# 이하 내용은 예시입니다. 실제로 정해지면 수정할 계획입니다.

|-- Cuckoo (Project)
    |
    |-- Cuckoo
    |       |-- App
    |       |-- Server
    |
    |-- Sandbox
    |       |-- (추후 추가)
    |
    |
    |-- docs
    |       |-- README
    |       |-- etc..
    |
    |-- ...
```

<br>
<br>
<br>

# 🙏 Git Flow / Rules

## 1️⃣ Commit Convention

-   Commit Type만 영어로 작성합니다.

```Markdown
[{commit_목적}] {작업 요약}
(여러줄로 다는 경우) dash로 각 줄별로 수정 내역을 넣기

# example) [add] MainPage layout 추가
# example) [fix] MainPage Header 글자 표기오류 수정

# long example)
[add] MainPage layout 추가
 - UIKit으로 작업
 - //WIP
```

<br>

## 2️⃣ Branch Convention

### (1) master

-   작업한 내용들이 최종적으로 합쳐지는 Branch
-   Branch 에 모든 과제/발표자료를 Commit 했을 시, `rebase` 및 `PR` 로 Merge

### (2) 개인 작업용 Branch

-   기능을 개발해서, 코드 추가/수정 시 브랜치를 생성하고 작업합니다.
-   camelCase 준수 요망

```Markdown
{목적}/{작업명_issue}

목적
- add : 과제를 제출하려고 파일을 등록하는 경우
- fix : 잘못 제출했거나, 내용을 보충하기 위해 이미 제출한 내역을 수정하는 경우.

# example : MainPage Layout을 손보고 코드를 추가하는 브랜치의 경우.
-> add/mainPageLayout
```

<br>
