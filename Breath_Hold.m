clc
clear all
close all

% fs=200;
% fc=0.5;
% t=0:0.1:10;
% a=5;
% x=a*sin(2*pi*fc*t);
% x(47:65)=5*rand(1,19,'single');
% x=movmean(x,5);

fs=30;
load('C:\Users\Allan\Desktop\JRF\Depth_Arduino\Allan_Belt_6.mat')
% Filter(55:100)=0.77+(0.7719-0.77).*rand(46,1);
x=Force;
% x=Force;
x=movmean(x,3);
t=linspace(0,50,length(x));
plot(t,x)
j=1;
k=1;
l=1;
s=1;
temp=zeros(1,5);
PEAK_FLAG=0;
VALLEY_FLAG=0;
HOLD_FLAG=0;
RET_FLAG=0;

%find slope
for i=2:length(x)
    con=(x(i)-x(i-1));
    d(i)=sign(con);
    RET_FLAG(i)=0;
    if length(d)>=length(temp)
        temp(5)=0;
        temp=circshift(temp,1);
        temp(1)=d(i);

        if sum(temp)<=3 & sum(temp)>=-3 & not(ismember(0,any(temp,1)))
            if x(i)<(mean(x(1:i)))
                hold(l)=i;
                HOLD_FLAG=1;
                RET_FLAG(i)=1;
                new=diff(hold);
                tf=new>5;
                idx=find(tf);
                x1=size(idx);
                l=l+1;
                end
        end
    end
    if length(RET_FLAG)>=4
        if RET_FLAG(i)==1 & RET_FLAG(i-4)==1
            hold_ind=i;
            new_hold(s)=i;
            s=s+1;
        end
    end
   

    if d(i)~=d(i-1)
        if d(i)==-1
            if x(i-1)>mean(x) & VALLEY_FLAG==0 
                peak(j)=i-1;
                j=j+1;
                PEAK_FLAG=0;
                VALLEY_FLAG=1;
            end
        else if d(i)==1
                if x(i-1)<mean(x) & PEAK_FLAG==0 & VALLEY_FLAG==1
                    valley(k)=i-1;
                    PEAK_FLAG=1;
                    VALLEY_FLAG=0;
                    k=k+1;
                end
        end
    end
    end
end
        
figure(2)
plot(t,x)
hold on
plot(t(new_hold),x(new_hold),'*')
plot(t(peak),x(peak),'x')
plot(t(valley),x(valley),'o')    

fprintf('breath retention start time is : %i\n',t(new_hold(1)));
for i=2:length(new_hold)
    if new_hold(i)-new_hold(i-1)<10
        continue
    else
        fprintf('breath retention end time is : %i\n',t(new_hold(i-1)));
        fprintf('next breath retention start time is : %d\n',t(new_hold(i)));
        
    end
end
