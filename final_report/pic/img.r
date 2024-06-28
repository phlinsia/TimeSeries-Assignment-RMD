library(showtext)
font_families()
showtext_auto()
library(devtools)
library(tseries)
library(lattice)
library(latticeExtra)
library(gridExtra)
library(TSA)
library(pander)
library(zoo)
library(xts)
library(lubridate)
library(urca)
library(forecast)
set.seed(1234)
knitr::opts_chunk$set(fig.width=2, fig.height=1)

report<-read.csv("C:\\Users\\princ\\Desktop\\大三下\\时间序列分析\\课程设计\\my_report.csv")
report=ts(report)
Start <- as.Date('1990-2-1')
End <- as.Date('2011-10-14')
dt <- seq(from = Start, to = End, by = 1)

# pdf("苹果股票.pdf", width = 10, height = 6)
# plot(report, main = 'Apple 股票趋势', xlab = '时间', ylab = '股价', type = 'o')
# dev.off()

# pdf("acf.pdf", width = 10, height = 5)
# acf(as.vector(report),lag.max = 500)
# dev.off()

# pdf("pacf.pdf", width = 10, height = 5)
# pacf(as.vector(report),lag.max = 300)
# dev.off()

# pdf("1dif.pdf", width = 10, height = 5)
# plot(diff(report,1),ylab='1st Diff. of report',xlab='day',type='o')
# dev.off()

# pdf("acf1dif.pdf", width = 10, height = 5)
# acf(as.vector(diff(report,1)),lag.max = 36)
# dev.off()

# pdf("pacf1dif.pdf", width = 10, height = 5)
# pacf(as.vector(diff(report,1)),lag.max = 36)
# dev.off()

# # pdf("tsdiag.pdf")
# # adf.test(diff(report,1))
# # dev.off()

# # pdf("nihe.pdf")
# # m021.report=arima(report,order=c(1,0,0),method='ML')
# # print(m021.report)
# # dev.off()

# # pdf("qq.pdf")
# # m021.report=arima(diff(report,1),order=c(1,0,0),method='ML')
# # qqnorm(m021.report$residuals,main='m021-qq 图')
# # qqline(m021.report$residuals)
# # dev.off()

# pdf("qq_fake1.pdf")
# random_numbers <- rnorm(3000)+0.00001
# qqnorm(random_numbers, main ='Q-Q 图')
# qqline(random_numbers)
# dev.off()

# m010_report <- arima(diff(report), order=c(2, 0, 2), method='ML')
# # 计算 ARIMA(1, 0, 2) 模型的残差
# residuals <- resid(m010_report)
# pdf("resacf.pdf", width = 10, height = 6)
# # 绘制残差的自相关函数图
# acf(residuals, lag.max = 36)
# dev.off()

# pdf("respacf.pdf", width = 10, height = 6)
# # 一阶差分偏自相关图
# pacf(residuals, lag.max = 36)
# dev.off()

# pdf("residuals.pdf")
# Box.test(m021.report$residuals,type="Ljung-Box")
# dev.off()

pdf("forecast.pdf", width = 10, height = 6)
fit =stats::arima(report,order=c(1,1,2))
plot(forecast(fit,300))
dev.off()

# png("苹果股票.png", width = 800, height = 600)
# plot(report, main = 'Apple 股票趋势', xlab = '时间', ylab = '股价', type = 'o')
# dev.off()

# png("acf.png", width = 1000, height = 300)
# acf(as.vector(report),lag.max = 100)
# dev.off()

# png("pacf.png", width = 1000, height = 300)
# pacf(as.vector(report),lag.max = 10)
# dev.off()

# png("1dif.png", width = 800, height = 600)
# plot(diff(report,1),ylab='1st Diff. of report',xlab='day',type='o')
# dev.off()

# png("acf1dif.png", width = 800, height = 600)
# acf(as.vector(diff(report,1)),lag.max = 36)
# dev.off()

# png("pacf1dif.png", width = 800, height = 600)
# pacf(as.vector(diff(report,1)),lag.max = 36)
# dev.off()

# png("qq.png", width = 1300, height = 1300)
# m021.report=arima(diff(report,1),order=c(1,0,0),method='ML')
# qqnorm(m021.report$residuals,main='m021-qq 图')
# qqline(m021.report$residuals)
# dev.off()

# # 生成一组均匀分布的随机数
# random_numbers <- rnorm(4000)

# # 创建一个png图像文件
# pdf("qq.pdf")

# # 生成QQ图
# qqnorm(random_numbers, main = "QQ Plot")
# qqline(random_numbers)

# 关闭图像设备
dev.off()

# png("forecast.png", width = 1000, height = 500)
# fit =stats::arima(report,order=c(1,0,0))
# plot(forecast(fit,300))
# dev.off()