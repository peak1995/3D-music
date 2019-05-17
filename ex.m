dist= 100;
elev= 0;
step = 5;
az=0:step:360-step;
circle=3;
nlock=360/step;

[y, fs] = audioread('./muc.wav');
read_path = './PKU-IOA HRTF database/';
n=length(y)/circle;
mus=zeros(circle,n);
for i=1:circle
   mus(i,:)=y((i-1)*n+1:(i*n));
end
HLlist = zeros(1024,nlock);
HRlist = zeros(1024,nlock);


for j=1:nlock
%    l=n/nlock;
   hrir_l = readhrir(read_path, dist, elev, az(j), 'l');
   HLlist(:,j)=hrir_l;
   hrir_r = readhrir(read_path, dist, elev, az(j), 'r');
   HRlist(:,j)=hrir_r;
end
data_ll=[];
data_rr=[];
for i=1:circle
    for j=1:nlock
           data_l = conv(mus(i,(j-1)*floor(n/nlock)+1:j*floor(n/nlock)), HLlist(:,j)','same');
           data_r = conv(mus(i,(j-1)*floor(n/nlock)+1:j*floor(n/nlock)), HRlist(:,j)','same');
%            sound([data_l', data_r'], fs);
%            pause(length(data_l)/fs);
           data_ll=[data_ll,data_l];
           data_rr=[data_rr,data_r];
    end
end
sound([data_ll;data_rr]',fs);

