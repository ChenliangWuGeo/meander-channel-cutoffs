%compile cutoff metrics from all systems        
%preallocate for metrics
Sinu1 = [];%bend sinuosity for the bend where chute entrance is located
Sinu2 = [];
cfP = [];%cutoff offset
cfDn = [];%cutoff distance, normalized
cfTheta = [];%cutoff angle
cfSk = [];
cfRC1 = [];
cfRC2 = [];
B = [];%channel width
cfRCn1 = [];
cfRCn2 = [];

%Mars
load ("cutoffMarsAll2.mat")
temp = cutoffLoca;
tempSinu1 = [temp.sinu1];
Sinu1 = [Sinu1,tempSinu1];
tempSinu2 = [temp.sinu2];
Sinu2 = [Sinu2,tempSinu2];       % combinedCutLoca = [combinedCutLoca, loadedData.cutoffLoca];
tempcfP = [temp.cfP];
cfP = [cfP,tempcfP];       % combinedCutLoca = [combinedCutLoca, loadedData.cutoffLoca];
tempcfDn = [temp.cfDn];
cfDn = [cfDn,tempcfDn];
tempTheta = [temp.theta];
cfTheta = [cfTheta, tempTheta];
tempSk = [temp.cfSk];
cfSk = [cfSk, tempSk];
noMars = length(tempcfDn);
tempRC1 = [temp.cfRC1];
cfRC1 = [cfRC1, tempRC1];
tempRC2 = [temp.cfRC2];
cfRC2 = [cfRC2, tempRC2];
a = length(temp);
for i = 1:a
    temp(i).cfRCn1 = temp(i).cfRC1/temp(i).B;
    temp(i).cfRCn2 = temp(i).cfRC2/temp(i).B;
end
tempRCn1 = [temp.cfRCn1];
cfRCn1 = [cfRCn1, tempRCn1];
tempRCn2 = [temp.cfRCn2];
cfRCn2 = [cfRCn2, tempRCn2];

clearvars cutoffLoca

%ice streams
load ("cutoffStat_IceAll2.mat")
temp = cutoffLoca;
tempSinu1 = [temp.sinu1];
Sinu1 = [Sinu1,tempSinu1];
tempSinu2 = [temp.sinu2];
Sinu2 = [Sinu2,tempSinu2];       % combinedCutLoca = [combinedCutLoca, loadedData.cutoffLoca];
tempcfP = [temp.cfP];
cfP = [cfP,tempcfP];       % combinedCutLoca = [combinedCutLoca, loadedData.cutoffLoca];
tempcfDn = [temp.cfDn];
cfDn = [cfDn,tempcfDn];
tempTheta = [temp.theta];
cfTheta = [cfTheta, tempTheta];
tempSk = [temp.cfSk];
cfSk = [cfSk, tempSk];
noIce = length(tempcfDn);
tempRC1 = [temp.cfRC1];
cfRC1 = [cfRC1, tempRC1];
tempRC2 = [temp.cfRC2];
cfRC2 = [cfRC2, tempRC2];
a = length(temp);
for i = 1:a
    temp(i).cfRCn1 = temp(i).cfRC1/temp(i).B;
    temp(i).cfRCn2 = temp(i).cfRC2/temp(i).B;
end
tempRCn1 = [temp.cfRCn1];
cfRCn1 = [cfRCn1, tempRCn1];
tempRCn2 = [temp.cfRCn2];
cfRCn2 = [cfRCn2, tempRCn2];
clearvars cutoffLoca

