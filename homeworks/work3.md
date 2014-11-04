###Q1. (20%) The probability density P(X=k) of a random variable X ~ Poisson-Tweedie family (α, β, γ) can be calculated through a double recursion algorithm.
The first recursion exists in \\(p_k\\):

\\(
p_0=
\begin{cases}
e^{\beta[(1-\gamma)^\alpha-1]/\alpha},   \alpha \neq 0  \\[2ex]
(1-\gamma)^\beta , \alpha = 0
\end{cases}
\\
p_1=\beta\gamma*p_0
\\

\large p_{k+1}=\frac{1}{k+1}(\beta\gamma*p_k+\sum^{k}_{j=1}j*r_{k+1-j}p_j),k=1,2...
\\)

The second recursion exists in \\(r_j\\):
\\(
r_1=(1-\alpha)\gamma
\\
\large r_{j+1}=(\frac{j-1+\alpha}{j+1})\gamma*r_j,j=1,2...
\\
where \, \alpha \in (\infty,1],\beta \in (0,+\infty],\gamma \in [0,1]
\\)

Write a function PTF that has four inputs (k, a, b, g) (a for α, b for β, and g for γ) and returns pk.
Use the function to calculate PTF(9, -3, 2, 0.5) (The answer should be close to 0.04235).
```r
PTF=function(k,a,b,g){
	p.list=PTF.initList(a,b,g)
	r.list=c(PTF.r0(a,g))
	for(i in 2:k){
		j.list=c(1:(i-1))
		pn=(b*g*p.list[i-1]+sum(rev(r.list)*p.list*j.list))/i		
      # add p to p.list
		p.list[i]=pn
      # add r to r.list
		rn=(i-2+a)/i*g*r.list[i-1]
		r.list[i]=rn	
	}
	tail(p.list,n=1)
}

PTF.initList=function(a,b,g){
	p0=PTF.p0(a,b,g)
	p1=b*g*p0
	c(p1)
}


PTF.p0=function(a,b,g){
	p0=0
	if(a==0){
		p0=(1-g)^b
	}
	else{
		p0=exp(b*((1-g)^a-1)/a)
	}
	p0
}
PTF.r0=function(a,g){
	(1-a)*g
}

PTF(9,-3,2,.5)#0.04235393
```


###Q2. (20%) MLE and Simulation

####(a) For the Bernoulli distribution \\(P(X=x_i|p)=p^{x_i}(1-p)^{1-x_i}\\)
\\(
\large loglik(p)=log(\Pi^n_1{p^{\Sigma^n_{i=1}}(1-p)^{n-\Sigma^n_1x_i} }) \\
\large = \Sigma^n_{i=1}x_ilog p+(n-\Sigma^n_1)log(1-p)
\\)

\\(
\large \frac{d loglik(p)}{d p}=\Sigma^n_{i=1}x_i/p
\\)

(b) Continuing (a), given p=0.5, simulate n=50, n=5000, n=500,000 Bernoulli random numbers.
For each simulated sample of size n, calculate pˆMLE from the sample and compare pˆMLE to the TRUE p=0.5, what have you observed?

####(c) For the exponential distribution \\(f(x_i)=\lambda e^{- \lambda x_i}\\),derive\\(\hat{\lambda}_{MLE}\\) and prove the Markov Property:
 \\(
 \large loglik(\lambda)=log(\Pi^n_1 \lambda e^{-\lambda x_i}) \\
\large =n*log\lambda + (-\lambda\sum^n_1{x_i})\\
\\)

\\(
\large \frac{d loglik(\lambda)}{d \lambda}=n/\lambda-\sum^n_1{x_i}=0 \\
\large  n/\lambda=\sum^n_1{x_i} \\
\large \hat{\lambda}_{MLE}=\frac{n}{\sum^n_1{x_i}}
 \\)

