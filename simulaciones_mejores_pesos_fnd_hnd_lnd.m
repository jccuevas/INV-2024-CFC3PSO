
clear
nodos=100

%
for set=315:315

stop=0.1
path=sprintf('%d',nodos);




cd(path);



fichero=sprintf('resultados_%d_pesos_mejor_fnd_hnd_lnd.mat',set);
%load(fichero);
if exist(fichero)
%load(fichero);

cd ..

else

cd ..

%fis_fnd = readfis('kb_wsn-fnd.fis');
%%fis_hnd= readfis('kb_wsn-fnd-hnd.fis');
%fis_hnd= readfis('kb_wsn_tras_fnd_hnd.fis');
%fis_lnd= readfis('kb_wsn_tras_fnd_hnd_lnd.fis');

%%fis_fnd = readfis('kb/303/kb_wsn-303_tras_FND.fis');
%%fis_hnd= readfis('kb/303/kb_wsn-303_tras_fnd_hnd.fis');
%%fis_lnd= readfis('kb/303/kb_wsn-303_tras_fnd_hnd_lnd.fis');

fis_fnd = readfis('kb/315/kb_wsn-315_tras_FND.fis');
fis_hnd= readfis('kb/315/kb_wsn-315_tras_fnd_hnd.fis');
fis_lnd= readfis('kb/315/kb_wsn-315_tras_fnd_hnd_lnd.fis');


for nmap=11:40,
    [FNDpesos_mejor_fnd_hnd_lnd(nmap-10) HNDpesos_mejor_fnd_hnd_lnd(nmap-10) LNDpesos_mejor_fnd_hnd_lnd(nmap-10) ] = kb_wsn_fnd_hnd_lnd(set,nmap,stop,0.05,fis_fnd,fis_hnd,fis_lnd);
    
end

cd(path);
save(fichero)

cd ..
end
end
