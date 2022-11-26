%************************************************************************ 
% Generic Comparing Data read. Specify file location                      *
%************************************************************************
% Note: Everything is using Matlab Structure Type.
% Data, Figures and even tables are using Struct
clc
clear all
close all


%% ************************* User set variables *******************************
WorkingDirectory = 'C:\Users\michael.ah-kiow\Desktop\2019_10_31 Data\'; % Always end in a '\'
FileName         = "NMPM17510003W_2019-10-31_20-30-45.LOG.ascii";
FileName2         = "NMPM17510002G_2019-10-31_20-30-50.LOG.ascii";
iNumofInputs     = 2;
bSaveThePlots  = true; % true to save .jpg and .fig copies of any output plots in the output dir
%Change Condition Depending on whether want Comparision or Difference
bCompare = true;
bDifference = false;


%% **********Reading Data (Edit FileFormat and Assignment Fields)**********
Data(1).FilePath = strcat(WorkingDirectory, FileName);
Data(2).FilePath = strcat(WorkingDirectory, FileName2);
Data(1).FileHandle = fopen(Data(1).FilePath);
Data(2).FileHandle = fopen(Data(2).FilePath);

%DataFormat
FileFormat = ...
             ...% |Header|Body-------|Crc|
                  "%q%u%f%f%f%f%f%f%f%q"
              
%Assuming 2 files to compare
for i=1:2
    try
        Data(i).input = textscan(Data(i).FileHandle, FileFormat, "delimiter", ",;.", "ReturnOnError", 0);
        Data(i).ReadSuccess = true; %If gets to this line then sucessfully read file
        
        %Not Assign each field based on file. i.e.:
        Data(i).Header = Data(i).input{:,1};
        Data(i).Time = Data(i).input{:,2};
        Data(i).x = Data(i).input{:,3};
        %...etc
    catch
        disp("Error failed to read file: ", num2str(i))
    end
end
     

%% Comparision of the 2 dataset (Change for field and plots)
iPlotNum =0;
if bCompare 
    iPlotNum = iPlotNum +1;
        Plots(iPlotNum).FigHandler = figure();
        Plots(iPlotNum).Title = strcat("Figure: ", num2str(iPlotNum), " Title ");
        hold on; grid on; 
        plot(Data(1).Time, Data(1).x, 'g-');
        plot(Data(2).Time, Data(2).y, 'b-*');
        xlabel("GPS Time(s)");
        ylabel('Y-Label');
        legend('Data1', 'Data2')
        
     iPlotNum = iPlotNum +1;
        Plots(iPlotNum).FigHandler = figure();
        Plots(iPlotNum).Title = strcat("Figure: ", num2str(iPlotNum), " Title ");
        hold on; grid on; 
        plot(Data(1).Time, Data(1).x, 'g-');
        plot(Data(2).Time, Data(2).x, 'b-*');
        xlabel("GPS Time(s)");
        ylabel('Y-Label');
        legend('Data1', 'Data2');
       
        
    
end

%% Differences between dataset
if bDifference
    iPlotNum = iPlotNum +1;
        Plots(iPlotNum).FigHandler = figure();
        Plots(iPlotNum).Title = strcat("Figure: ", num2str(iPlotNum), " Title ");
        hold on; grid on; 
        plot(Data(1).Time, Data(1).x-Data(2).x, 'g-');
%         plot(Data(1).Time, Data(1).x, 'g-');
%         plot(Data(2).Time, Data(2).y, 'b-*');
        xlabel("GPS Time(s)");
        ylabel('Y-Label');
        legend('Data1', 'Data2')
end

