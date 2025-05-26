clear;
clc;
load('dispersion.mat');


%% Normalize and Plot Dispersion
E2sph1=E2sph';
E2sph_norm=zeros(length(f),length(theta));
for i1=1:1:length(f)
   norm=sum(E2sph1(i1,:));
   E2sph_norm(i1,:)=E2sph1(i1,:)./norm;
end
c=2.99792458e17; %[nm/s]
lambda=c./f;
Energy=f*1e-12*4.13567e-3;
% Interpolate to fix nonlinearities in mesh
[T,L]=meshgrid(theta,lambda);
theta_int=linspace(min(theta),max(theta),1001);
lambda_int=linspace(min(lambda),max(lambda),1000);
[Ti,Li]=meshgrid(theta_int,lambda_int);

E2sph_int=griddata(T,L,E2sph_norm,Ti,Li);

fig=figure;
fig.Units='centimeters';
fig.Position=[10 10 8.5 8.5];

%subplot(1,2,1)
imagesc(theta_int,lambda_int,E2sph_int);
colormap('jet')
set(gca,'YDir','normal','TickLength',[0.01 0.01],...
    'TickDir','out','FontSize',7,'XTick',-30:10:30)
xlim([-30 30])
xlabel('\theta [degrees]','FontSize',9,'FontName','Times New Roman')
ylabel('\lambda [nm]','FontSize',9,'FontName','Times New Roman')


%subplot(1,2,2)
% plot(theta_int,E2sph_int(250,:),theta_int,E2sph_int(500,:),theta_int,E2sph_int(750,:),'LineWidth',1.5);
% set(gca,'YDir','normal','TickLength',[0.01 0.01],...
%     'TickDir','out','FontSize',7,'XTick',-30:10:30,...
%     'YAxisLocation','left')
% xlim([-30 30])
% xlabel('\theta [degrees]','FontSize',9,'FontName','Times New Roman')
% ylabel('I(\theta,\pi/2) [a.u]','FontSize',9,'FontName','Times New Roman')
% [l,oh,~,~]=legend(['\lambda=',num2str(round(lambda_int(250))),' nm'],...
%         ['\lambda=',num2str(round(lambda_int(500))),' nm'],...
%         ['\lambda=',num2str(round(lambda_int(750))),' nm']);
% set(oh,'LineWidth',1.5)
% l.FontSize=4;
% l.Box='off';
% oh(4).XData=[0.45 0.55];
% oh(6).XData=[0.45 0.55];
% oh(8).XData=[0.45 0.55];    