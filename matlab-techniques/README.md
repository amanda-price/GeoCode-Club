**Empirical Distributions**

```matlab
	corg = load(‘organicmatter_one.txt’);
	plot(corg,zeros(1,length(corg)),’o’);
```

Histograms are a much more convenient way to display univariate data
```matlab
	hist(corg)
```

By default, matlab devides the range into ten equal intervals
The midpoint default intervals v  and # of obs n can be accessed using:
```matlab
	[n,v] = hist(corg);
```
For practical purposes, # of classes !< 6 and !> 15
In practice the square root of the number of observations rounded to the nearest integer is often used
```matlab
	hist(corg,8)
```
we can even define the midpoint values. It is recommended to choose interval endpoints to avoid data pts falling in between two intervals. 
To find max/min:
```matlab
	max(corg)
	min(corg)
```
We can also find the range and divide by the 8 classes:
```matlab
	range(corg)/8
```
So now we can define the midpoints as start:interval:end
```matlab
	v = 10 : 0.65 : 14.55
	hist(corg,v);
	n = hist(corg,v);
```matlab
To describe the distribution average and dispersion of the average
Arithmetic mean and median:
```matlab
	mean(corg)
	mean(corg)
```
Percentiles
```matlab
	prctile(corg,[25 50 75])
```
Matlab does not have a function for mode, so to use mode we use find function to find the midpoint with the highest frequency
```matlab
	v(find(n == max(n)))
```
This simply identifies the largest elements in n.

Box and whisker plot
```matlab
	boxplot(corg)
```

Variance
```matlab
	var(corg)
```

Standard deviation
```matlab
	std(corg)
```

Skewness describes the shape of the distribution (negative)
```matlab
	skewness(corg)
```
Peakedness of the distribution is described by kurtosis
```matlab
	kurtosis(corg)
```
which suggests that our distribution is slightly flatter than a Gaussian since it is less than 3
To illustrate the use of gaps like nanmean and nanstd
```matlab
	corg(25,1) = NaN
	mean(corg)
	nanmean(corg)
```

nanmean simply skips the missing value and computes the mean of the data. Second example: significant skew. 120 microprobe analyses of glass shards hand picked from volcanic ash. The glass has been affected by chemical weather in an intial stage. 
```matlab
	sodium = load('sodiumcontent.txt');
hist(sodium,11) 
[n,v] = hist(sodium,11);
```

Theres a significant negative skew, so the mean, median and mode will be different
```matlab
	mean(sodium)
	median(sodium)
	v(find(n == max(n)))
```
The mean is lower than the median, which is lower than the mode. Strong negative skew
```matlab
	skewness(sodium)
```

Now we introduce outlier to the data and explore its effect. 
```matlab
	sodium = load('sodiumcontent_two.txt');
```

Only 50 measurements, so its easier to illustrate the outlier data. Check its histogram, mean, median and mode.
Now we introduce one single value of 1.5 wt% in addition to the 50 measurements contained in the original data set. 
```matlab
	sodium(51,1) = 1.5;
```

Check the histogram, and its influence on the histogram, mean, median and mode. 


**Theoretical Distributions**

randtool creates a histogram of random numbers from the distributions in the Statistics Toolbox. 
```matlab
	randtool
```

Set the mean (Mu) and standard deviation (Sigma) similar to the *organicmatter_one.txt* (normal distribution, 60 samples, mu = 12.3448, sigma=1.1660). Looks similar to the first one.
Instead of simulating discrete distribitions, we can make a PDF or CDF using *normpdf(x,mu,sigma)* and *normcdf(x,mu,sigma)*
```matlab
	x = 9 : 0.1 : 15; 
	pdf = normpdf(x,12.3448,1.1660); 
	cdf = normcdf(x,12.3448,1.1660); 
	plot(x,pdf,x,cdf)
```
You can do this graphically with *disttool*


**The t-Test**

Uses the function *ttest2*
```matlab
	clear 
	load('organicmatter_two.mat');
```
The binary file *organicmatter_two.mat* contains two data sets *corg1* and *corg2*. First, we plot both histograms in one single graph 
```matlab
	[n1,x1] = hist(corg1); 
	[n2,x2] = hist(corg2); 

	h1 = bar(x1,n1); 
	hold on 
	h2 = bar(x2,n2); 

	set(h1,'FaceColor','none','EdgeColor','r') 
	set(h2,'FaceColor','none','EdgeColor','b')
```

