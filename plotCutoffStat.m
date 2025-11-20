%plot cutoff metrics
cmap = [51 117 56; 93 168 153; 148 203 236; 220 205 125; 194 106 119]/256;%color maps
temp = [cfTheta;cfP;Sinu1;cfRCn1];%cutoff angle, cutof offset, sinuosity, and radius of curvature
ylabelText = {"cutoff angle (degree \circ)","cutoff offset (fraction)","sinuosity (\Omega)","radius of curv*"};
plotLabel = {"c","d","e"};
for i = 1:3
    tempStat = temp(i,:);
    tempSinu1 = tempStat(grps==1);
    tempSinu2 = tempStat(grps==2);
    tempSinu3 = tempStat(grps==3);
    tempSinu4 = tempStat(grps==4);
    tempSinu5 = tempStat(grps==5);
    figure(2);
    subplot(1,3,i);hold on
    violins = violinplot([tempSinu1,tempSinu2,tempSinu3, tempSinu4,tempSinu5]...
        ,grps,'ShowMean', true,...
            'ShowMedian', true,...
            'ViolinAlpha',0.4, 'markersize',3, ...
             'ShowData',false,'QuartileStyle','shadow',...
             'orientation','horizontal',...
             'ViolinColor',cmap(:,:));% 'ViolinColor', [0,114,178]/256,
    yticks([1 2 3 4 5]);
    yticklabels({'Mars','glacial','deepwater','tidal','fluvial'})
    xlabel(ylabelText(i));
    text(.2, .95,plotLabel(i),'unit','normalized','fontsize',9)
    if i == 1 || i ==2
        
        plot([0 0],[0 5.5],':k')
        % plot([4 4],[0 5.5],'-k')

        % set(gca,'xscale','log')
    end
    ylim([0.5,5.5])
    set(gca,'xcolor',[0 0 0],'ycolor','k');
end

%%
figure(3);subplot(1,2,1);hold on
binSize = [10,10,10,10,60];
ax = gca;
ax.Color = 'none';          % Transparent background
ax.XAxis.Visible = 'off';   % Only show x-axis once
ax.YAxis.Visible = 'off';   % Only show x-axis once
grpName = {"Mars","glacial","deepwater","tidal","fluvial"};
for i = 1:5
    temp = cfDn(grps==i);
    % temp(temp<1) = 1;
    % temp = log10(temp);
    % temp = temp/mean(temp);
    ax(i) = axes;  % New axes
    ax(i).Position = [0.08, 0.165*i-0.06, 0.4, 0.14];
    hold(ax(i), 'on');
    h = histogram(temp,binSize(i),'EdgeColor','none','Normalization','pdf',...
        'FaceColor',cmap(i,:));

    pd = fitdist(temp','lognormal');    
    x = 1:0.1:25;
    y = pdf(pd,x);
    [~, idx] = min(abs(x - mean(temp)));
    closest_val = y(idx);
    p2 = plot([mean(temp),mean(temp)],[0 closest_val],':k','LineWidth',1);
    [~, idx] = min(abs(x - median(temp)));
    closest_val = y(idx);
    p3 = plot([median(temp),median(temp)],[0 closest_val],'--k','LineWidth',1);
    p1 = plot(x,y,'-k');



    if i~=1
        set(gca, 'XColor', 'none')
    end
    xlim([0 20])
    % Keep all but the first axes invisible except their y-axis
    if i > 1
        ax(i).Color = 'none';          % Transparent background
        ax(i).XTickLabel = [];   % Only show x-axis once
    end
    if i ==1
        xlabel('normalized cutoff distance')
        legend([p1, p2, p3],{'fit','mean','median'})
    end
    if i ==3
        ylabel('PDF')
    end
    if i == 5
        text(0.02, 0.9,'a','unit','normalized');
    end
    text(0.45, 0.16*i+0.1,grpName(i),'unit','normalized');
    % % Label each y-axis with a different color
    % ax(i).YAxis.Color = colors(i,:);
end

% Link x-axes so zoom/pan is synchronized
linkaxes(ax, 'x');



% cmap = parula(5);
threshold = 2;
for i = 1:5
    figure(3);
    subplot(1,2,2);hold on
    [f,x] = ecdf(cfDn(grps==i));
    plot(x,f,'color',cmap(i,:));
    
    x = x + rand(length(x),1)*1e-5; 
    f_inter = interp1(x,f,2);
    plot([1e-1 2],[f_inter f_inter],':','color',cmap(i,:),'LineWidth',1.5);
end

[f,x] = ecdf(cfDn);
plot(x,f,'--k','LineWidth',2)
set(gca,'xscale','log')

x = x + rand(length(x),1)*1e-5; 
f_inter = interp1(x,f,2);
plot([2 2],[0 1],'-k');
plot([1e-1 2],[f_inter f_inter],'-k','LineWidth',2);

text(0.05, 0.95,'b','unit','normalized');
text(0.05, 0.5,'neck cutoff','unit','normalized');
text(0.65, 0.5,'chute cutoff','unit','normalized');

xlabel('normalized cutoff distance');
ylabel('CDF')


%%
% binSize = [10,10,10,10,30];
% for i = 1:5
%     figure(4);
%     subplot(1,5,i);hold on
%     % [f,x] = ecdf(cfDn(grps==i));
%     p = gkde2([Sinu1(grps==i);cfRCn(grps==i)]);
%     surf(p.x,p.y,p.pdf-10)
%     N = 256; % number of colors
%     cmap = [linspace(1,0,N).' linspace(1,0,N).' ones(N,1)]; % decreasing R and G; B = 1
%     colormap(cmap)
%     view(2)
%     shading interp
%     % % plot([2 2],[0 5],'-k')
%     % % plot([3 3],[0 5],'-k')
%     xlim([0 5])
%     ylim([0 10])
%     figure(5);
%     subplot(1,5,i);hold on
%     plot(1./cfRCn(grps==i),Sinu1(grps==i),'o')
%     % xlim([0 10])
%     set(gca,'xscale','log')
% 
%     % tempRCn = cfRCn(grps==i);
%     % tempSinu = Sinu1(grps==i);
%     % tempSinu = tempSinu (tempRCn>2 & tempRCn<3);
%     % figure(6);
%     % subplot(5,1,6-i);hold on
%     % % violins = violinplot(tempSinu,num2cell(zeros(1,length(tempSInu))),'ShowMean', true,...
%     % %     'ShowMedian', true,...
%     % %     'ViolinAlpha',0.4, 'markersize',3, ...
%     % %      'ShowData',false,'QuartileStyle','shadow',...
%     % %      'orientation','horizontal',...
%     % %      'ViolinColor',cmap(:,:));% 'ViolinColor', [0,114,178]/256,
%     % histogram(tempSinu,binSize(i));
%     % mean(tempSinu)
%     % xlim([1 4]);
% end

