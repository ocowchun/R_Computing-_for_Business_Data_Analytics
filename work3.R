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