%deepwater
load ("cutoffDeepwaterAll.mat")
temp = cutoffLoca;
tempSinu1 = [temp.sinu1];
Sinu1 = [Sinu1,tempSinu1];
tempSinu2 = [temp.sinu2];
Sinu2 = [Sinu2,tempSinu2];       % combinedCutLoca = [combinedCutLoca, loadedData.cutoffLoca];
tempcfP = [temp.cfP];
cfP = [cfP,tempcfP];       % combinedCutLoca = [combinedCutLoca, loadedData.cutoffLoca];
tempcfDn = [temp.cfDn];
cfDn = [cfDn,tempcfDn];
tempTheta = [temp.theta];
cfTheta = [cfTheta, tempTheta];
tempSk = [temp.cfSk];
cfSk = [cfSk, tempSk];
noDeepwater = length(tempcfDn);
tempRC1 = [temp.cfRC1];
cfRC1 = [cfRC1, tempRC1];
tempRC2 = [temp.cfRC2];
cfRC2 = [cfRC2, tempRC2];
a = length(temp);
for i = 1:a
    temp(i).cfRCn1 = temp(i).cfRC1/temp(i).B;
    temp(i).cfRCn2 = temp(i).cfRC2/temp(i).B;
end
tempRCn1 = [temp.cfRCn1];
cfRCn1 = [cfRCn1, tempRCn1];
tempRCn2 = [temp.cfRCn2];
cfRCn2 = [cfRCn2, tempRCn2];
clearvars cutoffLoca

%tidal
load ("cutoffStat_Tidal_All2.mat")
temp = cutoffLoca;
tempSinu1 = [temp.sinu1];
Sinu1 = [Sinu1,tempSinu1];
tempSinu2 = [temp.sinu2];
Sinu2 = [Sinu2,tempSinu2];       % combinedCutLoca = [combinedCutLoca, loadedData.cutoffLoca];
tempcfP = [temp.cfP];
cfP = [cfP,tempcfP];       % combinedCutLoca = [combinedCutLoca, loadedData.cutoffLoca];
tempcfDn = [temp.cfDn];
cfDn = [cfDn,tempcfDn];
tempTheta = [temp.theta];
cfTheta = [cfTheta, tempTheta];
tempSk = [temp.cfSk];
cfSk = [cfSk, tempSk];
noTidal = length(tempcfDn);
tempRC1 = [temp.cfRC1];
cfRC1 = [cfRC1, tempRC1];
tempRC2 = [temp.cfRC2];
cfRC2 = [cfRC2, tempRC2];
a = length(temp);
for i = 1:a
    temp(i).cfRCn1 = temp(i).cfRC1/temp(i).B;
    temp(i).cfRCn2 = temp(i).cfRC2/temp(i).B;
end
tempRCn1 = [temp.cfRCn1];
cfRCn1 = [cfRCn1, tempRCn1];
tempRCn2 = [temp.cfRCn2];
cfRCn2 = [cfRCn2, tempRCn2];
clearvars cutoffLoca

%fluvial
load ("cutoffAllRivers5.mat")
temp = cutoffLoca;
tempSinu1 = [temp.sinu1];
Sinu1 = [Sinu1,tempSinu1];
tempSinu2 = [temp.sinu2];
Sinu2 = [Sinu2,tempSinu2];       % combinedCutLoca = [combinedCutLoca, loadedData.cutoffLoca];
tempcfP = [temp.cfP];
cfP = [cfP,tempcfP];       % combinedCutLoca = [combinedCutLoca, loadedData.cutoffLoca];
tempcfDn = [temp.cfDn];
cfDn = [cfDn,tempcfDn];
tempTheta = [temp.theta];
cfTheta = [cfTheta, tempTheta];
tempSk = [temp.cfSk];
cfSk = [cfSk, tempSk];
noFluvial = length(tempcfDn);
tempRC1 = [temp.cfRC1];
cfRC1 = [cfRC1, tempRC1];
tempRC2 = [temp.cfRC2];
cfRC2 = [cfRC2, tempRC2];
a = length(temp);
for i = 1:a
    temp(i).cfRCn1 = temp(i).cfRC1/temp(i).B;
    temp(i).cfRCn2 = temp(i).cfRC2/temp(i).B;
end
tempRCn1 = [temp.cfRCn1];
cfRCn1 = [cfRCn1, tempRCn1];
tempRCn2 = [temp.cfRCn2];
cfRCn2 = [cfRCn2, tempRCn2];
clearvars cutoffLoca

%grouping systems
grps = [ones(1,noMars),ones(1,noIce)*2, ones(1,noDeepwater)*3,...
    ones(1,noTidal)*4,ones(1,noFluvial)*5];