Here we use the command *set* to change graphic objects of the bar plots h1 and h2, such as the face and edge colors of the bars. Now we apply the function ttest2(x,y,alpha) to the two independent samples corg1 and corg2 at an alpha=0.05 or 5% significance level. 
```matlab
	[h,significance,ci] = ttest2(corg1,corg2,0.05)
```
The result h=0 means that you cannot reject the null hypothesis without another cause at a 5% significance level. The signifi cance of 0.0745 means that by chance you would have observed more extreme values of t than the one in the example in 745 of 10,000 similar experiments. A 95% confidence interval on the mean is [–0.0433 0.9053], which includes the theoretical (and hypothesized) difference of 0.2.

The second synthetic example shows the performance of the t-test on very different distributions in the means.
```matlab
	clear
	load('organicmatter_three.mat');
  ```
This file again contains two data sets corg1 and corg2. The t-test at a 5% significance level 
```matlab
	[h,significance,ci] = ttest2(corg1,corg2,0.05)
```
The result h=1 suggests that you can reject the null hypothesis. The significance is extremely low and very close to zero. The 95% confidence interval on the mean is [0.7011 1.7086], which again includes the theoretical (and hypothesized) difference of 1.2.


**The F-Test**
```matlab
	load('organicmatter_four.mat');
```

The quantity F is the quotient between the larger and the smaller variance.
First, we compute the standard deviations, where  
```matlab
	s1 = std(corg1)
	s2 = std(corg2)
```
The F-distribution has two parameters, df1 and df2, which are the numbers of observations of both distributions reduced by one, where
```matlab
	df1 = length(corg1) - 1
	df2 = length(corg2) - 1
```
Next we sort the standard deviations by their absolute value,
```matlab
	if s1 > s2
	 slarger = s1
	 ssmaller = s2
	else
	 slarger = s2
	 ssmaller = s1
	end
```
Now we compare the calculated F with the critical F. This can be accomplished using the function finv on a 95% signifi cance level. The function *finv* returns the inverse of the F distribution function with df1 and df2 degrees of freedom, at the value of 0.95. Typing
```matlab
Freal = slarger^2 / ssmaller^2
Ftable = finv(0.95,df1,df2)
```
The F calculated from the data is smaller than the critical F. Therefore, we cannot reject the null hypothesis without another cause. We conclude that the variances are identical on a 95% significance level. We now apply this test to two distributions with very different standard
deviations, 2.0 and 1.2.
```matlab
	load('organicmatter_five.mat');
```
We compare the calculated F with the critical F at a 95% signifi cance level. The critical F can be computed using the function finv. We again type
```matlab
	s1 = std(corg1);
	s2 = std(corg2);
	df1 = length(corg1) - 1;
	df2 = length(corg2) - 1;
	if s1 > s2
	 slarger = s1;
	 ssmaller = s2;
	else
	 slarger = s2;
	 ssmaller = s1;
	end
	Freal = slarger^2 / ssmaller^2
	Ftable = finv(0.95,df1,df2)
```
The F calculated from the data is now larger than the critical F. Therefore, we can reject the null hypothesis. The variances are different on a 95% significance level. 

**The χ2-Test**
```matlab
	corg = load('organicmatter_one.txt');
	v = 10 : 0.65 : 14.55;
	n_exp = hist(corg,v);
```
We use the function normpdf to create the synthetic frequency distribution n_syn with a mean of 12.3448 and a standard deviation of 1.1660.
```matlab
	n_syn = normpdf(v,12.3448,1.1660);
```
The data need to be scaled so that they are similar to the original data set.
```matlab
	n_syn = n_syn ./ sum(n_syn);
	n_syn = sum(n_exp) * n_syn;
```
The fi rst line normalizes n_syn to a total of one. The second command scales n_syn to the sum of n_exp. We can display both histograms for comparison.
```matlab
	subplot(1,2,1), bar(v,n_syn,'r')
	subplot(1,2,2), bar(v,n_exp,'b')
```
Visual inspection of these plots reveals that they are similar. However, it is advisable to use a more quantitative approach. The χ2-test explores the squared differences between the observed and expected frequencies
 ```matlab
 	chi2 = sum((n_exp - n_syn).^2 ./ n_syn)
 ```
The critical χ2 can be calculated using chi2inv. The χ2-test requires the degrees of freedom Φ. In our example, we test the hypothesis that the data are gaussian distributed, i.e., we estimate two parameters μ and σ. The number of degrees of freedom is Φ = 8– (2+1)= 5. We test our hypothesis on a p = 95% signifi cance level. The function chi2inv computes the inverse of the χ2 CDF with parameters specifi ed by Φ for the corresponding probabilities in p.
```matlab
	chi2inv(0.95,5)
```
The critical χ2 of 11.0705 is well above the measured χ2 of 2.1685. Therefore, we cannot reject the null hypothesis. Hence, we conclude that our data follow a gaussian distribution.
