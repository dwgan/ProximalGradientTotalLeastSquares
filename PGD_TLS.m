function x=PGD_TLS(A,b,N,lam,mu0,ni)
AA=A'*A;
Ab=A'*b;
x0=zeros(N,1);
g=-2*Ab;
x=wthresh(-mu0*g,'s',mu0*lam);
y=1/(x'*x+1);
c=y*norm(A*x-b)^2;
for nn=1:ni
    g0=g;
    c0=c;
    g=2*y*(AA*x-Ab-c0*x);
    if (x-x0)'*(g-g0)==0
        mu=mu0;
    else
        mus=((x-x0)'*(x-x0))/((x-x0)'*(g-g0));
        mum=((x-x0)'*(g-g0))/((g-g0)'*(g-g0));
        if mum/mus>.5
            mu=mum;
        else
            mu=mus-mum/2;
        end
        if mu<=0
            mu=mu0;
        end
    end
    while 1
        z=wthresh(x-mu*g,'s',mu*lam);
        y=1/(z'*z+1);
        c=y*norm(A*z-b)^2;
        if c<=c0+(z-x)'*g+norm(z-x)^2/(2*mu)
            break
        end
        mu=mu/2;
    end
    mu0=mu;
    x0=x;
    x=z;
end
