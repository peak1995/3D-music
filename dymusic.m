function [] = dymusic(dist,elev,flag,circle,step,fs,y)

% dist= 100;
% elev= 10;
% circle=1;
% flag=1;
% step = 5;
if flag==1
    az=0:step:360-step;
else
    az=360-step:-step:0;
end
nlock=360/step;

% [y, fs] = audioread('./muc.wav');

read_path = './PKU-IOA HRTF database/';
n=length(y)/circle;
mus=zeros(circle,n);
for i=1:circle
   mus(i,:)=y((i-1)*n+1:i*n);
end

w_1 = 1/1024:1/1024:1;
w_0 = 1-1/1024:-1/1024:0;
% w_0=0.7;
% w_1=0.3;
HLlist = zeros(nlock, 1024);
HRlist = zeros(nlock, 1024);


for j=1:nlock
%    l=n/nlock;
   hrir_l = readhrir(read_path, dist, elev, az(j), 'l');
   HLlist(j,:)=hrir_l;
   hrir_r = readhrir(read_path, dist, elev, az(j), 'r');
   HRlist(j,:)=hrir_r;
end
data_ll=[];
data_rr=[];
for i=1:circle
    for j=1:nlock
           data_l = conv(mus(i,(j-1)*(n/nlock)+1:(j-1/2)*(n/nlock)), (HLlist(mod(nlock-1+j-1,nlock)+1,:).*w_0+HLlist(mod(nlock-1+j,nlock)+1,:).*w_1),'same');
           data_r = conv(mus(i,(j-1)*(n/nlock)+1:(j-1/2)*(n/nlock)), (HRlist(mod(nlock-1+j-1,nlock)+1,:).*w_0+HRlist(mod(nlock-1+j,nlock)+1,:).*w_1),'same');
           data_ll=[data_ll,data_l];
           data_rr=[data_rr,data_r];
%            sound([data_l', data_r'], fs);
%            pause(length(data_l)/fs);

           data_l = conv(mus(i,(j-1/2)*(n/nlock)+1:j*(n/nlock)), (HLlist(mod(nlock-1+j,nlock)+1,:).*w_0+HLlist(mod(nlock-1+j+1,nlock)+1,:).*w_1),'same');
           data_r = conv(mus(i,(j-1/2)*(n/nlock)+1:j*(n/nlock)), (HRlist(mod(nlock-1+j,nlock)+1,:).*w_0+HRlist(mod(nlock-1+j+1,nlock)+1,:).*w_1),'same');
%            sound([data_l', data_r'],fs);
%            pause(length(data_l)/fs);
           data_ll=[data_ll,data_l];
           data_rr=[data_rr,data_r];
    end
end
    sound([data_ll;data_rr]',fs);
    audiowrite('end.wav',[data_ll;data_rr]',fs);
end

