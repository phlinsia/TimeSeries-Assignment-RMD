---
title: "时间序列分析第三章作业"
author: "Phlinsia"
date: "2024年3月25日"
CJKmainfont: SimSun
output:
  bookdown::pdf_document2:
    includes:
        header-includes:
          - \usepackage{xeCJK}
          - \usepackage{subfig}
          - \usepackage{subcaption}
        keep_tex: yes
    latex_engine: xelatex
---



## 3.4 平均工作时间
### a {-}

```r
library(TSA)
data("hours")
xyplot(hours,xlab="时间")
```

![(\#fig:unnamed-chunk-1)美国制造业每周平均工作时间的月度数值](chapter3_files/figure-latex/unnamed-chunk-1-1.pdf) 

在图1中，可见83年到84年间有急剧增长。此外，存在季节性趋势：一般来说，后半年的工作时间较长，除了夏季；不过84年并没有明显的模式。

### b {-}


```r
months <- c("J", "A", "S", "O", "N", "D", "J", "F", "M", "A", "M", "J")

xyplot(hours, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...)
  panel.text(x = x, y = y, labels = months)
}, xlab = "时间")
```

![(\#fig:unnamed-chunk-2)每周平均工作时间的月度数值（标注月份）](chapter3_files/figure-latex/unnamed-chunk-2-1.pdf) 

在图2中，我们的解释基本相同。12月是每周工作时间最长的月份，而2月和1月是最短的，趋势显而易见。

## 3.5 工资

### a {-}


```r
data("wages")
xyplot(wages, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...)
  panel.text(x, y, labels = months)
}, xlab = "时间")
```

![(\#fig:unnamed-chunk-3)美国服装和纺织业工人每月平均小时工资。](chapter3_files/figure-latex/unnamed-chunk-3-1.pdf) 

工资呈现出一个季节性的正向趋势：8月是工资的低谷。
一般来说，秋季的增长似乎更大。

### b {-}


```r
wages_fit1 <- lm(wages ~ time(wages))
summary(wages_fit1)
```

```
## 
## Call:
## lm(formula = wages ~ time(wages))
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.23828 -0.04981  0.01942  0.05845  0.13136 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -5.490e+02  1.115e+01  -49.24   <2e-16 ***
## time(wages)  2.811e-01  5.618e-03   50.03   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.08257 on 70 degrees of freedom
## Multiple R-squared:  0.9728,	Adjusted R-squared:  0.9724 
## F-statistic:  2503 on 1 and 70 DF,  p-value: < 2.2e-16
```

```r
wages_rst <- rstudent(wages_fit1)
```

### c {-}


```r
xyplot(wages_rst ~ time(wages_rst), type = "l",
       xlab = "时间", ylab = "学生化残差")
```

![(\#fig:wages-resid)残差图](chapter3_files/figure-latex/wages-resid-1.pdf) 

此时似乎仍然存在与时间相关的自相关性，而不是白噪声。

### d {-}


```r
wages_fit2 <- lm(wages ~ time(wages) + I(time(wages)^2))
summary(wages_fit2)
```

```
## 
## Call:
## lm(formula = wages ~ time(wages) + I(time(wages)^2))
## 
## Residuals:
##       Min        1Q    Median        3Q       Max 
## -0.148318 -0.041440  0.001563  0.050089  0.139839 
## 
## Coefficients:
##                    Estimate Std. Error t value Pr(>|t|)    
## (Intercept)      -8.495e+04  1.019e+04  -8.336 4.87e-12 ***
## time(wages)       8.534e+01  1.027e+01   8.309 5.44e-12 ***
## I(time(wages)^2) -2.143e-02  2.588e-03  -8.282 6.10e-12 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.05889 on 69 degrees of freedom
## Multiple R-squared:  0.9864,	Adjusted R-squared:  0.986 
## F-statistic:  2494 on 2 and 69 DF,  p-value: < 2.2e-16
```

```r
wages_rst2 <- rstudent(wages_fit2)
```

### e {-}


```r
xyplot(wages_rst2 ~ time(wages_rst), type = "l",
       xlab = "时间", ylab = "学生化残差")
```

![(\#fig:wages_quad_resid)我们二次模型的残差图](chapter3_files/figure-latex/wages_quad_resid-1.pdf) 

像随机噪声，但拟合残差之间的自相关性仍清晰，这是我们尚未在模型中捕捉到的。


## 3.6 啤酒销售

### a {-}


```r
data(beersales)
xyplot(beersales,xlab="时间")
```

![(\#fig:unnamed-chunk-6)美国啤酒月销售额。](chapter3_files/figure-latex/unnamed-chunk-6-1.pdf) 

清晰的季节性趋势。75年到81年左右有个初始的正向趋势，然后趋于稳定。

### b {-}


```r
months <- c("J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D")

xyplot(beersales,
       panel = function(x, y, ...) {
         panel.xyplot(x, y, ...)
         panel.text(x, y, labels = months)
       },xlab="时间")
```

![(\#fig:unnamed-chunk-7)带有月份首字母标注的美国啤酒月销售额。](chapter3_files/figure-latex/unnamed-chunk-7-1.pdf) 

明显可见销售高峰在暖和的月份，而秋冬季则低迷。12月特别低，而5月、6月和7月似乎是高峰期。

### c {-}


```r
beer_fit1 <- lm(beersales ~ season(beersales))
pander(summary(beer_fit1))
```


-------------------------------------------------------------------------------
             &nbsp;               Estimate   Std. Error   t value    Pr(>|t|)  
-------------------------------- ---------- ------------ --------- ------------
        **(Intercept)**            12.49       0.2639      47.31    1.786e-103 

 **season(beersales)February**    -0.1426      0.3732     -0.382      0.7029   

   **season(beersales)March**      2.082       0.3732      5.579    8.771e-08  

   **season(beersales)April**      2.398       0.3732      6.424    1.151e-09  

    **season(beersales)May**       3.599       0.3732      9.643    5.322e-18  

   **season(beersales)June**        3.85       0.3732      10.31    6.813e-20  

   **season(beersales)July**       3.769       0.3732      10.1     2.812e-19  

  **season(beersales)August**      3.609       0.3732      9.669    4.494e-18  

 **season(beersales)September**    1.573       0.3732      4.214    3.964e-05  

  **season(beersales)October**     1.254       0.3732      3.361    0.0009484  

 **season(beersales)November**    -0.04797     0.3732     -0.1285     0.8979   

 **season(beersales)December**    -0.4231      0.3732     -1.134      0.2585   
-------------------------------------------------------------------------------


--------------------------------------------------------------
 Observations   Residual Std. Error   $R^2$    Adjusted $R^2$ 
-------------- --------------------- -------- ----------------
     192               1.056          0.7103       0.6926     
--------------------------------------------------------------

Table: Fitting linear model: beersales ~ season(beersales)

所有比较都是相对1月份来的。这个模型解释了大约0.71的方差，并且在统计上显著。大多数因素都显著（主要是冬季月份，如预期所示）。

### d {-}


```r
xyplot(rstudent(beer_fit1) ~ time(beersales), type = "l",
       xlab = "时间", ylab = "学生化残差",
       panel = function(x, y, ...) {
         panel.xyplot(x, y, ...)
         panel.xyplot(x, y, pch = as.vector(season(beersales)), col = 1)
       })
```

![(\#fig:rst-beer)啤酒销售残差图。](chapter3_files/figure-latex/rst-beer-1.pdf) 

观察残差图，在 \@ref(fig:rst-beer) 中我们没能很好地拟合数据；我们没捕捉到长期趋势。

### e {-}


```r
beer_fit2 <- lm(beersales ~ season(beersales) + time(beersales) +
                  I(time(beersales) ^ 2))
pander(summary(beer_fit2))
```


------------------------------------------------------------------------------
             &nbsp;               Estimate   Std. Error   t value   Pr(>|t|)  
-------------------------------- ---------- ------------ --------- -----------
        **(Intercept)**            -71498       8791      -8.133    6.932e-14 

 **season(beersales)February**    -0.1579      0.209      -0.7554     0.451   

   **season(beersales)March**      2.052       0.209       9.818    1.864e-18 

   **season(beersales)April**      2.353       0.209       11.26    1.533e-22 

    **season(beersales)May**       3.539       0.209       16.93    6.063e-39 

   **season(beersales)June**       3.776       0.209       18.06    4.117e-42 

   **season(beersales)July**       3.681       0.209       17.61    7.706e-41 

  **season(beersales)August**      3.507       0.2091      16.78    1.698e-38 

 **season(beersales)September**    1.458       0.2091      6.972    5.89e-11  

  **season(beersales)October**     1.126       0.2091      5.385    2.268e-07 

 **season(beersales)November**    -0.1894      0.2091     -0.9059    0.3662   

 **season(beersales)December**    -0.5773      0.2092      -2.76     0.00638  

      **time(beersales)**          71.96       8.867       8.115    7.703e-14 

    **I(time(beersales)^2)**      -0.0181     0.002236    -8.096    8.633e-14 
------------------------------------------------------------------------------


--------------------------------------------------------------
 Observations   Residual Std. Error   $R^2$    Adjusted $R^2$ 
-------------- --------------------- -------- ----------------
     192              0.5911          0.9102       0.9036     
--------------------------------------------------------------

Table: Fitting linear model: beersales ~ season(beersales) + time(beersales) + I(time(beersales)^2)

这个模型更好地拟合了数据，解释了大约0.91的方差。

### f {-}


```r
xyplot(rstudent(beer_fit2) ~ time(beersales), type = "l",
       xlab = "时间", yla = "学生化残差",
       panel = function(x, y, ...) {
         panel.xyplot(x, y, ...)
         panel.xyplot(x, y, pch = as.vector(season(beersales)), col = 1)
       })
```

![(\#fig:rst-beer2)二次拟合的啤酒销售残差图。](chapter3_files/figure-latex/rst-beer2-1.pdf) 

许多值仍无法成功预测，但我们现在能更好地建模长期趋势。

## 3.7 温尼贝戈房车销售数据分析

### a {-}


```r
data(winnebago)
xyplot(winnebago,xlab="时间")
```

![(\#fig:winnebago)温尼贝戈房车每月单位销售量图。](chapter3_files/figure-latex/winnebago-1.pdf) 

### b {-}


```r
winn_fit1 <- lm(winnebago ~ time(winnebago))
pander(summary(winn_fit1))
```


-------------------------------------------------------------------
       &nbsp;          Estimate   Std. Error   t value   Pr(>|t|)  
--------------------- ---------- ------------ --------- -----------
   **(Intercept)**     -394886      33540      -11.77    1.87e-17  

 **time(winnebago)**    200.7       17.03       11.79    1.777e-17 
-------------------------------------------------------------------


--------------------------------------------------------------
 Observations   Residual Std. Error   $R^2$    Adjusted $R^2$ 
-------------- --------------------- -------- ----------------
      64               209.7          0.6915       0.6865     
--------------------------------------------------------------

Table: Fitting linear model: winnebago ~ time(winnebago)

该模型具有显著性，并解释了0.69的方差。


```r
xyplot(rstudent(winn_fit1) ~ time(winnebago), type = "l",
       xlab = "时间", ylab = "学生化残差")
```

![(\#fig:winnebago-lm-res)温尼贝戈房车数据线性拟合残差图。](chapter3_files/figure-latex/winnebago-lm-res-1.pdf) 

该拟合效果较差（图\@ref(fig:winnebago-lm-res)）。残差分布并非随机，并且明显看出对于后期年份我们的预测准确性更差。

### c {-}

为了更好拟合，我们对结果变量采用自然对数变换。


```r
winn_fit_log <- lm(log(winnebago) ~ time(winnebago))
pander(summary(winn_fit_log))
```


-------------------------------------------------------------------
       &nbsp;          Estimate   Std. Error   t value   Pr(>|t|)  
--------------------- ---------- ------------ --------- -----------
   **(Intercept)**      -984.9      62.99      -15.64    3.45e-23  

 **time(winnebago)**    0.5031     0.03199      15.73    2.575e-23 
-------------------------------------------------------------------


--------------------------------------------------------------
 Observations   Residual Std. Error   $R^2$    Adjusted $R^2$ 
-------------- --------------------- -------- ----------------
      64              0.3939          0.7996       0.7964     
--------------------------------------------------------------

Table: Fitting linear model: log(winnebago) ~ time(winnebago)

变换后模型改善，解释了近0.8的方差。

### d {-}


```r
xyplot(rstudent(winn_fit_log) ~ time(winnebago), type = "l",
       xlab = "时间", ylab = "学生化残差",
       panel = function(x, y, ...) {
         panel.xyplot(x, y, ...)
         panel.xyplot(x, y, pch = as.vector(season(winnebago)), col = 1)
       })
```

![(\#fig:winnebago-log-res)自然对数变换后的残差图。](chapter3_files/figure-latex/winnebago-log-res-1.pdf) 

此图看起来更像是随机噪声（图\@ref(fig:winnebago-log-res)）。尽管某些月份的值仍有些聚集，但比线性模型已经有了明显的改进。不过我们仍然系统性地高估了某些月份的数值。

### e {-}


```r
winn_fit_seasonal <- lm(log(winnebago) ~ season(winnebago) + time(winnebago))
pander(summary(winn_fit_seasonal))
```


------------------------------------------------------------------------------
             &nbsp;               Estimate   Std. Error   t value   Pr(>|t|)  
-------------------------------- ---------- ------------ --------- -----------
        **(Intercept)**            -997.3      50.64      -19.69    1.718e-25 

 **season(winnebago)February**     0.6244      0.1818      3.434    0.001188  

   **season(winnebago)March**      0.6822      0.1909      3.574    0.0007793 

   **season(winnebago)April**      0.8096      0.1908      4.243    9.301e-05 

    **season(winnebago)May**       0.8695      0.1907      4.559    3.246e-05 

   **season(winnebago)June**       0.8631      0.1907      4.526    3.627e-05 

   **season(winnebago)July**       0.5539      0.1907      2.905     0.00542  

  **season(winnebago)August**      0.5699      0.1907      2.988    0.004305  

 **season(winnebago)September**    0.5757      0.1907      3.018     0.00396  

  **season(winnebago)October**     0.2635      0.1908      1.381     0.1733   

 **season(winnebago)November**     0.2868      0.1819      1.577     0.1209   

 **season(winnebago)December**     0.248       0.1818      1.364     0.1785   

      **time(winnebago)**          0.5091     0.02571      19.8     1.351e-25 
------------------------------------------------------------------------------


--------------------------------------------------------------
 Observations   Residual Std. Error   $R^2$    Adjusted $R^2$ 
-------------- --------------------- -------- ----------------
      64              0.3149          0.8946       0.8699     
--------------------------------------------------------------

Table: Fitting linear model: log(winnebago) ~ season(winnebago) + time(winnebago)

通过加入季节性因素进一步提高了模型的拟合度。$R^2$ 达到0.89，季节性均值以及时间趋势的显著性检验也大多通过。

### f {-}


```r
xyplot(rstudent(winn_fit_seasonal) ~ time(winnebago), type = "l",
       xlab = "时间", ylab = "学生化残差",
       panel = function(x, y, ...) {
         panel.xyplot(x, y, ...)
         panel.xyplot(x, y, col = 1, pch = as.vector(season(winnebago)))
       })
```

![](chapter3_files/figure-latex/winnebago-seasonal-res-1.pdf)<!-- --> 

虽然在时间序列开始时某些残差较大，但总体来说模型可以接受（图\@ref(fig:winnebago-seasonal-res)）。







## 3.10 重新探讨工作时间

### a {-}


```r
data(hours)
hours_quad <- lm(hours ~ time(hours) + I(time(hours)^2))
pander(summary(hours_quad))
```


--------------------------------------------------------------------
        &nbsp;          Estimate   Std. Error   t value   Pr(>|t|)  
---------------------- ---------- ------------ --------- -----------
   **(Intercept)**      -512240      115544     -4.433    4.281e-05 

   **time(hours)**       515.9       116.4       4.431    4.314e-05 

 **I(time(hours)^2)**   -0.1299     0.02933     -4.428    4.353e-05 
--------------------------------------------------------------------


--------------------------------------------------------------
 Observations   Residual Std. Error   $R^2$    Adjusted $R^2$ 
-------------- --------------------- -------- ----------------
      60               0.423          0.5921       0.5778     
--------------------------------------------------------------

Table: Fitting linear model: hours ~ time(hours) + I(time(hours)^2)

线性和二次趋势均显著。我们解释了总方差的59%。

### b {-}


```r
xyplot(rstudent(hours_quad) ~ seq_along(hours), type = "l",
       xlab = "指数", ylab = "学生化残差",
       panel = function(x, y, ...) {
         panel.xyplot(x, y, ...)
         panel.xyplot(x, y, pch = as.vector(season(hours)), col = 1)
       })
```

![(\#fig:hours-quad-res)对小时数序列二次拟合的学生化残差图](chapter3_files/figure-latex/hours-quad-res-1.pdf) 

此处明显遗漏了季节趋势。例如，低估了2月，高估了12月。

### c {-}

我们运行**游程检验**来检查观察值间的依赖关系。


```r
runs(rstudent(hours_quad))
```

```
## $pvalue
## [1] 0.00012
## 
## $observed.runs
## [1] 16
## 
## $expected.runs
## [1] 30.96667
## 
## $n1
## [1] 31
## 
## $n2
## [1] 29
## 
## $k
## [1] 0
```

我们的游程数量多于预期，且在$p = 0.00012$水平上具有显著性检验结果，证实了我们在(b)部分的猜想。

### d {-}

我写的`lat_acf`是一个用于绘制自相关函数（ACF）图的自定义函数，并利用了`TSA`包中的`acf`函数和`lattice`包中的`xyplot`函数。


```r
lat_acf <- function(x, ci = 0.95, drop.lag.0 = FALSE, ...) {
  s <- TSA::acf(x, drop.lag.0 = drop.lag.0, plot = FALSE, ...)

  nser <- ncol(s$lag)

  clim0 <- qnorm((1 + ci) / 2) / sqrt(s$n.used)

  ylim <- range(s$acf[, 1L:nser, 1L:nser], na.rm = TRUE)
  ylim <- range(c(-clim0, clim0, ylim))


  lattice::xyplot(s$acf ~ s$lag, type = "h", xlab = "滞后", ylab = "自相关函数",
                  ylim = ylim * 1.1,
                  panel = function(x, y, ...) {
                    panel.abline(h = c(-clim0, 0, clim0), lty = c(3, 1, 3))
                    panel.xyplot(x, y, ...)
                  })
}
```


```r
lat_acf(rstudent(hours_quad))
```

![(\#fig:hours-acf)小时数数据集的自相关图](chapter3_files/figure-latex/hours-acf-1.pdf) 

图 \@ref(fig:hours-acf) 明确显示了自相关性：前5至6个值之间存在正相关性，之后似乎变为负相关。其中一些值具有显著性。

### e {-}


```r
figa<-qqmath(rstudent(hours_quad), asp = 1,
        xlab = "理论值", ylab = "学生化残差",
        panel = function(x, ...) {
          panel.qqmathline(x, ...)
          panel.qqmath(x, ...)
        })
figb<-densityplot(rstudent(hours_quad), xlab = "学生化残差", 
             ylab = "密度")
gridExtra::grid.arrange(figa, figb, ncol = 2)
```

![(\#fig:normality-test1)正态性检验图](chapter3_files/figure-latex/normality-test1-1.pdf) 

分布呈现出轻尾特征，但除此之外看起来相当接近正态分布。

## 3.11 重新探讨工资

### a {-}


```r
wages_quad <- lm(wages ~ time(wages) + I(time(wages)^2))
pander(summary(wages_quad))
```


--------------------------------------------------------------------
        &nbsp;          Estimate   Std. Error   t value   Pr(>|t|)  
---------------------- ---------- ------------ --------- -----------
   **(Intercept)**       -84950      10191      -8.336    4.865e-12 

   **time(wages)**       85.34       10.27       8.309    5.439e-12 

 **I(time(wages)^2)**   -0.02143    0.002588    -8.282    6.104e-12 
--------------------------------------------------------------------


--------------------------------------------------------------
 Observations   Residual Std. Error   $R^2$    Adjusted $R^2$ 
-------------- --------------------- -------- ----------------
      72              0.05889         0.9864       0.986      
--------------------------------------------------------------

Table: Fitting linear model: wages ~ time(wages) + I(time(wages)^2)

这个二次拟合解释了大量的方差（0.99）。

### b {-}


```r
runs(rstudent(wages_quad))
```

```
## $pvalue
## [1] 1.56e-07
## 
## $observed.runs
## [1] 15
## 
## $expected.runs
## [1] 36.75
## 
## $n1
## [1] 33
## 
## $n2
## [1] 39
## 
## $k
## [1] 0
```

然而，从游程检验的结果可以看出，变量之间存在相互依赖的证据。

### c {-}


```r
lat_acf(rstudent(wages_quad))
```

![(\#fig:wages_acf)基于工资时间序列二次拟合的自相关图](chapter3_files/figure-latex/wages_acf-1.pdf) 

但是，自相关图（图\@ref(fig:wages_acf)）清楚地表明，我们面临着大量的自相关性，显然这是因为我们尚未考虑该时间序列中的季节性趋势。

### d {-}

我们也来看看正态性检验图。


```r
figa <- 
  qqmath(rstudent(wages_quad), xlab = "理论值",
       asp = 1,
       ylab = "学生化残差",
       panel = function(x, ...) {
         panel.qqmathline(x, ...)
         panel.qqmath(x, ...)
       })

figb <- densityplot(rstudent(wages_quad), xlab = "学生化残差",ylab="密度")
gridExtra::grid.arrange(figa, figb, ncol = 2)
```

![(\#fig:wages-norm)采用二次拟合的工资数据正态性检验图](chapter3_files/figure-latex/wages-norm-1.pdf) 

正态性检验图（图\@ref(fig:wages-norm)）表明，残差分布具有一定的重尾性，且略微左偏。

## 3.12 重新探讨啤酒销量

### a {-}

首先，我们收集残差。


```r
# 加载数据集(beersales)
beer_quad_seasonal <- lm(beersales ~ time(beersales) + I(time(beersales)^2) +
                           season(beersales))
beer_resid <- rstudent(beer_quad_seasonal)
```

### b {-}

接下来，我们执行一次游程检验。


```r
runs(beer_resid)
```

```
## $pvalue
## [1] 0.0127
## 
## $observed.runs
## [1] 79
## 
## $expected.runs
## [1] 96.625
## 
## $n1
## [1] 90
## 
## $n2
## [1] 102
## 
## $k
## [1] 0
```

检验结果显著（$p = 0.0127$）。

### c {-}


```r
lat_acf(beer_resid)
```

![(\#fig:beer-acf)啤酒销量模型的自相关图](chapter3_files/figure-latex/beer-acf-1.pdf) 

因为在几个滞后期上相关性显著，这让我们质疑数据的独立性。

### d {-}


```r
figa <- 
  qqmath(beer_resid, xlab = "理论值",
       asp = 1,
       ylab = "学生化残差",
       panel = function(x, ...) {
         panel.qqmathline(x, ...)
         panel.qqmath(x, ...)
       })

figb <- densityplot(beer_resid, xlab = "学生化残差")

gridExtra::grid.arrange(figa, figb, ncol = 2)
```

![(\#fig:beer-norm)经过线性、二次及季节性拟合后的啤酒销量时间序列正态性检验图。](chapter3_files/figure-latex/beer-norm-1.pdf) 

## 3.13 重新探讨温尼贝戈房车数据

### a {-}


```r
winn_resid <- rstudent(winn_fit_seasonal)
```

### b {-}


```r
runs(winn_resid)
```

```
## $pvalue
## [1] 0.000243
## 
## $observed.runs
## [1] 18
## 
## $expected.runs
## [1] 32.71875
## 
## $n1
## [1] 29
## 
## $n2
## [1] 35
## 
## $k
## [1] 0
```

游程检验结果显著。我们得到的游程数目少于预期。

### c {-}


```r
lat_acf(winn_resid)
```

![(\#fig:winn-acf)温尼贝戈房车模型的自相关图。](chapter3_files/figure-latex/winn-acf-1.pdf) 

存在依赖性证据，而目前我们在模型中尚未考虑这一因素。

### d {-}


```r
figa <- 
  qqmath(winn_resid, xlab = "理论值",
       asp = 1,
       ylab = "学生化残差",
       panel = function(x, ...) {
         panel.qqmathline(x, ...)
         panel.qqmath(x, ...)
       })

figb <- densityplot(winn_resid, xlab = "学生化残差",ylab="密度")
gridExtra::grid.arrange(figa, figb, ncol = 2)
```

![(\#fig:winn-norm)经过对数变换和季节性拟合后温尼贝戈房车系列的正态性检验图](chapter3_files/figure-latex/winn-norm-1.pdf) 

存在左偏斜现象，且有一个较大的异常值，但总体上接近正态分布。
