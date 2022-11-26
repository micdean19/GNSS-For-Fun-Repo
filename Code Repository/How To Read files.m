%This Script can be used to load txtfiles% 
%Note that using "Import" is way easier for simpler txt file%


%Disclaimer: SUPER IMPORTANT THEORY!!!
%Matlab will read every line completely and fully before moving to the next
%one. You can't directly skip lines, nor can you partially read a line.


%Always Clear the workspace, command window, open figures and open file
%streams 
clear;
close all;
clc;
fclose('all');

%First method to load file, Use for simple txtfiles
Data = load("Txtfilename.txt"); %will create a variable called data and create a mxn matrix from txtfile
x = data(:,2); %Very easy to save the individual columns in row vectors.


%2nd Method, to load harder files with comments or words on top then
%numbers later on.

path = 'folder_name';
name 'file_name.txt';
fileName = strcat(path, name);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The next 3 lins are used to setup the reading function fscanf 
%fscanf is for reading ascii and fread is for Binary data.

fstream = fopen(fileName,'r'); %Syntax : ReturnName = fopen(name.txt, 'r'), 

Datatype = '%f'; %indicates that the format be a float everytime
size = [2 1]; %meanign reads 2 numbers (2 cols) for 1 line.!!  USE 1 if only want to save line by line


%note that Datatype is only '%f' in this case but not always true
Formattype1 = '%f %d'; %IDK WHEN WOULD U EVER USE THAT THO...
size2 = [2 Inf]; %size still remains the same? idk why


%Now read data.
A = fscanf(fid,Datatype, size); %A will save 2 numbers from first line 
B = fscanf(fid, Datatype, size); %B will save 2 numbers from 2nd line, unless the first line had more numbers to read in.
fclose(fid); %remember to close!






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Disclaimer: SUPER IMPORTANT THEORY!!!
%Matlab will read every line completely and fully before moving to the next
%one. You can't directly skip lines, nor can you partially read a line.

%1.To split a line in 2, (i.e if 5 5 A B) Read 5 5 using fscan(with tyep
%f) and then read A B (with type char %c or %s).

fid = fopen(filename, 'r');
Firstpartofline = fscanf(fid, '%f', [2 1]); %reads in 5 5 and save it to firstpart..
endpartofline = fscanf(fid, '%s', [2 1]); %reads A B and save it to endpart...


%2.To skip lines then read numbers in. For example in Ply format, there is
%a bunch of lines that are string followed by an array of numbers

fid = fopen('bla.txt','r');
%Advance five lines:
linesToSkip = 5;
for ii = 1:linesToSkip-1
    fgetl(fid);
end

fscanf(fid, type, size); %now read all the remaning data.!!!



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Other possible reading commands 
fread(fid) %or fread(fid,size) to read section of the txtfile. Difference between fread to fscanf is taht there is no format, more limited.
fgetl
fread
textscan

%to read in poitn cloud
ptcloud = pcread('namefile.ply')

%%%%%%%%%%%%%--Use TEXTSCAN, MOST RECENT & USEFUL --%%%%%%%%%%%%%%%%%%%%%%%
%Need 3 things, a fid (file to load), a formatspec (format of file) and
%delimeters

fid = fopen("FileName.txt)
formatspec = ...% Note that %*[^\n] means ignore rest of line 
             ... % and more specifically * before field means dont save it
             ...%|----Header---|Time|_------Other stuffs----|
                '%q%q%n%q%*[^\n]'
            
data.rawinput = textscan(fid,formatspec, "delimeter", ",:", "ReturnOnError",0);
