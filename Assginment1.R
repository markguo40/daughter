library(foreign)
library(Matching)
library(rgenoud)

# Extract and process data
setwd("/Users/zhanchenguo/Desktop")
data <- read.dta("basic.dta")
data <- data[complete.cases(data[,c(7, 41)]),]
attach(data)
nregion <- as.numeric(region)
hasGirls <- ngirls > 0

# Uncommment it to matching the first set of covariates
# X1 = cbind(age, ngirls, srvlng, demvote, nregion, white, female, congress, rgroup, repub)
# BalanceMat1 <- cbind(age, ngirls, srvlng, demvote, nregion, white, female, congress, rgroup, repub, I(age^2), I(srvlng^2))
# genout1 <- GenMatch(Tr=hasGirls, X=X1, BalanceMatrix=BalanceMat1, estimand="ATT", M=1, pop.size=1000, max.generations=30, wait.generations=5)
# mout1 <- Match(Y=nowtot, Tr=hasGirls, X=X1, estimand="ATT", Weight.matrix=genout1)
# summary(mout1)
# mb1 <- MatchBalance(hasGirls~age+ngirls+srvlng+demvote+nregion+white+female+congress+rgroup+repub+I(age^2)+I(srvlng^2), match.out=mout, nboots=500)

X2 = cbind(age, srvlng, demvote, nregion, white, female, congress, rgroup, repub, district)
BalanceMat2 <- cbind(age, srvlng, demvote, nregion, white, female, congress, rgroup, repub, district, I(age^2), I(srvlng^2))
genout2 <- GenMatch(Tr=hasGirls, X=X2, BalanceMatrix=BalanceMat2, estimand="ATT", M=1, pop.size=1000, max.generations=30, wait.generations=5)
mout2 <- Match(Y=nowtot, Tr=hasGirls, X=X2, estimand="ATT", Weight.matrix=genout2)
summary(mout2)
mb2 <- MatchBalance(hasGirls~age+srvlng+demvote+nregion+white+female+congress+rgroup+repub+district+I(age^2)+I(srvlng^2), match.out=mout, nboots=500)
