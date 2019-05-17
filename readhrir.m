function hrir = readhrir(filepath, dist, elev, azi, lr)
% writen by Zhen Xiao
% Copyright by Key Lab of Machine Perception (Ministry of Education), Peking University 2007-12-05
% read Qu-HRTF database
% filepath is the path of the database
% dist is the distance£¬including 20 30 40 50 75 100 130 160
% elev is the elevation, value from -40 to 90 in step of 10
% azi is the azimulth, value form 0 to 355 in step of 5 (elev <= 50), from 0 to 350 in step of 10 (elev == 60), form 0 to 345 in step of 15 (elev == 70), from 0 to 330 in step of 30(elev == 80), and 0(elev == 90)
% lr represent the data form right ear or left ear. lr == l means left, and lr == r means right and lr == lr means both.
% the length of each HRIR is 1024 points.

if nargin ~= 5
    error('Wrong number of input arguments')
end;
filename = [filepath, 'dist', int2str(dist), '/elev', int2str(elev), '/azi', int2str(azi), '_elev', int2str(elev), '_dist', int2str(dist), '.dat'];
p = fopen(filename,'r');
if lr == 'l'
    hrir = fread(p, 1024, 'double');
else if lr == 'r'
        fseek(p,1024*8,'bof');
        hrir = fread(p, 1024, 'double');
    else
        hrir = fread(p, 'double');
        hrir = reshape(hrir, 1024, 2);
    end;
end;
fclose(p);